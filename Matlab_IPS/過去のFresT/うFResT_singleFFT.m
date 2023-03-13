function wavefront = FResT_singleFFT( im, lamda, z, dx, dy, method )

LENGTHORDER = 1e6;	% �Ō�Œl���傫���Ȃ�̂�h�����߃ʂ��I�[�_�[��ς���
					% �Ō�̌W���̕����ȊO�͖��������ɂȂ�̂ŉe���Ȃ�

[N,M] = size(im);
[X,Y] = meshgrid(-N/2:N/2-1,-M/2:M/2-1);

% �W���ʑ��̐ݒ�
de = 1/(N*dx);
dn = 1/(M*dy);
coeff = ( lamda * z /2) .* ( (X*de).^2 + (Y*dn).^2 );
coeff = coeff - fix(coeff);

% �ʑ�����������
phs = ( 1/2 /lamda /z) .* ( (X*dx).^2 + (Y*dy).^2 );
phs = phs - fix(phs);
im = im .* exp(i*2*pi*phs);													clear X Y phs

% FFT
ftim = fftshift( fft2( fftshift(im) ) );


% �y�V���ɒǉ��z���m�ɂ͋������Ɋւ���ʑ������|���Z�����
%               ���������ƈʑ����������ς��̂œ`�����Ă���悤�Ɍ�����
%              �i�t�Ɉʑ��̕ω�������Ȃ�j
uo = z/lamda - fix(z/lamda);
Ad = exp(i*2*pi*uo);
lamda = lamda * LENGTHORDER;
z = z * LENGTHORDER;
wavefront = (-i/lamda/z) * Ad .* exp(i*2*pi*coeff) .* ftim;		


%------------------------------------------------------------------------

% �y���o�[�W�����z���ۏ�͂���Ŗ��Ȃ�
% wavefront = exp(i*coeff).*ft_cim;