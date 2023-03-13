function wavefront = FResT_doubleCONV( im, lamda, z, dx, dy, method, sss )

[N,M] = size(im);
[X,Y] = meshgrid(-N/2:N/2-1,-M/2:M/2-1);
CONV_FT_factor = 1;		% この係数はフレネル近似法とコンボリューション法の強度を一致させるために使う
						%     CONV_FT_factor = N /lamda /z *2 *pi;
 						% のとき一致するが、あまり意味ない
						
% 周波数軸の刻み幅
de=1/(2*N*dx);
dn=1/(2*M*dy);

%==========================================================================
% 位相項
% 根号の中の値
theta = 1/lamda.^2 - (X.*de).^2 - (Y.*dn).^2;
% 根号内が正になるかチェック、根号が負ならばAA=0で強制的にゼロにする
AA = ones(size(theta));
AA(theta<0)=0;
theta(AA==0)=0;
% これは２ｎπ成分を計算しないようにするため
theta = (z) .* sqrt( theta );
theta = theta - fix(theta);
% 根号内が負になるときはゼロにする
gphs = AA .* exp( i * 2 * pi * theta ) * CONV_FT_factor;									clear X Y theta

	if min(AA(:))==0
		figure;	imshow(AA,[],'notruesize');colorbar;drawnow;
	end
	
%==========================================================================
%%% エイリアスを避けるためにゼロパッドして２倍にする
gphs = padarray(gphs,[N/2,M/2],'both');


%==========================================================================
%%% エイリアスを避けるためにゼロパッドして２倍にする
im = padarray(im, [N/2,M/2],'both');


%==========================================================================
% ホログラムを逆フーリエ変換する
ftim = fftshift( fft2( fftshift(im) ) );										clear im


%==========================================================================
% 位相項と掛ける
ftim = gphs .* ftim;															clear gphs


%==========================================================================
% 各項の逆フーリエ変換同士をかけてフーリエ変換
% 【新たに追加】正確には距離ｚに関する位相項が掛け算される
%               これをつけると位相項が順次変わるので伝搬しているように見えるが、逆に位相の変化が見難くなる
wavefront = ifftshift( ifft2( ifftshift( ftim ) ) );


disp(['【3】  z=',num2str(z)]);
% disp(['      fix(z/lamda)=', num2str( fix(z/lamda) ),'  z/lamda=',num2str(z/lamda) ]);

	
%===========================================================================
%%% 中心部のみを返す、これを使うとデータ数が同じになる
if strcmp(sss,'same')
	wavefront = wavefront( N/2+1:N+N/2, M/2+1:M+M/2 );
end




%--------------------------------------------------------------------------
% 【旧バージョン】実際上はこれで問題ない
% 	wavefront = fftshift(ifft2(fftshift( gphs.*ftim )));
