function [wave, M] = objectWave( datafile, Zobj, initSet, fname, ox, oy)
global SVFOLDER
global SVF




% ƒf[ƒ^ƒTƒCƒY‚Í‚Q‚Ì‚×‚«æ‚É‚·‚é
X = initSet.HCCDY;
Y = initSet.HCCDX;
hx = initSet.HCCDdy; %1920*1080Žž‚Í5.4ƒÊm‚ÉŽw’è(ƒzƒƒOƒ‰ƒ€–Ê‚Ìˆê‰æ‘f‚Ì‘å‚«‚³)
hy = initSet.HCCDdx;
dx = initSet.CCDdy;
dy = initSet.CCDdx;
Lx = initSet.CCDY;
Ly = initSet.CCDX;

x0 = -Lx/2.*dx + ((ox-1).*dx); 
y0 = -Ly/2.*dy + ((oy-1).*dy);

%%% “ü—Í‰æ‘œ
im = double(imread([datafile.FOLDER datafile.name]))/255;
M = length(im);	% ‰æ‘œƒTƒCƒY

k = 2.*pi/initSet.lamda;
wavefront = zeros(X,Y);


% ŸŸŸ ¡‰ñ‚Í‚X‚U~‚X‚U‰æ‘f‚È‚Ì‚ÅŽüˆÍ‚É‚O‚ð–„‚ß‚é
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
	% Ä¶‘œ‚ð’†‰›‚ÉƒVƒtƒg‚³‚¹‚éˆÊ‘Š¬•ª‚ð‚±‚±‚Å‚Â‚­‚Á‚Ä‚¨‚­
	% 3ŽŸŒ³‹ÉÀ•WŒn‚Å‚ÍA(X,Y,Z)=(rsinQcosP,rsinQcosP,rcosQ)‚æ‚èA
	% ‹…–Ê”g‚ÌŒ´“_‚Ì•ûŒü‚©‚ç‚Ì•½–Ê”g‚ðl‚¦‚é
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

    % •¨‘Ì”g‚Ì•¡‘fU•C‰ŠúˆÊ‘ŠƒÎ^‚R
%    im = sqrt( im ) .* exp( 1i * pi/3 );
    % im = sqrt( im ) .* exp( 1i * 2*pi * convn(rand(size(im)),ones(3,3)/9,'same') );	% ƒ‰ƒ“ƒ_ƒ€ˆÊ‘Š

%    		figure;	imshow(real(im),[],'InitialMagnification','fit');	axis on;	colorbar;

    %------------------
    % ƒtƒŒƒlƒ‹•ÏŠ·
    %------------------
%    wavefront = FResT( im, Zobj, initSet, initSet.FRT_METHOD, 'same' );
    
    %%% U•‚ð‚P‚É‚µ‚Ü‚·
%    Pwave.WAVE = twaveData / max(abs(twaveData(:)));
%    Pwave.WAVE = wavefront;
    
    % Ä¶‹——£
%    Pwave.Z = Zobj;
%    disp(['Ä¶‹——£‚ð¡Ý’è¡‚µ‚Ü‚·I z = ' num2str(wave.Z) ' [m]']);
    
%    		showWaveRealImagAbsAngle( wave.WAVE, 'objWave' );	
	
    		if nargin > 3		
    			save([SVFOLDER SVF fname '.mat'],'wave');
            end
else
    M = -1;
    wave.WAVE = 1;
    wave.Z = -1;
end
