function [wkz, w, phs] = waveSphere(lamda,waveSet,CCD,SX,SY,sss)
global DEBUG
global SVFOLDER
global SVF

%%%-----------------------------------
%%%		球面波の設定
%%%		点光源の位置 [m] デフォルト(X,Y,Z)=(500,-1000,0.5)
%%%-----------------------------------
if (nargin<2)
	waveSet.Z  = -0.5;
	waveSet.OX = 500;
	waveSet.OY = -1000;
	waveSet.amp = 2;
	sss = '球面波';
end

%%%-----------------------------------
%%%		CCDの設定
%%%		デフォルト(X,Y,dx,dy)=(1024,1024,6.45e-6,6.45e-6)
%%%-----------------------------------
if (nargin<3)
	CCD.X=1024;			CCD.Y=1024;			% データ数
	CCD.dx=6.45e-6;		CCD.dy=6.45e-6;		% CCD１画素の大きさ[m]

	[SX,SY]=meshgrid( -CCD.X/2 : CCD.X/2-1, -CCD.Y/2 : CCD.Y/2-1 );
	sss = '球面波';
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
%  【球面波】
%   waveSet : 球面波の詳細設定
%   lamda   : 波長
% 	(OX,OY,OZ) : 球面波の点光源の位置 [m]
% 	amp     : 振幅
%===============================================================================
phs = (k/(2*Z))*( (SX*dx-OX*dx).^2 + (SY*dy-OY*dy).^2 );
wkz = (amp/Z) .* exp( i * k*Z ) .* exp( i * phs );
w = (amp/Z) .* exp( i * phs );


if DEBUG
	h = figure;	set_figure(h,200,50,700,600);
	lx = 1:200;
	subplot(2,2,1);	imshow(real(w),[],'notruesize');title([sss ' 実部']);axis on;axis image;
	subplot(2,2,2);	plot(lx,real(w(CCD.X/2,lx)),'.-');title(['実部']);
	subplot(2,2,3);	imshow(index_phase(angle(w),'jet'),[-pi,pi],'notruesize');	title('位相');axis on;axis image;
	subplot(2,2,4);	plot(lx,angle(w(CCD.X/2,lx)),'.-');title('位相');ylim([-pi,pi]);
					drawnow;
		
	set_figure(h+1,600,50,700,600);
	lx=1:length(phs);
	subplot(2,2,1);	imshow(phs,[],'notruesize');title([sss ' 連続位相']);axis on;axis image;
	subplot(2,2,2);	plot(lx,phs(CCD.X/2,:),'b.-',lx,phs(:,CCD.X/2),'r.-');title(['断面図']);
	subplot(2,2,3);	surf(phs);shading interp;title('位相');axis on;
	subplot(2,2,4);	surf(-phs);shading interp;title('複素共役の位相');axis on;
					colormap(jet);
					drawnow;

	%%% 画像セーブ
%	sss=sprintf('%s%s_SphereWave.jpg',SVFOLDER,SVF);saveas(gcf,sss,'jpg');
end

