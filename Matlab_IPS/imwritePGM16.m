function imwritePGM16(im,fname)

[h,w]=size(im);

fid = fopen(fname,'w','b');

	fprintf(fid, 'P5\n');
	fprintf(fid, '%d %d\n', w, h);
	fprintf(fid, '65535\n');
	
	im = im';
	
	fwrite(fid, im, 'ubit16');
	
fclose(fid);

