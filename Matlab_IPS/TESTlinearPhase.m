clear all;	close all;

N = 256;
px = -1/16;
py = 0.125;

% 線形位相をつくる
z = linearPhase( px, py, N );

		% 確認
		h=figure;
		u=1:N;
		subplot(2,2,1);	imshow(real(z),[],'notruesize');	title(['線形位相　 実部']);axis on;
		subplot(2,2,2);	plot(u,real(z(N/2,u)),'.-');		title(['実部']);
		subplot(2,2,3);	imshow(index_phase(angle(z),'jet'),[-pi,pi],'notruesize');	title('位相');axis on;
		subplot(2,2,4);	plot(u,angle(z(N/2,u)),'.-');		title('位相');ylim([-pi,pi]);
		drawnow;
	
% 線形位相をフーリエ変換するとピーク位置がシフトする	
ftz = shiftfft2(z);

% 最大ピークの確認
[ma,x,y] = myMax2d( abs(ftz).^2 )
disp( sprintf('確認（%g,%g）', (N/2+1) + N/2*px, (N/2+1) + N/2*py) );


		figure;	imshow(abs(ftz).^2,[],'notruesize');axis on;title(sprintf('(%d,%d)',x,y));
% 		figure;	surf(abs(ftz).^2);shading interp;axis tight;title(['(' num2str(x) ',' num2str(y) ')']);
		drawnow;
		