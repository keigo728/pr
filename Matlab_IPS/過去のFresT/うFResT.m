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

% �ϐ��̐ݒ�
lamda = initSet.lamda;
dx = initSet.CCDdx;
dy = initSet.CCDdy;
X = initSet.CCDX;
Y = initSet.CCDY;

if isfield(initSet, 'HOdv')
	dv = initSet.HOdv;
	du = initSet.HOdu;
end

% �o�͉摜�T�C�Y
if nargin < 5
	outputDataSize = 'same';
elseif isstruct(param)
	if isfield(param,'outputDataSize')
		outputDataSize = param.outputDataSize;	
	else	
		outputDataSize = 'same';
	end
else
	outputDataSize = param;		%�y�Â��o�[�W�����̌݊����m�ۗp�zparam�ɒ���'same'��'diff'�����Ă���
end


switch method

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   ����Ȃ�t�[���G�ϊ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'FFT'
	
	wavefront = simpleFFT(im);
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% �t���l���ʑ�
%%% �����Y���X�t�[���G�ϊ��^�͍Ō�Ƀt���l���`�d�̍ۂɐ�����t���l���ʑ�������������
%%% �Đ����ɂ̓t���l���ʑ��̕��f�����������ď�������K�v������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'FFT_FRESNEL'
	
	[SX,SY] = meshgrid( -X/2 : X/2-1, -Y/2 : Y/2-1 );
	de = 1/(X*dx);
	dn = 1/(Y*dy);
	phs = pi * lamda * z .*( (SX.*de).^2 + (SY.*dn).^2 );

% 		figure;	imshow(angle(exp(i*z)),[-pi,pi],'notruesize');axis on; colorbar;colormap(jet);drawnow;
% 		        title('�����Y���X�t�[���G�ϊ��^�͍Ō�Ƀt���l���ʑ�������������˃t���l���ʑ��̏������K�v');

	wavefront = simpleFFT(im) .* exp(i*phs);
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   �ʑ������|����t���l���ϊ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case {'FR', 'FRT', 'FT'}

	if abs(z)~=Inf
		wavefront = FResT_singleFFT(im,lamda,z,dx,dy,method);
    else
        disp('z = Inf');	wavefront = simpleFFT(im);
	end
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  �R���{�����[�V�����ɂ��t���l���ϊ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'SINGLE_CONV'
	
	if abs(z)~=Inf
		wavefront = FResT_singleCONV(im,lamda,z,dx,dy,method);
	else
        disp('z = Inf');	wavefront = simpleFFT(im);
    end
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  2�{�̈�[���p�b�h�E�R���{�����[�V�����ɂ��t���l���ϊ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'DOUBLE_CONV'

	if abs(z)~=Inf
		wavefront = FResT_doubleCONV(im,lamda,z,dx,dy,method, outputDataSize);
    else
        disp('z = Inf');	wavefront = simpleFFT(im);
	end
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2�{�̈�[���p�b�h�E�R���{�����[�V�����ɂ��t���l���ϊ�
%%%       �����t���l���ϊ��̂��߂̂���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'ITERATIVE_DOUBLE_CONV'

	if abs(z)~=Inf
		wavefront = FResT_IterativeDoubleCONV(im,lamda,z,dx,dy,method, outputDataSize);
    else
        disp('z = Inf');	wavefront = simpleFFT(im);
	end
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  �p�X�y�N�g���W�J�ɂ��t���l���ϊ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'SINGLE_ANGULAR'
	
	if abs(z)~=Inf
		wavefront = FResT_singleANGULAR(im,lamda,z,dx,dy,method);
	else
        disp('z = Inf');	wavefront = simpleFFT(im);
    end
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  2�{�̈�[���p�b�h�E�p�X�y�N�g���W�J�ɂ��t���l���ϊ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'DOUBLE_ANGULAR'

	if abs(z)~=Inf
		wavefront = FResT_doubleANGULAR(im,lamda,z,dx,dy,method, outputDataSize);
    else
        disp('z = Inf');	wavefront = simpleFFT(im);
	end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2�{�̈�[���p�b�h�E�p�X�y�N�g���W�J�ɂ��t���l���ϊ�
%%%       �����t���l���ϊ��̂��߂̂���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'ITERATIVE_DOUBLE_ANGULAR'

	if abs(z)~=Inf
		wavefront = FResT_IterativeDoubleANGULAR(im,lamda,z,dx,dy,method, outputDataSize);
    else
        disp('z = Inf');	wavefront = simpleFFT(im);
	end
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  �V�t�e�b�h�t���l���ϊ��ɂ��t���l���ϊ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 'SHIFTED_FRESNEL'
	
	if abs(z)~=Inf
		
		if nargin < 5 | ~isfield(param,'dv')
			[N,M] = size(im);
		
			% �{��
			MULT = 5;	disp(sprintf('�{�� = %g',MULT));
	
			% ���g�����̍��ݕ�
			param.dv = 1/( N * dx ) /MULT;			% �T���v�����O�藝���瓱�������g�����̍��ݕ� = 1/(N * dx)
			param.du = 1/( M * dy ) /MULT;
	
			% DH�̌��_
			param.x0 = 0 * dx;
			param.y0 = 0 * dy;

			% �Đ����̌��_
			param.v0 = 0 * param.dv;
			param.u0 = 0 * param.du;
		end
		
		wavefront = FResT_shiftedFRESNEL( im, lamda, z, dx, dy, method, outputDataSize, param );
		
	else
	    disp('z = Inf');	wavefront = simpleFFT(im);
	end
		
% 		disp('�z���O�����ʂ̍ŏ�����\���ݒ肳��Ă��܂���');
	
end

%#############################################################################


function w = simpleFFT(im)

[WX,WY] = size(im);
w = fftshift( ifft2( fftshift(im) ) ) * WX * WY;

