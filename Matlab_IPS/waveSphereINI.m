function [wkz, w, phs] = waveSphereINI( initSet, waveSet )
global DEBUG
global SVFOLDER
global SVF

X =  initSet.CCDX;
Y =  initSet.CCDY;
dx = initSet.CCDdx;
dy = initSet.CCDdy;
lamda =  initSet.lamda;

if isfield(initSet,'SX')
	SX = initSet.SX;
	SY = initSet.SY;
else
	[SX,SY]=meshgrid( -X/2 : X/2-1, -Y/2 : Y/2-1 );
end

%%%-------------------------------------------------------------
%%%		‹…–Ê”g‚Ìİ’è
%%%		“_ŒõŒ¹‚ÌˆÊ’u [m] ƒfƒtƒHƒ‹ƒg(X,Y,Z)=(500,-1000,0.5)
%%%-------------------------------------------------------------
if (nargin<2)
	Z  = -0.5;
	OX = 500;
	OY = -1000;
	amp = 2;
end

OX = waveSet.OX;
OY = waveSet.OY;
Z = waveSet.Z;
amp = waveSet.amp;
k = 2*pi/lamda;

%===============================================================================
%  y‹…–Ê”gz
%   waveSet : ‹…–Ê”g‚ÌÚ×İ’è
%   lamda   : ”g’·
% 	(OX,OY,OZ) : ‹…–Ê”g‚Ì“_ŒõŒ¹‚ÌˆÊ’u [m]
% 	amp     : U•
%===============================================================================
phs = (k/(2*Z))*( (SX*dx-OX*dx).^2 + (SY*dy-OY*dy).^2 );
wkz = (amp/Z) .* exp( i * k*Z ) .* exp( i * phs );
w = (amp/Z) .* exp( i * phs );


if DEBUG
	h = figure;	set_figure(h,200,50,700,600);
	lx = 1:200;
	subplot(2,2,1);	imshow(real(w),[],'notruesize');title([sss ' À•”']);axis on;axis image;
	subplot(2,2,2);	plot(lx,real(w(CCD.X/2,lx)),'.-');title(['À•”']);
	subplot(2,2,3);	imshow(index_phase(angle(w),'jet'),[-pi,pi],'notruesize');	title('ˆÊ‘Š');axis on;axis image;
	subplot(2,2,4);	plot(lx,angle(w(CCD.X/2,lx)),'.-');title('ˆÊ‘Š');ylim([-pi,pi]);
					drawnow;
		
	set_figure(h+1,600,50,700,600);
	lx=1:length(phs);
	subplot(2,2,1);	imshow(phs,[],'notruesize');title([sss ' ˜A‘±ˆÊ‘Š']);axis on;axis image;
	subplot(2,2,2);	plot(lx,phs(CCD.X/2,:),'b.-',lx,phs(:,CCD.X/2),'r.-');title(['’f–Ê}']);
	subplot(2,2,3);	surf(phs);shading interp;title('ˆÊ‘Š');axis on;axis image;
	subplot(2,2,4);	surf(-phs);shading interp;title('•¡‘f‹¤–ğ‚ÌˆÊ‘Š');axis on;axis image;
					colormap(jet);
					drawnow;

	%%% ‰æ‘œƒZ[ƒu
%	sss=sprintf('%s%s_SphereWave.jpg',SVFOLDER,SVF);saveas(gcf,sss,'jpg');
end

