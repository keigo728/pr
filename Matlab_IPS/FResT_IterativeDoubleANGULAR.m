function wavefront = FResT_IterativeDoubleCONV( im, lamda, z, dx, dy, method, sss )

[N,M] = size(im);
[X,Y] = meshgrid(-N/2:N/2-1,-M/2:M/2-1);
CONV_FT_factor = 1;		% ���̌W���̓t���l���ߎ��@�ƃR���{�����[�V�����@�̋��x����v�����邽�߂Ɏg��
						%     CONV_FT_factor = N /lamda /z *2 *pi;
 						% �̂Ƃ���v���邪�A���܂�Ӗ��Ȃ�

% deltaZ���݂Ōv�Z���܂�
dz = z/10;

%%% �G�C���A�X������邽�߂Ƀ[���p�b�h���ĂQ�{�ɂ���
Nd2=N/2;
Md2=M/2;
im = padarray(im,[Nd2,Md2]);

% ���g�����̍��ݕ�
de=1/(2*N*dx);			% 2�{�̈�ɂ���̂Ńf�[�^����2�{�ɂ����A����ł�������
dn=1/(2*M*dy);

% �ʑ���
% �����̒��̒l
theta = 1/lamda.^2 - (X.*de).^2 - (Y.*dn).^2;
% �����������ɂȂ邩�`�F�b�N�A���������Ȃ��AA=0�ŋ����I�Ƀ[���ɂ���
AA = ones(size(theta));
AA(theta<0)=0;
theta(AA==0)=0;
% ����͂Q���ΐ������v�Z���Ȃ��悤�ɂ��邽��
theta = (dz) .* sqrt( theta );
theta = theta - fix(theta);
% �����������ɂȂ�Ƃ��̓[���ɂ���
gphs = AA .* exp( i * 2 * pi * theta );											clear X Y theta

	if min(AA(:))==0
		figure;	imshow(AA,[],'notruesize');colorbar;drawnow;
	end
	
%%% �G�C���A�X������邽�߂Ƀ[���p�b�h���ĂQ�{�ɂ���
gphs = padarray(gphs,[Nd2,Md2]);


%%% �����t���l���ϊ�
for c = dz : dz : z

	% �z���O�������t�t�[���G�ϊ�����
	ftim = fftshift( fft2( fftshift(im) ) );

	% �ʑ����Ɗ|����
	ftim = gphs .* ftim;

	% �e���̋t�t�[���G�ϊ����m�������ăt�[���G�ϊ�
	% �y�V���ɒǉ��z���m�ɂ͋������Ɋւ���ʑ������|���Z�����
	%               ���������ƈʑ����������ς��̂œ`�����Ă���悤�Ɍ�����i�t�Ɉʑ��̕ω�������Ȃ�j
	im = ifftshift( ifft2( ifftshift( ftim ) ) );

	disp(['�y4�z z=',num2str(c)]);
	%disp(['             2*pi*uo=',num2str(2*pi*uo),'  exp(-i*2*pi*uo)=',num2str(angle(exp(-i*2*pi*uo))),'  uo=',num2str(uo)]);
	%disp(['      fix(count/lamda)=', num2str( fix(count/lamda) ),'  count/lamda=',num2str(count/lamda) ]);

		% show_results(im,gphs,ftim,wavefront);	% �y�m�F�z
end

%===========================================================================
%%% ���S���݂̂�Ԃ��A������g���ƃf�[�^���������ɂȂ�
if strcmp(sss,'same')
	wavefront = im( Nd2+1:N+Nd2, Md2+1:M+Md2 ) * CONV_FT_factor;
else
	wavefront = im * CONV_FT_factor;
end



	% �y���o�[�W�����z���ۏ�͂���Ŗ��Ȃ�
	% 	wavefront = fftshift(ifft2(fftshift( gphs.*ftim )));
