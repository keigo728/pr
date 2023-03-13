function wavefront = FRT_singleCONV(im,lambda,z,dx,dy,method,count,sss)

[WX,WY] = size(im);
[X,Y] = meshgrid(-WX/2:WX/2-1,-WY/2:WY/2-1);

de=1/(WX*dx);
dn=1/(WY*dy);
	
% 位相項
gphs = exp(-i*pi*lambda*z.*( (X.*de).^2 + (Y.*dn).^2 ));

% ホログラムを逆フーリエ変換する
ftim = fftshift(ifft2(fftshift(im)));

% 各項の逆フーリエ変換同士をかけてフーリエ変換
% 【旧バージョン】実際上はこれで問題ない
% 	wavefront = fftshift(fft2(fftshift( gphs.*ftim )));

% 【新たに追加】正確には距離ｚに関する位相項が掛け算される
%               これをつけると位相項が順次変わるので伝搬しているように見える
%               （逆に位相の変化が見難くなる）
uo = z/lambda - fix(z/lambda);
wavefront = exp(i*2*pi*uo).*fftshift(fft2(fftshift( gphs.*ftim )));

