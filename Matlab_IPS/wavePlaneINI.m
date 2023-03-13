function w = wavePlaneINI(initSet,waveSet)
global DEBUG
global SVFOLDER
global SVF

X =  initSet.HCCDX;
Y =  initSet.HCCDY;
dx = initSet.HCCDdx;
dy = initSet.HCCDdy;
lamda =  initSet.lamda;

if isfield(initSet,'SX')
	SX = initSet.SX;
	SY = initSet.SY;
else
	[SX,SY]=meshgrid( -X/2 : X/2-1, -Y/2 : Y/2-1 );
end

%%%-----------------------------------
%%%		���ʔg �̐ݒ�
%%%		�f�t�H���g(theta,XYangle,amp)=(1.5*pi/180,45*pi/180,2)
%%%-----------------------------------
if (nargin<2)	
	theta   = 1.5*pi/180;		% ���ˊp�x��	1.5 [degree]
	XYangle = 45*pi/180;		% ���ˊp�x��	45  [degree]
	amp = 2;
end

theta = waveSet.theta;
XYangle = waveSet.XYangle;
amp = waveSet.amp;

%===============================================================================
%  �y���ʔg�z
%   waveSet : ���ʔg�̏ڍאݒ�
%   lamda   : �g��
% 	theta   : ���ˊp�x��		
% 	XYangle : ���ˊp�x��
% 	amp     : �U��
%===============================================================================
k=2*pi/lamda;
w = amp .* exp( i*k*sin(theta) * ( SX*dx*cos(XYangle) + SY*dy*sin(XYangle) ) );



			
if DEBUG
	
	h=figure;
	set_figure(h,900,50,700,600);
	u=1:300;
	subplot(2,2,1);	imshow(real(w(1:50,1:50)),[],'notruesize');title([sss ' ����']);axis on;axis normal; 		
	subplot(2,2,2);	plot(u,real(w(CCD.X/2,u)),'.-');title(['�U��']);
	subplot(2,2,3);	imshow(index_phase(angle(w(1:50,1:50)),'jet'),[-pi,pi],'notruesize');title('�ʑ�');axis on;axis normal;
	subplot(2,2,4);	plot(u,angle(w(CCD.X/2,u)),'.-');title('�ʑ�');ylim([-pi,pi]);
	drawnow;
						
% 	%%% �摜�Z�[�u
% 	sss=sprintf('%s%s_PlaneWave.jpg',SVFOLDER,SVF);saveas(gcf,sss,'jpg');

end
