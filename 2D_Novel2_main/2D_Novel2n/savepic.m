function Z = savepic( twoholo)
global SVFOLDER
global SVF

filename = sprintf('%s%sORsavepic.tif', SVFOLDER, SVF);
imwrite( uint8(twoholo), filename, 'tif');

Z = 1;