% raw16�ŃZ�[�u���Ă�������
% �|�C���g�O���C�Ђ�RAW�t�H�[�}�b�g�f�[�^��ǂݍ��݂܂�
% 1928�~1448��f�̔z��Ƃ���
% 1024�~1024��f�̔z��Ƃ���
% 2048�~2048��f�̔z��Ƃ���
% 1280�~1024��f�̔z��Ƃ���

function im = PGRAWimread(filename)

%filename(end-3:end)

if strcmp(filename(end-3:end),'.raw')

	% RAW�t�@�C�����I�[�v��
	fid = fopen(filename, 'r');
	
	% �Q�o�C�g(ushort)�Ńt�@�C���̍Ō�܂œǂ݂���
	[data, count] = fread(fid, inf, 'ushort');
	
	fclose(fid);
	
	%�ǂݏo�������摜�T�C�Y�𐄒肷��
	switch count
	case (1928 * 1448)
		NX = 1928;
		NY = 1448;
		disp('�ꎟ���z���1928�~1448�摜�ɒ���');
		
	case (1024 * 1024)
		NX = 1024;
		NY = 1024;
		disp('�ꎟ���z���1024�~1024�摜�ɒ���');
		
    case (2048 * 2048)
		NX = 2048;
		NY = 2048;
		disp('�ꎟ���z���2048�~2048�摜�ɒ���');
		
	case (1920 * 1024)			%	NX = 1920;	NY = 1024;	data = double( reshape(data,NX,NY) );
		NX = 1280;
		NY = 1024;
		data = reshape(data,[3,655360])';		%1024*1920/3=655360
		data(:,3) = [];
		data = data';
		disp('�ꎟ���z���1280�~1024�摜�ɒ���');
		
	end

	% �ꎟ���z���NX�~NY�摜�ɒ���
	im = double( reshape(data,NX,NY)' );
	
else
	
	im = double( imread(filename) );
	
end

		 
% figure;imshow(im,[],'notruesize');colorbar;axis on;
	