function low_filter( holo, Rwave, z, initSet )

[X,Y] = size(holo);
%X = 2000; Y = 2000;
% FFT
ftholo = fftshift(fft2(holo));

%max(abs(ftholo(:)))

figure; imshow(abs(ftholo),[0 1e4]); colormap(gray); caxis([0 400]); colorbar; axis on;


%filter
f = zeros(X,Y);
%f(150:250, 115:215) = 1; %512×512
f(650:950, 400:900) = 1; %1920×1080
figure; imshow( f, [ ]); axis on;

filftholo = ftholo.*f;

figure; imshow(abs(filftholo),[0 1e4]); colormap(gray); caxis([0 400]); colorbar; axis on;

filholo = ifft2(fftshift(filftholo));

figure; imshow(abs(filholo),[0 1e4]); colormap(gray); caxis([0 max(abs(filholo(:)))]); colorbar; axis on;

comm.C = 'obj\_x\_ref';
comm.method = 'FRT';	comm.OX = 600;	comm.OY = 350;
IMDH_reco( filholo, 0, initSet, z, comm);


comm.method = 'DOUBLE_ANGULAR';	
comm.OX = 600;  comm.OY = 350;
IMDH_reco( filholo .* (Rwave.spatialShiftPhase), 0, initSet, z, comm);	% 斜入射参照光の成分をかけて再生すると物体光が中央に現れる