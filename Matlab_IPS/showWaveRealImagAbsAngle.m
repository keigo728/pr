function showWaveRealImagAbsAngle( wave, sss, graphname )
global SVFOLDER

if nargin > 1
	sss
	memo = [sss '  real'];
else
	memo = 'real';
end

amp = abs(wave);
variance = var(amp(:));
if variance < 1e-6
	amp = ones(size(amp)) * max(amp(:));
end

	figure;
	subplot(2,2,1);	imshow(real(wave),[]);colorbar;
					title(memo);
	subplot(2,2,2);	imshow(imag(wave),[]);colorbar;
					title('imag');
	subplot(2,2,3);	imshow( amp,[]);colorbar;
					title('abs');
	subplot(2,2,4);	imshow(index_phase(angle(wave),'jet'),[-pi,pi]);axis on;
					title('angle');
	%colormap(hot);
	drawnow;


if nargin > 2	
	%%% âÊëúÉZÅ[Éu
	filename = [SVFOLDER graphname '.jpg'];
	saveas(gcf,filename,'jpg');
end


	
%[x,y]=size(wave);

%	figure;
%	subplot(3,1,1);	plot(1:x,real(wave(x/2,:)),'b-',1:y,real(wave(:,y/2)),'r-');xlim([1,x]);
%					title(memo);	legend('X','Y');
%	subplot(3,1,2);	plot(1:x,amp(x/2,:),'b-',1:y,amp(:,y/2),'r-');xlim([1,x]);
%					title('abs');	legend('X','Y');
%	subplot(3,1,3);	plot(1:x,angle(wave(x/2,:)),'b-',1:y,angle(wave(:,y/2)),'r-');xlim([1,x]);
%					title('angle');	legend('X','Y');
%	drawnow;
	