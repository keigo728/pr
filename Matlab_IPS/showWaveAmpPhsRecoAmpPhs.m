function showWaveAmpPhsRecoAmpPhs(im, fresnelPhase, sss, zoom)
% im			: ���f�U��
% fresnelPhase	: �t���l���ʑ���
% sss			: �^�C�g��
% zoom			: �Y�[���A�b�v

if nargin < 3
	sss = 'test';
end

[x,y]=size(im);

		figure;
		subplot(3,2,1);	imshow(real(im),[]);axis on; colorbar;
						title([sss ' �U��']);
		subplot(3,2,2);	imshow(index_phase(angle(im),'jet'));axis on; colorbar;
						title('�ʑ� @showWaveAmpPhsRecoAmpPhs()');

% ��x�Đ����܂��A�����ăt���l���ʑ������|���Z���܂�
sExp = shiftifft2(im) .* exp(i*fresnelPhase);

intensity=abs(sExp).^2;
ma = max_control(intensity);		% �c���̒���

		subplot(3,2,3);	imshow(intensity,[0,ma]);axis on; colorbar;
						title('FFT�Đ����@���x');
		subplot(3,2,4);	imshow(index_phase(angle(sExp),'jet'));	axis on; colorbar;
						title('�Đ����@�ʑ�');					
		subplot(3,2,5);	plot(1:x,intensity(x/2+1,:),'r-',1:y,intensity(:,y/2+1),'b:');
						title('FFT�Đ����@���x@centerLine');xlim([1 x]);
		subplot(3,2,6);	plot(1:x,angle(sExp(x/2+1,:)),'r-',1:y,angle(sExp(:,y/2+1)),'b:');
						title('FFT�Đ����@�ʑ�@centerLine');xlim([1 x]);
						drawnow;


% �������𔲂��o��
if nargin > 2
	if strcmp(flag,'ZOOM')
		[X,Y]=size(im);
		
		u=X/2-63:X/2+64;
		v=Y/2-63:Y/2+64;
		figure;	imshow(intensity(u,v),[0,ma]);axis on; colorbar;
				title('�Đ����@���x');
		figure;	imshow(angle(sExp(u,v)),[-pi,pi]);axis on; colorbar;colormap(jet);
				title('�Đ����@�ʑ�');
		drawnow;
	end
end
