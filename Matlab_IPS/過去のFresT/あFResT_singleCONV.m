function wavefront = FResT_singleCONV( im, lamda, z, dx, dy, method )

[WX,WY] = size(im);
[X,Y] = meshgrid(-WX/2:WX/2-1,-WY/2:WY/2-1);
	
% 位相項
de=1/(WX*dx);
dn=1/(WY*dy);
gphs = exp(-i*pi*lamda*z.*( (X.*de).^2 + (Y.*dn).^2 ));

clear X Y


% ホログラムを逆フーリエ変換する
ftim = fftshift( ifft2( fftshift(im) ) );


% 【新たに追加】正確には距離ｚに関する位相項が掛け算される
%               これをつけると位相項が順次変わるので伝搬しているように見える
%               （逆に位相の変化が見難くなる）
uo = z/lamda - fix(z/lamda);
wavefront = exp(i*2*pi*uo) .* fftshift( fft2( fftshift( gphs.*ftim ) ) );



%--------------------------------------------------------------------------

% 各項の逆フーリエ変換同士をかけてフーリエ変換
% 【旧バージョン】実際上はこれで問題ない
% 	wavefront = fftshift(fft2(fftshift( gphs.*ftim )));