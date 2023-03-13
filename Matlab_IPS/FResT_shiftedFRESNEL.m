function wavefront = FResT_shiftedFRESNEL( im, lamda, z, dx, dy, method, sss, param )
global DEBUG

[N,M] = size(im);
[X,Y] = meshgrid(-N/2:N/2-1,-M/2:M/2-1);
CONV_FT_factor = 1;		% ���̌W���̓t���l���ߎ��@�ƃR���{�����[�V�����@�̋��x����v�����邽�߂Ɏg��
						%     CONV_FT_factor = N /lamda /z *2 *pi;
 						% �̂Ƃ���v���邪�A���܂�Ӗ��Ȃ�
						
dv = param.dv;
du = param.du;
	
x0 = param.x0;
y0 = param.y0;

v0 = param.v0;
u0 = param.u0;

disp(sprintf('dv=%g, du=%g\n(x0,y0)=(%g,%g)\n(v0,u0)=(%g,%g)',dv,du,x0,y0,v0,u0));


% �X�P�[���t�@�N�^�[
Sxv = dx * dv;
Syu = dy * du;

% �z���O�����ʂ̍��W�ϊ�
xr = x0 + X * dx;
ys = y0 + Y * dy;

% �Đ��ʂ̍��W�ϊ�
vm = v0 + X * dv;
un = u0 + Y * du;


%==========================================================================
% ��{�W��
Amn = exp(i*(2*pi/lamda)*z)/(i*lamda*z);
Amn = Amn .* exp( i * pi * lamda * z * ( vm.^2 + un.^2 ));
Amn = Amn .* exp(-i * 2 * pi * ( X*x0*dv + Y*y0*du ));

	if DEBUG,	figure;	imshow( index_phase(angle(Amn),'jet'),[],'notruesize');colorbar;title('��{�W��');	end

%=========================================================================
% �V�t�e�b�h�t���l���ŗL�̌W��
Ask = exp(-i * pi * ( Sxv * X.^2 + Syu * Y.^2 ));

	if DEBUG,	figure;	imshow(index_phase(angle(Ask),'jet'),[],'notruesize');colorbar;title('�ʌW��');	end

% ��{�W����������
Ask = Ask .* Amn;																	clear Amn

Ask = padarray(Ask,[N/2,M/2],'both');	% �G�C���A�X������邽�߂Ƀ[���p�b�h���ĂQ�{�ɂ���


%==========================================================================
% �ԁi���j
Kai = im .* exp(i * (pi/lamda/z) * ( xr.^2 + ys.^2 )) .* exp(-i * 2 * pi * (xr * v0 + ys * u0));
Kai = Kai .* exp(-i * pi * ( Sxv * X.^2 + Syu * Y.^2 ));

	if DEBUG,	figure;	imshow(index_phase(angle(Kai),'jet'),[],'notruesize');colorbar;title('�ԁi���j');	end

Kai = padarray(Kai,[N/2,M/2],'both');	% �G�C���A�X������邽�߂Ƀ[���p�b�h���ĂQ�{�ɂ���

% �t�t�[���G�ϊ�����
ftKai = fftshift( fft2( fftshift(Kai) ) );											clear Kai

	if DEBUG,	figure;	imshow(abs(ftKai),[],'notruesize');colorbar;	end

%==========================================================================
% �āi���j
Zeta = exp(i * pi * ( Sxv * X.^2 + Syu * Y.^2 ));

	if DEBUG,	figure;	imshow(index_phase(angle(Zeta),'jet'),[],'notruesize');colorbar;title('�āi���j');	end
	
Zeta = padarray(Zeta, [N/2,M/2],'both');	% �G�C���A�X������邽�߂Ƀ[���p�b�h���ĂQ�{�ɂ���

% �t�t�[���G�ϊ�����
ftZeta = fftshift( fft2( fftshift(Zeta) ) );										clear Zeta X Y

	if DEBUG,	figure;	imshow(abs(ftZeta),[],'notruesize');colorbar;	end

%==========================================================================
% �e���̋t�t�[���G�ϊ����m�������ăt�[���G�ϊ�

ftZeta = ftKai .* ftZeta;															clear ftKai
wavefront = Ask .* ifftshift( ifft2( ifftshift( ftZeta ) ) );						clear ftZeta

disp(['�y3�z  z=',num2str(z)]);

	
%===========================================================================
%%% ���S���݂̂�Ԃ��A������g���ƃf�[�^���������ɂȂ�
if strcmp(sss,'same')
	wavefront = wavefront( N/2+1:N+N/2, M/2+1:M+M/2 );
end