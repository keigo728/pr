function wavefront = FRT_singleFFT(im,lambda,z,dx,dy,method,count,sss)

[WX,WY] = size(im);
[X,Y] = meshgrid(-WX/2:WX/2-1,-WY/2:WY/2-1);

% �ʑ���
phs = (pi/lambda/z).*( (X*dx).^2 + (Y*dy).^2 );
phs = exp(i*phs);
	
% �ʑ�����������
im_phase = im.*phs;

% FFT
ft_im_phase = fftshift(ifft2(fftshift(im_phase)))/WX/WY;

% �W���̐ݒ�
keisu = pi*lambda*z.*( (X/(WX*dx)).^2 + (Y/(WY*dy)).^2 );
    

% �y���o�[�W�����z���ۏ�͂���Ŗ��Ȃ�
% wavefront = exp(i*keisu).*ft_im_phase;
	
% �y�V���ɒǉ��z���m�ɂ͋������Ɋւ���ʑ������|���Z�����
%               ���������ƈʑ����������ς��̂œ`�����Ă���悤�Ɍ�����
%              �i�t�Ɉʑ��̕ω�������Ȃ�j
uo = z/lambda - fix(z/lambda);
wavefront = (-i/lambda/z)*exp(i*2*pi*uo).*exp(i*keisu).*ft_im_phase;		

