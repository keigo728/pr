function [wave,ma,ux,uy] = IMDH_reco( wave, fresnelPhase, initSet, Zobj, comm )
global SVFOLDER
global SVF

N = initSet.HMax;


zX = 1:N;
zY = 1:N;

if ~isfield(comm,'OX'),	comm.OX = 20;	comm.OY = 30;	end
if ~isfield(comm,'PS'),	comm.PS = 0;	end
if ~isfield(comm,'G'),	comm.G = 'G';	end

%***************************************************************
%***   ÉtÉåÉlÉãïœä∑ or ÉtÅ[ÉäÉGïœä∑Ç≈ëúçƒê∂Ç≈ëúçƒê∂
%***************************************************************
wave = FResT( wave, Zobj, initSet, comm.method, 'same');

if strcmp(comm.method,'FFT')
	
	if abs(Zobj)~=Inf
		%Åyãóó£ÇöÇÃÉtÉåÉlÉãì`î¿ÇÃà ëäê¨ï™Åz
		if fresnelPhase==0
			x  = initSet.HCCDX;
			y  = initSet.HCCDY;
			dx = initSet.HCCDdx;
			dy = initSet.HCCDdy;
			lamda = initSet.lamda;
			[SX,SY]=meshgrid( -x/2 : x/2-1, -y/2 : y/2-1 );
			de=1/(x*dx);
			dn=1/(y*dy);
			fresnelPhase = pi * lamda * Zobj .* ( (SX.*de).^2 + (SY.*dn).^2 );
		end
		wave = wave .* 	exp( 1i * fresnelPhase );
	end
	[ma,ux,uy] = figureFOURIER( wave, Zobj, comm, zX, zY);
	
else
	
	figureFRESNEL( wave, Zobj, comm, zX, zY );
	
end


%======================================================================================

function figureFRESNEL( wave, Zobj, comm, zX, zY )
global SVFOLDER
global SVF

h=figure;
set_figure(h,comm.OX,comm.OY,800,600);
zure = commentPS(comm);

subplot(2,2,1);	imshow(abs(wave),[],'InitialMagnification','fit');
				title([comm.C,'  êUïù Åy',comm.method,'Åz']);	axis on;axis image;colorbar;
subplot(2,2,2);	imshow(index_phase(angle(wave),'jet'),[],'InitialMagnification','fit');
				title(['à ëä Åyà ëä:',zure,'Åz']);	axis on;axis image;colorbar;
						
intensity = abs(wave).^2;
mask = doBinary( intensity(zX,zY) );
phs = angle(wave(zX,zY));
	
subplot(2,2,3);	imshow(intensity(zX,zY),[0,14e-3],'InitialMagnification','fit');
				title(['ZoomUp ã≠ìx Åyà ëä:',zure,'ÅzÅ@ZÅÅ',num2str(Zobj)]);	axis on;axis image;colorbar;
subplot(2,2,4);	imshow(index_phase(mask.*phs,'jet'),[-pi,pi],'InitialMagnification','fit');
				title(['ZoomUp à ëä Åyà ëä:',zure,'Åz']);	axis on;axis image;colormap(hot);colorbar;
drawnow;

		
%======================================================================================
function zure = commentPS(comm)
if comm.PS==0
	zure = '0';
else
	zure = sprintf('%5.3fÉŒ',comm.PS/pi);
end


%======================================================================================

function [ma,ux,uy] = figureFOURIER( wave, Zobj, comm, zX, zY )
global SVFOLDER
global SVF

h=figure;
set_figure(h,comm.OX,comm.OY,800,600);
zure = commentPS(comm);
amp = abs(wave);
maa = max_control(amp);
subplot(2,2,1);	imshow(abs(wave),[0,maa],'InitialMagnification','fit');
				title([comm.C,'  êUïù Åy',comm.method,'Åz']);	axis on;axis image;colorbar;
subplot(2,2,2);	imshow(index_phase(angle(wave),'jet'),[-pi,pi],'InitialMagnification','fit');
				title(['à ëä Åyà ëä:',zure,'Åz']);	axis on;axis image;colorbar;
	
intensity = amp.^2;
maa = max_control(intensity);
[ma,ux,uy] = myMax2d(intensity(1:end/2-1,:));

mask = doBinary(intensity(zX,zY));
phs = angle(wave(zX,zY));

subplot(2,2,3);	imshow(intensity(zX,zY),[0,14e-3],'InitialMagnification','fit');
				title(['ZoomUp ã≠ìx Åyà ëä:',zure,'ÅzÅ@ZÅÅ',num2str(Zobj)]);	axis on;axis image;colorbar;
subplot(2,2,4);	imshow(index_phase(mask.*phs,'jet'),[],'InitialMagnification','fit');
				title(['ZoomUp à ëä Åyà ëä:',zure,'Åz']);	axis on;axis image;colormap(hot);colorbar;
drawnow;
