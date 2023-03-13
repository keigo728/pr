function iam = showSPECT( wave, flag, sss )
global SVFOLDER

str = ['FFT of ' sss];

% FFT
ftwave = fftshift(fft2(fftshift( wave )));

amp = abs(ftwave);
phs = angle(ftwave);
variance = var(amp(:));
if variance < 1e-6
	amp = ones(size(amp)) * max(amp(:));
end

if nargin > 1,	memo = [str '  real'];
else,			memo = 'real';
end

[x,y]=size(wave);

	set_figure(300,480,600,480);
	subplot(2,2,1);	imshow(real(ftwave),          [],'notruesize');	colorbar;	title(memo);
	subplot(2,2,2);	imshow(imag(ftwave),          [],'notruesize');	colorbar;	title('imag');
	subplot(2,2,3);	imshow( amp,                  [],'notruesize');	colorbar;	title('abs');
	subplot(2,2,4);	imshow(index_phase(phs,'jet'),[-pi,pi],'notruesize');axis on;	title('angle');	%colormap(hot);
	drawnow;

if flag.saveas==1,	saveas(gcf,[SVFOLDER sss 'NOR.tif'],'tif');	end

if flag.spect==1
	set_figure(920,480,600,480);
	subplot(3,1,1);	plot(1:x,real(wave(x/2,:)),'m-',1:y,real(wave(:,y/2)),'c-');title('fringe');legend('X','Y');xlim([1,x]);
	subplot(3,1,2);	plot(1:x,amp(x/2,:),       'b-',1:y,amp(:,y/2),       'r-');title([memo '  abs']);legend('X','Y');xlim([1,x]);
	subplot(3,1,3);	plot(1:x,phs(x/2,:),       'b-',1:y,phs(:,y/2),       'r-');title('angle');legend('X','Y');xlim([1,x]);
	drawnow;
end

%---------------------------------------------

logftwave = log(1+abs(ftwave));

	set_figure(400,40,500,400);
	imshow(logftwave,[]); colormap(hot); colorbar; title(['log( ' str ' )']);
	
if flag.saveas==1,	saveas(gcf,[SVFOLDER sss 'LOG.tif'],'tif');	end

if flag.spect==1
	set_figure(920,40,500,400); ttt=1:1024;
	plot( ttt, logftwave(257,ttt), ttt, logftwave(513,ttt), ttt, logftwave(769,ttt) );
	title(['log(' str ')']); xlim([1 1024]); legend('L=257','L=513','L=769');
	drawnow;
end	

	
	


