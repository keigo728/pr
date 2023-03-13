function wavefront = FResT_singleCONV( im, lamda, z, dx, dy, method )

[N,M] = size(im);
[X,Y] = meshgrid(-N/2:N/2-1,-M/2:M/2-1);
CONV_FT_factor = 1;		% ���̌W���̓t���l���ߎ��@�ƃR���{�����[�V�����@�̋��x����v�����邽�߂Ɏg��
						%     CONV_FT_factor = N /lamda /z *2 *pi;
 						% �̂Ƃ���v���邪�A���܂�Ӗ��Ȃ�
						
% ���g�����̍��ݕ�
de=1/(N*dx);
dn=1/(M*dy);

% �ʑ���
theta = (lamda*z/2) .* ( (X.*de).^2 + (Y.*dn).^2 );
theta = theta - fix(theta);								% ����͂Q���ΐ������v�Z���Ȃ��悤�ɂ��邽��
gphs = exp( -i * 2 * pi * theta ) * CONV_FT_factor;								clear theta


% �y�e�X�g�z�ʑ����𒼐�FFT�ŋ��߂�Ƃ�
%           ������g���ƃt���l���ߎ��@�Ɠ������x�ōĐ������
%           �������A�Đ��@���قȂ�̂ő傫�ȈӖ�������킯�łȂ�
% gphs = fftshift( fft2( fftshift(   (-i/lamda/z) * exp( i*(pi/lamda/z) * ((X.*dx).^2+(Y.*dy).^2) )   )));

																				clear X Y
% �z���O�������t�t�[���G�ϊ�����
ftim = fftshift( fft2( fftshift(im) ) );


% �ʑ����Ɗ|����
ftim = gphs .* ftim;															clear gphs

% �������Ɋւ���ʑ���
uo = z/lamda - fix(z/lamda);
Ad = exp(i*2*pi*uo);

% �������Ɋւ���ʑ������|���Z�����
% ���x�ōl����Ƃ��͂Ȃ��Ă��悢
% ���������ƈʑ����������ς��̂œ`�����Ă���悤�Ɍ�����i�t�Ɉʑ��̕ω�������Ȃ�j
wavefront = Ad .* ifftshift( ifft2( ifftshift( ftim ) ) );



%--------------------------------------------------------------------------

% �e���̋t�t�[���G�ϊ����m�������ăt�[���G�ϊ�
% �y���o�[�W�����z���ۏ�͂���Ŗ��Ȃ�
% 	wavefront = fftshift(fft2(fftshift( gphs.*ftim )));