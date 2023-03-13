function [wave, M] = objectWave( datafile, Zobj, initSet, fname, ox, oy)
global SVFOLDER
global SVF




% �f�[�^�T�C�Y�͂Q�ׂ̂���ɂ���
X = initSet.HCCDY;
Y = initSet.HCCDX;
hx = initSet.HCCDdy; %1920*1080����5.4��m�Ɏw��(�z���O�����ʂ̈��f�̑傫��)
hy = initSet.HCCDdx;
dx = initSet.CCDdy;
dy = initSet.CCDdx;
Lx = initSet.CCDY;
Ly = initSet.CCDX;

x0 = -Lx/2.*dx + ((ox-1).*dx); 
y0 = -Ly/2.*dy + ((oy-1).*dy);

%%% ���͉摜
im = double(imread([datafile.FOLDER datafile.name]))/255;
M = length(im);	% �摜�T�C�Y

k = 2.*pi/initSet.lamda;
wavefront = zeros(X,Y);


% ������ ����͂X�U�~�X�U��f�Ȃ̂Ŏ��͂ɂO�𖄂߂�
img=zeros(Lx,Ly);
img(Lx/2-M/2+1:Lx/2+M/2,Ly/2-M/2+1:Ly/2+M/2) = im;
if img(ox,oy) ~= 0
    for cx= 1:X
        for cy = 1:Y
            x1 = -X/2.*hx + ((cx-1).*hx); 
            y1 = -Y/2.*hy + ((cy-1).*hy);

            r = sqrt(power((x0 - x1),2)+power((y0 - y1),2)+power(Zobj,2));
            wavefront(cx,cy) = wavefront(cx,cy) + 1 / r .* exp(1i .* k .* r);	%( -1i .* (k0.*ri +pi/3) );
        end
    end

wavefront = (-1i.*k/2.*pi) * wavefront;

%wave.WAVE = wavefront / max(abs(wavefront(:)));
wave.WAVE = wavefront;
wave.Z = Zobj;











%if img(dx,dy) ~= 0
    
%    Pwave.PHSshift = 0;

%    Pwave.Z  = Zobj;
%    Pwave.OX = dy - (N/2);	Pwave.OY = dx - (N/2);

%    Pwave.amp = 2 * exp(1i * (Pwave.PHSshift) );

%	twaveData = waveSphereINI( initSet, Pwave );

	%====================================================================
	% �Đ����𒆉��ɃV�t�g������ʑ������������ł����Ă���
	% 3�����ɍ��W�n�ł́A(X,Y,Z)=(rsinQcosP,rsinQcosP,rcosQ)���A
	% ���ʔg�̌��_�̕�������̕��ʔg���l����
	%====================================================================
%	dx = initSet.CCDdx;
%	dy = initSet.CCDdy;
%	k  = 2*pi/initSet.lamda;	
%	OX = Pwave.OX;
%	OY = Pwave.OY;
%	PP = atan2(OY,OX);
%	QQ = acos( (Pwave.Z)/sqrt( (OX*dx).^2 + (OY*dy).^2 + (Pwave.Z).^2) );
%	shiftPhase = exp( 1i * k * sin(QQ) * ( initSet.SX*dx*cos(PP) + initSet.SY*dy*sin(PP) ));

%    Pwave.WAVE = twaveData;
%    Pwave.spatialShiftPhase = shiftPhase;



%    im=zeros(N,N);

    
%    im(dx,dy) = img(dx, dy);

    % ���̔g�̕��f�U���C�����ʑ��΁^�R
%    im = sqrt( im ) .* exp( 1i * pi/3 );
    % im = sqrt( im ) .* exp( 1i * 2*pi * convn(rand(size(im)),ones(3,3)/9,'same') );	% �����_���ʑ�

%    		figure;	imshow(real(im),[],'InitialMagnification','fit');	axis on;	colorbar;

    %------------------
    % �t���l���ϊ�
    %------------------
%    wavefront = FResT( im, Zobj, initSet, initSet.FRT_METHOD, 'same' );
    
    %%% �U�����P�ɂ��܂�
%    Pwave.WAVE = twaveData / max(abs(twaveData(:)));
%    Pwave.WAVE = wavefront;
    
    % �Đ�����
%    Pwave.Z = Zobj;
%    disp(['�Đ����������ݒ聡���܂��I z = ' num2str(wave.Z) ' [m]']);
    
%    		showWaveRealImagAbsAngle( wave.WAVE, 'objWave' );	
	
    		if nargin > 3		
    			save([SVFOLDER SVF fname '.mat'],'wave');
            end
else
    M = -1;
    wave.WAVE = 1;
    wave.Z = -1;
end
