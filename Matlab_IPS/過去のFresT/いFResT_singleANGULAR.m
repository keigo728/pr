function wavefront = FResT_singleANGULAR( im, lamda, z, dx, dy, method )

[N,M] = size(im);
[X,Y] = meshgrid(-N/2:N/2-1,-M/2:M/2-1);
CONV_FT_factor = 1;		% ���̌W���̓t���l���ߎ��@�ƃR���{�����[�V�����@�̋��x����v�����邽�߂Ɏg��
						%     CONV_FT_factor = N /lamda /z *2 *pi;
 						% �̂Ƃ���v���邪�A���܂�Ӗ��Ȃ�

% ���g�����̍��ݕ�
de=1/(N*dx);
dn=1/(M*dy);

% �ʑ���
theta = (z) .* sqrt( 1/lamda.^2 - (X.*de).^2 - (Y.*dn).^2 );
theta = theta - fix(theta);								% ����͂Q���ΐ������v�Z���Ȃ��悤�ɂ��邽��
gphs = exp( i * 2 * pi * theta ) * CONV_FT_factor;								clear theta
																				clear X Y
																				
% �z���O�������t�t�[���G�ϊ�����
ftim = fftshift( fft2( fftshift(im) ) );


% �ʑ����Ɗ|����
ftim = gphs .* ftim;															clear gphs


% �t�t�[���G�ϊ�
wavefront = ifftshift( ifft2( ifftshift( ftim ) ) );
