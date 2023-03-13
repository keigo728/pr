function winf = myhann(N,method)
% hanning	: ハニング窓
% hamming	: ハミング窓
% blackman  : ブラックマン窓

n = 0 : N-1;

switch method
	case 'hanning'
		winf = 0.5  -  0.5*cos(2*pi*n/(N-1));
	case 'hamming'
		winf = 0.54 - 0.46*cos(2*pi*n/(N-1));
	case 'blackman'
		winf = 0.42 - 0.5*cos(2*pi*n/(N-1)) + 0.08*cos(4*pi*n/(N-1));
end

% 	figure;	plot(n,winf,'r-','linewidth',2);
% 			set(gca,'LineWidth',2,'FontSize',14);
% 			xlabel('Number','Fontsize',12);
% 			ylabel('Amplitude','Fontsize',12)
% 			title(method);			
% 			axis([0 N 0 1]);

