function wavefront = FResT_IterativeDoubleCONV( im, lambda, z, dx, dy, method, sss )

[WX,WY] = size(im);
[X,Y] = meshgrid(-WX/2:WX/2-1,-WY/2:WY/2-1);

% deltaZ刻みで計算します
deltaZ = z/10;


%%% エイリアスを避けるためにゼロパッドして２倍にする
WXd2=WX/2;
WYd2=WY/2;
im = padarray(im,[WXd2,WYd2]);


% 位相項
de=1/(2*WX*dx);			% 2倍領域にするのでデータ数を2倍にした、これでいいかな
dn=1/(2*WY*dy);
gphs = exp(-i*pi*lambda*deltaZ.*( (X.*de).^2 + (Y.*dn).^2 ));
clear X Y
gphs = padarray(gphs,[WXd2,WYd2]);


%%% 反復フレネル変換
for c = deltaZ : deltaZ : z

	% ホログラムを逆フーリエ変換する
	ftim = fftshift( ifft2( fftshift(im) ) );

	% 各項の逆フーリエ変換同士をかけてフーリエ変換
	% 【新たに追加】正確には距離ｚに関する位相項が掛け算される
	%               これをつけると位相項が順次変わるので伝搬しているように見える（逆に位相の変化が見難くなる）
	uo = deltaZ/lambda - fix(deltaZ/lambda);
	im = exp(i*2*pi*uo) .* fftshift( fft2( fftshift( gphs.*ftim ) ) );

	disp(['【4】 z=',num2str(c),'  uo=',num2str(uo)]);
	%disp(['             2*pi*uo=',num2str(2*pi*uo),'  exp(-i*2*pi*uo)=',num2str(angle(exp(-i*2*pi*uo))),'  uo=',num2str(uo)]);
	%disp(['      fix(count/lambda)=', num2str( fix(count/lambda) ),'  count/lambda=',num2str(count/lambda) ]);

		% show_results(im,gphs,ftim,wavefront);	% 【確認】
end

%===========================================================================
%%% 中心部のみを返す、これを使うとデータ数が同じになる
if strcmp(sss,'same')
	wavefront = im( WXd2+1:WX+WXd2, WYd2+1:WY+WYd2 );
else
	wavefront = im;
end



	% 【旧バージョン】実際上はこれで問題ない
	% 	wavefront = fftshift(ifft2(fftshift( gphs.*ftim )));
