function wave = moveWave(Nwave, initSet, fname, x, y)
global SVFOLDER
global SVF

cx = initSet.HCCDY;
cy = initSet.HCCDX;

%wavefront = Nwave.WAVE(x : x + cx - 1, y : y + cy - 1);

for k = 1 : cx
    for l = 1 : cy
        wavefront(k, l) = Nwave.WAVE(x + cx - k, y + cy - l);
    end
end


wave.WAVE = wavefront;
wave.Z = Nwave.Z;

if nargin > 3		
    save([SVFOLDER SVF fname '.mat'],'wave');
end