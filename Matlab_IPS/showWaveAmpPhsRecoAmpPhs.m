function showWaveAmpPhsRecoAmpPhs(im, fresnelPhase, sss, zoom)
% im			: 複素振幅
% fresnelPhase	: フレネル位相項
% sss			: タイトル
% zoom			: ズームアップ

if nargin < 3
	sss = 'test';
end

[x,y]=size(im);

		figure;
		subplot(3,2,1);	imshow(real(im),[]);axis on; colorbar;
						title([sss ' 振幅']);
		subplot(3,2,2);	imshow(index_phase(angle(im),'jet'));axis on; colorbar;
						title('位相 @showWaveAmpPhsRecoAmpPhs()');

% 一度再生します、そしてフレネル位相項を掛け算します
sExp = shiftifft2(im) .* exp(i*fresnelPhase);

intensity=abs(sExp).^2;
ma = max_control(intensity);		% 縦軸の調整

		subplot(3,2,3);	imshow(intensity,[0,ma]);axis on; colorbar;
						title('FFT再生像　強度');
		subplot(3,2,4);	imshow(index_phase(angle(sExp),'jet'));	axis on; colorbar;
						title('再生像　位相');					
		subplot(3,2,5);	plot(1:x,intensity(x/2+1,:),'r-',1:y,intensity(:,y/2+1),'b:');
						title('FFT再生像　強度@centerLine');xlim([1 x]);
		subplot(3,2,6);	plot(1:x,angle(sExp(x/2+1,:)),'r-',1:y,angle(sExp(:,y/2+1)),'b:');
						title('FFT再生像　位相@centerLine');xlim([1 x]);
						drawnow;


% 中央部を抜き出す
if nargin > 2
	if strcmp(flag,'ZOOM')
		[X,Y]=size(im);
		
		u=X/2-63:X/2+64;
		v=Y/2-63:Y/2+64;
		figure;	imshow(intensity(u,v),[0,ma]);axis on; colorbar;
				title('再生像　強度');
		figure;	imshow(angle(sExp(u,v)),[-pi,pi]);axis on; colorbar;colormap(jet);
				title('再生像　位相');
		drawnow;
	end
end
