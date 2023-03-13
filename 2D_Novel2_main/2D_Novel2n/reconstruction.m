function reconstruction( holo, Rwave, z, initSet )
global SVFOLDER
global SVF

%---------------------------------------------
% Ä¶
comm.C = 'obj\_x\_ref';
comm.method = 'FRT';	comm.OX = 600;	comm.OY = 350;
IMDH_reco( holo, 0, initSet, z, comm);
saveas(gcf,[SVFOLDER SVF comm.method '.png']);

comm.method = 'DOUBLE_ANGULAR';	
comm.OX = 600;  comm.OY = 350;
IMDH_reco( holo .* (Rwave.spatialShiftPhase), 0, initSet, z, comm);	% Î“üËQÆŒõ‚Ì¬•ª‚ğ‚©‚¯‚ÄÄ¶‚·‚é‚Æ•¨‘ÌŒõ‚ª’†‰›‚ÉŒ»‚ê‚é
saveas(gcf,[SVFOLDER SVF comm.method '.png']);


%=============================================================
% % HPF‚Åƒ[ƒŸ‚Ì—}§
% fringe = gaussianFilter( fringe, 'HPF' );
% 
% holo = zeros(N,N);
% holo(N/2-M/2+1:N/2+M/2,N/2-M/2+1:N/2+M/2) = fringe(:,:);
% 
% 	showWaveAmpPhsRecoAmpPhs(holo, 0);	% Šm”F
% 	figure;	imshow(holo,[],'InitialMagnification','fit');
% 			title(['HPF‚Åƒ[ƒŸ‚Ì—}§  z=' num2str(z)]);	colorbar;	axis on;	drawnow;
% 			
% %---------------------------------------------
% % Ä¶
% comm.C = 'HPF‚Åƒ[ƒŸ‚Ì—}§obj\_x\_ref';
% comm.method = 'FRT';	comm.OX = 1000;	comm.OY = 350;
% IMDH_reco( holo, 0, initSet, z, comm);
% saveas(gcf,[SVFOLDER SVF 'HPF‚Åƒ[ƒŸ‚Ì—}§' comm.method '.png']);
% 
% comm.method = 'DOUBLE_ANGULAR';	comm.OY = 350;
% IMDH_reco( holo .* (Rwave.spatialShiftPhase), 0, initSet, z, comm);	
% saveas(gcf,[SVFOLDER SVF 'HPF‚Åƒ[ƒŸ‚Ì—}§' comm.method '.png']);

