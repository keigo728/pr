function reconstruction( holo, Rwave, z, initSet )
global SVFOLDER
global SVF

%---------------------------------------------
% 再生
comm.C = 'obj\_x\_ref';
comm.method = 'FRT';	comm.OX = 600;	comm.OY = 350;
IMDH_reco( holo, 0, initSet, z, comm);
saveas(gcf,[SVFOLDER SVF comm.method '.png']);

comm.method = 'DOUBLE_ANGULAR';	
comm.OX = 600;  comm.OY = 350;
IMDH_reco( holo .* (Rwave.spatialShiftPhase), 0, initSet, z, comm);	% 斜入射参照光の成分をかけて再生すると物体光が中央に現れる
saveas(gcf,[SVFOLDER SVF comm.method '.png']);


%=============================================================
% % HPFでゼロ次の抑制
% fringe = gaussianFilter( fringe, 'HPF' );
% 
% holo = zeros(N,N);
% holo(N/2-M/2+1:N/2+M/2,N/2-M/2+1:N/2+M/2) = fringe(:,:);
% 
% 	showWaveAmpPhsRecoAmpPhs(holo, 0);	% 確認
% 	figure;	imshow(holo,[],'InitialMagnification','fit');
% 			title(['HPFでゼロ次の抑制  z=' num2str(z)]);	colorbar;	axis on;	drawnow;
% 			
% %---------------------------------------------
% % 再生
% comm.C = 'HPFでゼロ次の抑制obj\_x\_ref';
% comm.method = 'FRT';	comm.OX = 1000;	comm.OY = 350;
% IMDH_reco( holo, 0, initSet, z, comm);
% saveas(gcf,[SVFOLDER SVF 'HPFでゼロ次の抑制' comm.method '.png']);
% 
% comm.method = 'DOUBLE_ANGULAR';	comm.OY = 350;
% IMDH_reco( holo .* (Rwave.spatialShiftPhase), 0, initSet, z, comm);	
% saveas(gcf,[SVFOLDER SVF 'HPFでゼロ次の抑制' comm.method '.png']);

