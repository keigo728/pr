%
% wasabi‚ÌrbfƒtƒH[ƒ}ƒbƒgƒf[ƒ^‚ğ‚P‚O‚Q‚S~‚P‚O‚Q‚S‰æ‘f‚Ì”z—ñ‚Æ‚µ‚Ä“Ç‚İ‚İ‚Ü‚·
%
function im = RBFimread(filename)

% filename(end-3:end)

if strcmp(filename(end-3:end),'.rbf')
	
	N=1024;
	fid = fopen(filename, 'r');
	fim = fread(fid, 2049*1000, 'ushort');
	%%% ƒwƒbƒ_
	% head = fim(1:8*4);
	%%% 12bitƒf[ƒ^
	% data = fim(8*4+1:8*4+5)';
	fclose(fid);

	% 12bitƒf[ƒ^‚ğæ‚èo‚µ‚Ä‚P‚O‚Q‚S~‚P‚O‚Q‚S‰æ‘œ‚É’¼‚·
	tim = fim(8*4+1:8*4+N*N);
	im = reshape(tim,N,N)';

	% 	figure;imshow(tim,[0,4095]);colorbar;axis on;
	
else
	im = imread(filename);

	[x,y,z] = size(im);
	if z==3
		im = double( rgb2gray(im(1:1024,1:1024,:)) );
	else
		im = double( im(1:1024,1:1024,:) );
	end
end
