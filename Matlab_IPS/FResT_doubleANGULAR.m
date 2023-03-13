function wavefront = FResT_doubleCONV( im, lamda, z, dx, dy, method, sss )

[N,M] = size(im);
[X,Y] = meshgrid(-N/2:N/2-1,-M/2:M/2-1);
CONV_FT_factor = 1;		% ���̌W���̓t���l���ߎ��@�ƃR���{�����[�V�����@�̋��x����v�����邽�߂Ɏg��
						%     CONV_FT_factor = N /lamda /z *2 *pi;
 						% �̂Ƃ���v���邪�A���܂�Ӗ��Ȃ�
						
% ���g�����̍��ݕ�
de=1/(2*N*dx);
dn=1/(2*M*dy);

%==========================================================================
% �ʑ���
% �����̒��̒l
theta = 1/lamda.^2 - (X.*de).^2 - (Y.*dn).^2;
% �����������ɂȂ邩�`�F�b�N�A���������Ȃ��AA=0�ŋ����I�Ƀ[���ɂ���
AA = ones(size(theta));
AA(theta<0)=0;
theta(AA==0)=0;
% ����͂Q���ΐ������v�Z���Ȃ��悤�ɂ��邽��
theta = (z) .* sqrt( theta );
theta = theta - fix(theta);
% �����������ɂȂ�Ƃ��̓[���ɂ���
gphs = AA .* exp( i * 2 * pi * theta ) * CONV_FT_factor;									clear X Y theta

	if min(AA(:))==0
		figure;	imshow(AA,[],'notruesize');colorbar;drawnow;
	end
	
%==========================================================================
%%% �G�C���A�X������邽�߂Ƀ[���p�b�h���ĂQ�{�ɂ���
gphs = padarray(gphs,[N/2,M/2],'both');


%==========================================================================
%%% �G�C���A�X������邽�߂Ƀ[���p�b�h���ĂQ�{�ɂ���
im = padarray(im, [N/2,M/2],'both');


%==========================================================================
% �z���O�������t�t�[���G�ϊ�����
ftim = fftshift( fft2( fftshift(im) ) );										clear im


%==========================================================================
% �ʑ����Ɗ|����
ftim = gphs .* ftim;															clear gphs


%==========================================================================
% �e���̋t�t�[���G�ϊ����m�������ăt�[���G�ϊ�
% �y�V���ɒǉ��z���m�ɂ͋������Ɋւ���ʑ������|���Z�����
%               ���������ƈʑ����������ς��̂œ`�����Ă���悤�Ɍ����邪�A�t�Ɉʑ��̕ω�������Ȃ�
wavefront = ifftshift( ifft2( ifftshift( ftim ) ) );


disp(['�y3�z  z=',num2str(z)]);
% disp(['      fix(z/lamda)=', num2str( fix(z/lamda) ),'  z/lamda=',num2str(z/lamda) ]);

	
%===========================================================================
%%% ���S���݂̂�Ԃ��A������g���ƃf�[�^���������ɂȂ�
if strcmp(sss,'same')
	wavefront = wavefront( N/2+1:N+N/2, M/2+1:M+M/2 );
end




%--------------------------------------------------------------------------
% �y���o�[�W�����z���ۏ�͂���Ŗ��Ȃ�
% 	wavefront = fftshift(ifft2(fftshift( gphs.*ftim )));
