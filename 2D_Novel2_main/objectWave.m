function [wave, M] = objectWave( datafile, Zobj, initSet, fname, ox, oy)
global SVFOLDER
global SVF




% データサイズは２のべき乗にする
X = initSet.HCCDY;
Y = initSet.HCCDX;
hx = initSet.HCCDdy; %1920*1080時は5.4μmに指定(ホログラム面の一画素の大きさ)
hy = initSet.HCCDdx;
dx = initSet.CCDdy;
dy = initSet.CCDdx;
Lx = initSet.CCDY;
Ly = initSet.CCDX;

x0 = -Lx/2.*dx + ((ox-1).*dx); 
y0 = -Ly/2.*dy + ((oy-1).*dy);

%%% 入力画像
im = double(imread([datafile.FOLDER datafile.name]))/255;
M = length(im);	% 画像サイズ

k = 2.*pi/initSet.lamda;
wavefront = zeros(X,Y);


% ◆◆◆ 今回は９６×９６画素なので周囲に０を埋める
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
	% 再生像を中央にシフトさせる位相成分をここでつくっておく
	% 3次元極座標系では、(X,Y,Z)=(rsinQcosP,rsinQcosP,rcosQ)より、
	% 球面波の原点の方向からの平面波を考える
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

    % 物体波の複素振幅，初期位相π／３
%    im = sqrt( im ) .* exp( 1i * pi/3 );
    % im = sqrt( im ) .* exp( 1i * 2*pi * convn(rand(size(im)),ones(3,3)/9,'same') );	% ランダム位相

%    		figure;	imshow(real(im),[],'InitialMagnification','fit');	axis on;	colorbar;

    %------------------
    % フレネル変換
    %------------------
%    wavefront = FResT( im, Zobj, initSet, initSet.FRT_METHOD, 'same' );
    
    %%% 振幅を１にします
%    Pwave.WAVE = twaveData / max(abs(twaveData(:)));
%    Pwave.WAVE = wavefront;
    
    % 再生距離
%    Pwave.Z = Zobj;
%    disp(['再生距離を■設定■します！ z = ' num2str(wave.Z) ' [m]']);
    
%    		showWaveRealImagAbsAngle( wave.WAVE, 'objWave' );	
	
    		if nargin > 3		
    			save([SVFOLDER SVF fname '.mat'],'wave');
            end
else
    M = -1;
    wave.WAVE = 1;
    wave.Z = -1;
end
