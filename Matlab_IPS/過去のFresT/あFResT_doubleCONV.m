function wavefront = FResT_doubleCONV( im, lambda, z, dx, dy, method, sss )

[WX,WY] = size(im);
[X,Y] = meshgrid(-WX/2:WX/2-1,-WY/2:WY/2-1);

% 位相項
de=1/(2*WX*dx);
dn=1/(2*WY*dy);	
gphs = exp(-i*pi*lambda*z.*( (X.*de).^2 + (Y.*dn).^2 ));
clear X Y


%==========================================================================
%%% エイリアスを避けるためにゼロパッドして２倍にする
gphs = padarray(gphs,[WX/2,WY/2],'both');


%==========================================================================
%%% エイリアスを避けるためにゼロパッドして２倍にする
im = padarray(im, [WX/2,WY/2],'both');


% ホログラムを逆フーリエ変換する
ftim = fftshift( ifft2( fftshift(im) ) );
clear im


%==========================================================================
% 各項の逆フーリエ変換同士をかけてフーリエ変換
% 【新たに追加】正確には距離ｚに関する位相項が掛け算される
%               これをつけると位相項が順次変わるので伝搬しているように見えるが、逆に位相の変化が見難くなる
uo = z/lambda - fix(z/lambda);
wavefront = exp(i*2*pi*uo) .* fftshift( fft2( fftshift( gphs.*ftim ) ) );


disp(['【3】  z=',num2str(z),'  uo=',num2str(uo)]);
% disp(['      fix(z/lambda)=', num2str( fix(z/lambda) ),'  z/lambda=',num2str(z/lambda) ]);

	
%===========================================================================
%%% 中心部のみを返す、これを使うとデータ数が同じになる
if strcmp(sss,'same')
	wavefront = wavefront( WX/2+1:WX+WX/2, WY/2+1:WY+WY/2 );
end




%--------------------------------------------------------------------------
% 【旧バージョン】実際上はこれで問題ない
% 	wavefront = fftshift(ifft2(fftshift( gphs.*ftim )));
