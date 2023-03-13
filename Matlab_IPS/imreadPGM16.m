function pgmimg = imreadPGM16(fname,figctl)

fid = fopen(fname,'r');
[A,p] = fread(fid,3,'ubit8');

% pgm設定値
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
% disp('     データのみを取り出す');
fid = fopen(fname,'r','b');

c=fread(fid,p,'ubit8');

[A,count] = fread(fid,'ubit16');	% ヘッダ部分を除いて別の配列に代入する
fclose(fid);

d=count-w*h;
disp(['     読み込みデータ数＝' num2str(count) ,'   check＝' num2str(d)]);

if d==0
	disp(['     Good, データ数は ' num2str(w) ' x ' num2str(h) ' = ' num2str(w*h)]);
else
	disp(['     間違ってます，データ数は ' num2str(w) ' x ' num2str(h) ' = ' num2str(w*h)]);
	break
end

pgmimg = A;

% pgmファイルのヘッダより，
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
