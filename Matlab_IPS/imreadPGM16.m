function pgmimg = imreadPGM16(fname,figctl)

fid = fopen(fname,'r');
[A,p] = fread(fid,3,'ubit8');

% pgm�ݒ�l
char(A(1:3,1))';

%-------------------------------------
count=1;
while(1)
	B(count)=fread(fid,1,'ubit8');
	if B(count)==32
		break;
	end
	count=count+1;
end
w = str2double(char(B));
p=p+count;

%-------------------------------------
count=1;
while(1)
	B(count)=fread(fid,1,'ubit8');
	if B(count)==10
		break;
	end
	count=count+1;
end
h = str2double(char(B));
p=p+count;

%-------------------------------------
count=1;
while(1)
	B(count)=fread(fid,1,'ubit8');
	if B(count)==10
		break;
	end
	count=count+1;
end
L = str2double(char(B));
p=p+count;

disp(['     w=' num2str(w) ',  h=' num2str(h) ',  L=' num2str(L)]);

fclose(fid);

%---------------------------------------------
% disp('     �f�[�^�݂̂����o��');
fid = fopen(fname,'r','b');

c=fread(fid,p,'ubit8');

[A,count] = fread(fid,'ubit16');	% �w�b�_�����������ĕʂ̔z��ɑ������
fclose(fid);

d=count-w*h;
disp(['     �ǂݍ��݃f�[�^����' num2str(count) ,'   check��' num2str(d)]);

if d==0
	disp(['     Good, �f�[�^���� ' num2str(w) ' x ' num2str(h) ' = ' num2str(w*h)]);
else
	disp(['     �Ԉ���Ă܂��C�f�[�^���� ' num2str(w) ' x ' num2str(h) ' = ' num2str(w*h)]);
	break
end

pgmimg = A;

% pgm�t�@�C���̃w�b�_���C
pgmimg=reshape(pgmimg,w,h)';

% ma=max(pgmimg(:))
% mi=min(pgmimg(:))


if (nargin==2)
	if strcmp(figctl,'ON')
		figure;
		imshow(pgmimg,[],'notruesize');colorbar;
		title(['Max=' num2str(max(pgmimg(:))) ' Min=' num2str(min(pgmimg(:)))]);
		drawnow;

		A(end-5:end)
	end
end
