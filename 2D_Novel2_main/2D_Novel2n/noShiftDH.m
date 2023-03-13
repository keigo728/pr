function holo = noShiftDH( initSet )
global SVFOLDER
global SVF

N = initSet.CCDX;
M = initSet.INPUT_IM_SIZE;


%  一度画像データとしてセーブしたホログラム（正規化データ）を使う
% 8bit画像なので性能は悪くなる，12bit画像でセーブしたほうが良い
filename = sprintf('%sholo1.tif', SVFOLDER)
fringe = imread(filename);	% ホログラムデータを再読み込み
																	% fringe = imnoise( fringe, 'gaussian', 0, 0.00001);	% ノイズ付加
% 実数にする
holo = double( fringe )/255;									% holo = double( holo )/4095;



%============================================================================================
% ◆◆◆ 今回は９６×９６画素なので周囲に０を埋める【この部分をコメントアウトすれば１２８×１２８】
%============================================================================================
%tholo = zeros(N,N);
%tholo(N/2-M/2+1:N/2+M/2,N/2-M/2+1:N/2+M/2) = holo(:,:);
%holo = tholo;

	%showWaveAmpPhsRecoAmpPhs(holo, 0);	% 確認
	figure;	imshow(real(holo),[],'InitialMagnification','fit');	title('CGH'); colorbar; axis on; drawnow;
			