function imshowComplexAmplitude( wave, sss, fname)
% ���f�U����}������֐�
% wave  : ���f�U���f�[�^
% sss   : �}�̃^�C�g���A�Ȃ��Ƃ���[]���g��
% fname : �摜�Z�[�u����Ƃ��͂����ɃZ�[�u�t�@�C����������

figure;
subplot(2,2,1);	imshow(real(wave),[],'notruesize');
				colorbar;title([sss 'real']);
subplot(2,2,2);	imshow(imag(wave),[],'notruesize');
				colorbar;title('imag');
subplot(2,2,3);	imshow( abs(wave),[],'notruesize');
				colorbar;title('abs');
subplot(2,2,4);	imshow(index_phase(angle(wave),'jet'),[],'notruesize');
				title('angle');axis on;
				colormap(hot);
				drawnow;

				
if nargin > 2
	% �摜�Z�[�u
	if strcmp( fname(end-3:end), '.jpg')
		saveas(gcf,fname,'jpg');
	else
		saveas(gcf,[fname '.jpg'],'jpg');
	end
end
		