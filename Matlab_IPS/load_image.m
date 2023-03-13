function x = load_imagefile( filename )

%%%  Check *.jpeg format
jpg_match = findstr(filename,'.jpg');
jpeg_match = findstr(filename,'.jpeg');
JPG_match = findstr(filename,'.JPG');

tif_match = findstr(filename,'.tif');
TIF_match = findstr(filename,'.TIF');


if( jpg_match > 0 )
	tmpdata = imread(filename,'jpg');
elseif( JPG_match > 0 )
	tmpdata = imread(filename,'jpg');
elseif( jpeg_match > 0 )
	tmpdata = imread(filename,'jpg');
	
elseif( TIF_match > 0 )
	tmpdata = imread(filename,'tif');
elseif( tif_match > 0 )
	tmpdata = imread(filename,'tif');
	
else
	tmpdata = load( filename );
end

x = double(tmpdata);
