function wavefront = FResT( im, z, initSet, method, param )
%FResT	Fresnel transform of Two-dimensional data
%	FResT(im,lamda,z,dx,dy,method,count,outputDataSize) returns 
%	the two-dimensional Fresnel transform of matrix im (2D image).
%	If im is a vector, the result will have the same orientation.
%	lamda : wavelength of laser
%	z : length between hologram and CCD camera
%	dx,dy : pixel size of CCD camera
%	method : 'FT', 'SINGLE_CONV', 'DOUBLE_CONV', 'ITERATIVE_DOUBLE_CONV'
%	outputDataSize : file name for data save

% 変数の設定
lamda = initSet.lamda;
dx = initSet.CCDdx;
dy = initSet.CCDdy;
X = initSet.CCDX;
Y = initSet.CCDY;

if isfield(initSet, 'HOdv')
	dv = initSet.HOdv;
	du = initSet.HOdu;
end

% 出力画像サイズ
if nargin < 5
	outputDataSize = 'same';
elseif isstruct(param)
	if isfield(param,'outputDataSize')
		outputDataSize = param.outputDataSize;	
	else	
		outputDataSize = 'same';
	end
else
	outputDataSize = param;		%【古いバージョンの互換性確保用】paramに直接'same'と'diff'を入れていた
end


switch method

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   たんなるフーリエ変換
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'FFT'
	
	wavefront = simpleFFT(im);
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% フレネル位相
%%% レンズレスフーリエ変換型は最後にフレネル伝播の際に生じるフレネル位相成分がかかる
%%% 再生像にはフレネル位相の複素共役をかけて除去する必要がある
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'FFT_FRESNEL'
	
	[SX,SY] = meshgrid( -X/2 : X/2-1, -Y/2 : Y/2-1 );
	de = 1/(X*dx);
	dn = 1/(Y*dy);
	phs = pi * lamda * z .*( (SX.*de).^2 + (SY.*dn).^2 );

% 		figure;	imshow(angle(exp(i*z)),[-pi,pi],'notruesize');axis on; colorbar;colormap(jet);drawnow;
% 		        title('レンズレスフーリエ変換型は最後にフレネル位相成分がかかる⇒フレネル位相の除去が必要');

	wavefront = simpleFFT(im) .* exp(i*phs);
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   位相項を掛けるフレネル変換
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case {'FR', 'FRT', 'FT'}

	if abs(z)~=Inf
		wavefront = FResT_singleFFT(im,lamda,z,dx,dy,method);
    else
        disp('z = Inf');	wavefront = simpleFFT(im);
	end
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  コンボリューションによるフレネル変換
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'SINGLE_CONV'
	
	if abs(z)~=Inf
		wavefront = FResT_singleCONV(im,lamda,z,dx,dy,method);
	else
        disp('z = Inf');	wavefront = simpleFFT(im);
    end
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  2倍領域ゼロパッド・コンボリューションによるフレネル変換
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'DOUBLE_CONV'

	if abs(z)~=Inf
		wavefront = FResT_doubleCONV(im,lamda,z,dx,dy,method, outputDataSize);
    else
        disp('z = Inf');	wavefront = simpleFFT(im);
	end
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2倍領域ゼロパッド・コンボリューションによるフレネル変換
%%%       反復フレネル変換のためのもの
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'ITERATIVE_DOUBLE_CONV'

	if abs(z)~=Inf
		wavefront = FResT_IterativeDoubleCONV(im,lamda,z,dx,dy,method, outputDataSize);
    else
        disp('z = Inf');	wavefront = simpleFFT(im);
	end
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  角スペクトル展開によるフレネル変換
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'SINGLE_ANGULAR'
	
	if abs(z)~=Inf
		wavefront = FResT_singleANGULAR(im,lamda,z,dx,dy,method);
	else
        disp('z = Inf');	wavefront = simpleFFT(im);
    end
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  2倍領域ゼロパッド・角スペクトル展開によるフレネル変換
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'DOUBLE_ANGULAR'

	if abs(z)~=Inf
		wavefront = FResT_doubleANGULAR(im,lamda,z,dx,dy,method, outputDataSize);
    else
        disp('z = Inf');	wavefront = simpleFFT(im);
	end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2倍領域ゼロパッド・角スペクトル展開によるフレネル変換
%%%       反復フレネル変換のためのもの
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'ITERATIVE_DOUBLE_ANGULAR'

	if abs(z)~=Inf
		wavefront = FResT_IterativeDoubleANGULAR(im,lamda,z,dx,dy,method, outputDataSize);
    else
        disp('z = Inf');	wavefront = simpleFFT(im);
	end
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  シフテッドフレネル変換によるフレネル変換
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'SHIFTED_FRESNEL'
	
	if abs(z)~=Inf
		
		if nargin < 5 | ~isfield(param,'dv')
			[N,M] = size(im);
		
			% 倍率
			MULT = 5;	disp(sprintf('倍率 = %g',MULT));
	
			% 周波数軸の刻み幅
			param.dv = 1/( N * dx ) /MULT;			% サンプリング定理から導かれる周波数軸の刻み幅 = 1/(N * dx)
			param.du = 1/( M * dy ) /MULT;
	
			% DHの原点
			param.x0 = 0 * dx;
			param.y0 = 0 * dy;

			% 再生像の原点
			param.v0 = 0 * param.dv;
			param.u0 = 0 * param.du;
		end
		
		wavefront = FResT_shiftedFRESNEL( im, lamda, z, dx, dy, method, outputDataSize, param );
		
	else
	    disp('z = Inf');	wavefront = simpleFFT(im);
	end
		
% 		disp('ホログラム面の最小分解能が設定されていません');
	
end

%#############################################################################


function w = simpleFFT(im)

[WX,WY] = size(im);
w = fftshift( ifft2( fftshift(im) ) ) * WX * WY;

