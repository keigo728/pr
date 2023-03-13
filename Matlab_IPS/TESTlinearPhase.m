clear all;	close all;

N = 256;
px = -1/16;
py = 0.125;

% ���`�ʑ�������
z = linearPhase( px, py, N );

		% �m�F
		h=figure;
		u=1:N;
		subplot(2,2,1);	imshow(real(z),[],'notruesize');	title(['���`�ʑ��@ ����']);axis on;
		subplot(2,2,2);	plot(u,real(z(N/2,u)),'.-');		title(['����']);
		subplot(2,2,3);	imshow(index_phase(angle(z),'jet'),[-pi,pi],'notruesize');	title('�ʑ�');axis on;
		subplot(2,2,4);	plot(u,angle(z(N/2,u)),'.-');		title('�ʑ�');ylim([-pi,pi]);
		drawnow;
	
% ���`�ʑ����t�[���G�ϊ�����ƃs�[�N�ʒu���V�t�g����	
ftz = shiftfft2(z);

% �ő�s�[�N�̊m�F
[ma,x,y] = myMax2d( abs(ftz).^2 )
disp( sprintf('�m�F�i%g,%g�j', (N/2+1) + N/2*px, (N/2+1) + N/2*py) );


		figure;	imshow(abs(ftz).^2,[],'notruesize');axis on;title(sprintf('(%d,%d)',x,y));
% 		figure;	surf(abs(ftz).^2);shading interp;axis tight;title(['(' num2str(x) ',' num2str(y) ')']);
		drawnow;
		