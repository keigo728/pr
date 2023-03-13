function [wkz, w, phs] = waveSphere(lamda,waveSet,CCD,SX,SY,sss)
global DEBUG
global SVFOLDER
global SVF

%%%-----------------------------------
%%%		ÊgÌÝè
%%%		_õ¹ÌÊu [m] ftHg(X,Y,Z)=(500,-1000,0.5)
%%%-----------------------------------
if (nargin<2)
	waveSet.Z  = -0.5;
	waveSet.OX = 500;
	waveSet.OY = -1000;
	waveSet.amp = 2;
	sss = 'Êg';
end

%%%-----------------------------------
%%%		CCDÌÝè
%%%		ftHg(X,Y,dx,dy)=(1024,1024,6.45e-6,6.45e-6)
%%%-----------------------------------
if (nargin<3)
	CCD.X=1024;			CCD.Y=1024;			% f[^
	CCD.dx=6.45e-6;		CCD.dy=6.45e-6;		% CCDPæfÌå«³[m]

	[SX,SY]=meshgrid( -CCD.X/2 : CCD.X/2-1, -CCD.Y/2 : CCD.Y/2-1 );
	sss = 'Êg';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dx = CCD.dx;
dy = CCD.dy;
OX = waveSet.OX;
OY = waveSet.OY;
Z = waveSet.Z;
amp = waveSet.amp;
k = 2*pi/lamda;

%===============================================================================
%  yÊgz
%   waveSet : ÊgÌÚ×Ýè
%   lamda   : g·
% 	(OX,OY,OZ) : ÊgÌ_õ¹ÌÊu [m]
% 	amp     : U
%===============================================================================
phs = (k/(2*Z))*( (SX*dx-OX*dx).^2 + (SY*dy-OY*dy).^2 );
wkz = (amp/Z) .* exp( i * k*Z ) .* exp( i * phs );
w = (amp/Z) .* exp( i * phs );


if DEBUG
	h = figure;	set_figure(h,200,50,700,600);
	lx = 1:200;
	subplot(2,2,1);	imshow(real(w),[],'notruesize');title([sss ' À']);axis on;axis image;
	subplot(2,2,2);	plot(lx,real(w(CCD.X/2,lx)),'.-');title(['À']);
	subplot(2,2,3);	imshow(index_phase(angle(w),'jet'),[-pi,pi],'notruesize');	title('Ê');axis on;axis image;
	subplot(2,2,4);	plot(lx,angle(w(CCD.X/2,lx)),'.-');title('Ê');ylim([-pi,pi]);
					drawnow;
		
	set_figure(h+1,600,50,700,600);
	lx=1:length(phs);
	subplot(2,2,1);	imshow(phs,[],'notruesize');title([sss ' A±Ê']);axis on;axis image;
	subplot(2,2,2);	plot(lx,phs(CCD.X/2,:),'b.-',lx,phs(:,CCD.X/2),'r.-');title(['fÊ}']);
	subplot(2,2,3);	surf(phs);shading interp;title('Ê');axis on;
	subplot(2,2,4);	surf(-phs);shading interp;title('¡f¤ðÌÊ');axis on;
					colormap(jet);
					drawnow;

	%%% æZ[u
%	sss=sprintf('%s%s_SphereWave.jpg',SVFOLDER,SVF);saveas(gcf,sss,'jpg');
end

