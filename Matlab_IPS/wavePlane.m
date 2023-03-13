function w = wavePlane(lamda,waveSet,CCD,SX,SY,sss)
global DEBUG
global SVFOLDER
global SVF


%%%-----------------------------------
%%%		平面波 の設定
%%%		デフォルト(theta,XYangle,amp)=(1.5*pi/180,45*pi/180,2)
%%%-----------------------------------
if (nargin<2)	
	waveSet.theta   = 1.5*pi/180;		% 入射角度φ	1.5 [degree]
	waveSet.XYangle = 45*pi/180;		% 入射角度θ	45  [degree]
	waveSet.amp = 2;
	sss = '平面波';
end

%%%-----------------------------------
%%%		CCDの設定
%%%		デフォルト(X,Y,dx,dy)=(1024,1024,6.45e-6,6.45e-6)
%%%-----------------------------------
if (nargin<3)
	CCD.X=1024;			CCD.Y=1024;			% データ数
	CCD.dx=6.45e-6;		CCD.dy=6.45e-6;		% CCD１画素の大きさ[m]

	[SX,SY]=meshgrid( -CCD.X/2 : CCD.X/2-1, -CCD.Y/2 : CCD.Y/2-1 );
	sss = '平面波';
end


%===============================================================================
%  【平面波】
%   waveSet : 平面波の詳細設定
%   lamda   : 波長
% 	theta   : 入射角度φ		
% 	XYangle : 入射角度θ
% 	amp     : 振幅
%===============================================================================
k=2*pi/lamda;
w = waveSet.amp.*exp( i*k*sin(waveSet.theta)...
	        *( SX*CCD.dx*cos(waveSet.XYangle) + SY*CCD.dy*sin(waveSet.XYangle) ) );



			
if DEBUG
	
	h=figure;
	set_figure(h,900,50,700,600);
	u=1:300;
	subplot(2,2,1);	imshow(real(w(1:50,1:50)),[],'notruesize');title([sss ' 実部']);axis on;axis normal; 		
	subplot(2,2,2);	plot(u,real(w(CCD.X/2,u)),'.-');title(['振幅']);
	subplot(2,2,3);	imshow(index_phase(angle(w(1:50,1:50)),'jet'),[-pi,pi],'notruesize');title('位相');axis on;axis normal;
	subplot(2,2,4);	plot(u,angle(w(CCD.X/2,u)),'.-');title('位相');ylim([-pi,pi]);
	drawnow;
						
% 	%%% 画像セーブ
% 	sss=sprintf('%s%s_PlaneWave.jpg',SVFOLDER,SVF);saveas(gcf,sss,'jpg');

end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function phs = linearPhase(px, py, N)より
%    phs = exp( i * (pi*px* Y + pi*py* X ));
% X,Yは-511から+512までの値を取る
%
% 平面波の式のより
%      w = exp( i*k*sin(theta)*( SX*dx*cos(XYangle) + SY*dy*sin(XYangle) ) );
%        = exp( i*( k*sin(theta)*dx*cos(XYangle)* SX + k*sin(theta)*dy*sin(XYangle)* SY ) );
% SX,SYは-511から+512までの値を取る
% 比較すると
%    pi*px = k*sin(theta)*dx*cos(XYangle)
%    pi*py = k*sin(theta)*dy*sin(XYangle)
% これらより，ｄｘ＝ｄｙを使うと
%    tan(XYangle) = py/px
%    sin(theta) = pi*sqrt(abs(px).^2+abs(py).^2)/( k*dx )
%               = lamda*sqrt(abs(px).^2+abs(py).^2)/( 2*dx )
%




