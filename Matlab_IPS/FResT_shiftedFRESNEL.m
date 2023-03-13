function wavefront = FResT_shiftedFRESNEL( im, lamda, z, dx, dy, method, sss, param )
global DEBUG

[N,M] = size(im);
[X,Y] = meshgrid(-N/2:N/2-1,-M/2:M/2-1);
CONV_FT_factor = 1;		% この係数はフレネル近似法とコンボリューション法の強度を一致させるために使う
						%     CONV_FT_factor = N /lamda /z *2 *pi;
 						% のとき一致するが、あまり意味ない
						
dv = param.dv;
du = param.du;
	
x0 = param.x0;
y0 = param.y0;

v0 = param.v0;
u0 = param.u0;

disp(sprintf('dv=%g, du=%g\n(x0,y0)=(%g,%g)\n(v0,u0)=(%g,%g)',dv,du,x0,y0,v0,u0));


% スケールファクター
Sxv = dx * dv;
Syu = dy * du;

% ホログラム面の座標変換
xr = x0 + X * dx;
ys = y0 + Y * dy;

% 再生面の座標変換
vm = v0 + X * dv;
un = u0 + Y * du;


%==========================================================================
% 基本係数
Amn = exp(i*(2*pi/lamda)*z)/(i*lamda*z);
Amn = Amn .* exp( i * pi * lamda * z * ( vm.^2 + un.^2 ));
Amn = Amn .* exp(-i * 2 * pi * ( X*x0*dv + Y*y0*du ));

	if DEBUG,	figure;	imshow( index_phase(angle(Amn),'jet'),[],'notruesize');colorbar;title('基本係数');	end

%=========================================================================
% シフテッドフレネル固有の係数
Ask = exp(-i * pi * ( Sxv * X.^2 + Syu * Y.^2 ));

	if DEBUG,	figure;	imshow(index_phase(angle(Ask),'jet'),[],'notruesize');colorbar;title('個別係数');	end

% 基本係数をかける
Ask = Ask .* Amn;																	clear Amn

Ask = padarray(Ask,[N/2,M/2],'both');	% エイリアスを避けるためにゼロパッドして２倍にする


%==========================================================================
% χ（ｆ）
Kai = im .* exp(i * (pi/lamda/z) * ( xr.^2 + ys.^2 )) .* exp(-i * 2 * pi * (xr * v0 + ys * u0));
Kai = Kai .* exp(-i * pi * ( Sxv * X.^2 + Syu * Y.^2 ));

	if DEBUG,	figure;	imshow(index_phase(angle(Kai),'jet'),[],'notruesize');colorbar;title('χ（ｆ）');	end

Kai = padarray(Kai,[N/2,M/2],'both');	% エイリアスを避けるためにゼロパッドして２倍にする

% 逆フーリエ変換する
ftKai = fftshift( fft2( fftshift(Kai) ) );											clear Kai

	if DEBUG,	figure;	imshow(abs(ftKai),[],'notruesize');colorbar;	end

%==========================================================================
% ζ（ｆ）
Zeta = exp(i * pi * ( Sxv * X.^2 + Syu * Y.^2 ));

	if DEBUG,	figure;	imshow(index_phase(angle(Zeta),'jet'),[],'notruesize');colorbar;title('ζ（ｆ）');	end
	
Zeta = padarray(Zeta, [N/2,M/2],'both');	% エイリアスを避けるためにゼロパッドして２倍にする

% 逆フーリエ変換する
ftZeta = fftshift( fft2( fftshift(Zeta) ) );										clear Zeta X Y

	if DEBUG,	figure;	imshow(abs(ftZeta),[],'notruesize');colorbar;	end

%==========================================================================
% 各項の逆フーリエ変換同士をかけてフーリエ変換

ftZeta = ftKai .* ftZeta;															clear ftKai
wavefront = Ask .* ifftshift( ifft2( ifftshift( ftZeta ) ) );						clear ftZeta

disp(['【3】  z=',num2str(z)]);

	
%===========================================================================
%%% 中心部のみを返す、これを使うとデータ数が同じになる
if strcmp(sss,'same')
	wavefront = wavefront( N/2+1:N+N/2, M/2+1:M+M/2 );
end