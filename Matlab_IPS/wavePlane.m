function w = wavePlane(lamda,waveSet,CCD,SX,SY,sss)
global DEBUG
global SVFOLDER
global SVF


%%%-----------------------------------
%%%		���ʔg �̐ݒ�
%%%		�f�t�H���g(theta,XYangle,amp)=(1.5*pi/180,45*pi/180,2)
%%%-----------------------------------
if (nargin<2)	
	waveSet.theta   = 1.5*pi/180;		% ���ˊp�x��	1.5 [degree]
	waveSet.XYangle = 45*pi/180;		% ���ˊp�x��	45  [degree]
	waveSet.amp = 2;
	sss = '���ʔg';
end

%%%-----------------------------------
%%%		CCD�̐ݒ�
%%%		�f�t�H���g(X,Y,dx,dy)=(1024,1024,6.45e-6,6.45e-6)
%%%-----------------------------------
if (nargin<3)
	CCD.X=1024;			CCD.Y=1024;			% �f�[�^��
	CCD.dx=6.45e-6;		CCD.dy=6.45e-6;		% CCD�P��f�̑傫��[m]

	[SX,SY]=meshgrid( -CCD.X/2 : CCD.X/2-1, -CCD.Y/2 : CCD.Y/2-1 );
	sss = '���ʔg';
end


%===============================================================================
%  �y���ʔg�z
%   waveSet : ���ʔg�̏ڍאݒ�
%   lamda   : �g��
% 	theta   : ���ˊp�x��		
% 	XYangle : ���ˊp�x��
% 	amp     : �U��
%===============================================================================
k=2*pi/lamda;
w = waveSet.amp.*exp( i*k*sin(waveSet.theta)...
	        *( SX*CCD.dx*cos(waveSet.XYangle) + SY*CCD.dy*sin(waveSet.XYangle) ) );



			
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




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function phs = linearPhase(px, py, N)���
%    phs = exp( i * (pi*px* Y + pi*py* X ));
% X,Y��-511����+512�܂ł̒l�����
%
% ���ʔg�̎��̂��
%      w = exp( i*k*sin(theta)*( SX*dx*cos(XYangle) + SY*dy*sin(XYangle) ) );
%        = exp( i*( k*sin(theta)*dx*cos(XYangle)* SX + k*sin(theta)*dy*sin(XYangle)* SY ) );
% SX,SY��-511����+512�܂ł̒l�����
% ��r�����
%    pi*px = k*sin(theta)*dx*cos(XYangle)
%    pi*py = k*sin(theta)*dy*sin(XYangle)
% �������C�������������g����
%    tan(XYangle) = py/px
%    sin(theta) = pi*sqrt(abs(px).^2+abs(py).^2)/( k*dx )
%               = lamda*sqrt(abs(px).^2+abs(py).^2)/( 2*dx )
%




