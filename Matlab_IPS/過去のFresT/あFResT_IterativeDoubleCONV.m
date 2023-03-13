function wavefront = FResT_IterativeDoubleCONV( im, lambda, z, dx, dy, method, sss )

[WX,WY] = size(im);
[X,Y] = meshgrid(-WX/2:WX/2-1,-WY/2:WY/2-1);

% deltaZ���݂Ōv�Z���܂�
deltaZ = z/10;


%%% �G�C���A�X������邽�߂Ƀ[���p�b�h���ĂQ�{�ɂ���
WXd2=WX/2;
WYd2=WY/2;
im = padarray(im,[WXd2,WYd2]);


% �ʑ���
de=1/(2*WX*dx);			% 2�{�̈�ɂ���̂Ńf�[�^����2�{�ɂ����A����ł�������
dn=1/(2*WY*dy);
gphs = exp(-i*pi*lambda*deltaZ.*( (X.*de).^2 + (Y.*dn).^2 ));
clear X Y
gphs = padarray(gphs,[WXd2,WYd2]);


%%% �����t���l���ϊ�
for c = deltaZ : deltaZ : z

	% �z���O�������t�t�[���G�ϊ�����
	ftim = fftshift( ifft2( fftshift(im) ) );

	% �e���̋t�t�[���G�ϊ����m�������ăt�[���G�ϊ�
	% �y�V���ɒǉ��z���m�ɂ͋������Ɋւ���ʑ������|���Z�����
	%               ���������ƈʑ����������ς��̂œ`�����Ă���悤�Ɍ�����i�t�Ɉʑ��̕ω�������Ȃ�j
	uo = deltaZ/lambda - fix(deltaZ/lambda);
	im = exp(i*2*pi*uo) .* fftshift( fft2( fftshift( gphs.*ftim ) ) );

	disp(['�y4�z z=',num2str(c),'  uo=',num2str(uo)]);
	%disp(['             2*pi*uo=',num2str(2*pi*uo),'  exp(-i*2*pi*uo)=',num2str(angle(exp(-i*2*pi*uo))),'  uo=',num2str(uo)]);
	%disp(['      fix(count/lambda)=', num2str( fix(count/lambda) ),'  count/lambda=',num2str(count/lambda) ]);

		% show_results(im,gphs,ftim,wavefront);	% �y�m�F�z
end

%===========================================================================
%%% ���S���݂̂�Ԃ��A������g���ƃf�[�^���������ɂȂ�
if strcmp(sss,'same')
	wavefront = im( WXd2+1:WX+WXd2, WYd2+1:WY+WYd2 );
else
	wavefront = im;
end



	% �y���o�[�W�����z���ۏ�͂���Ŗ��Ȃ�
	% 	wavefront = fftshift(ifft2(fftshift( gphs.*ftim )));
