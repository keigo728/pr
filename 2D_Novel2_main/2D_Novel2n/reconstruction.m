function reconstruction( holo, Rwave, z, initSet )
global SVFOLDER
global SVF

%---------------------------------------------
% �Đ�
comm.C = 'obj\_x\_ref';
comm.method = 'FRT';	comm.OX = 600;	comm.OY = 350;
IMDH_reco( holo, 0, initSet, z, comm);
saveas(gcf,[SVFOLDER SVF comm.method '.png']);

comm.method = 'DOUBLE_ANGULAR';	
comm.OX = 600;  comm.OY = 350;
IMDH_reco( holo .* (Rwave.spatialShiftPhase), 0, initSet, z, comm);	% �Γ��ˎQ�ƌ��̐����������čĐ�����ƕ��̌��������Ɍ����
saveas(gcf,[SVFOLDER SVF comm.method '.png']);


%=============================================================
% % HPF�Ń[�����̗}��
% fringe = gaussianFilter( fringe, 'HPF' );
% 
% holo = zeros(N,N);
% holo(N/2-M/2+1:N/2+M/2,N/2-M/2+1:N/2+M/2) = fringe(:,:);
% 
% 	showWaveAmpPhsRecoAmpPhs(holo, 0);	% �m�F
% 	figure;	imshow(holo,[],'InitialMagnification','fit');
% 			title(['HPF�Ń[�����̗}��  z=' num2str(z)]);	colorbar;	axis on;	drawnow;
% 			
% %---------------------------------------------
% % �Đ�
% comm.C = 'HPF�Ń[�����̗}��obj\_x\_ref';
% comm.method = 'FRT';	comm.OX = 1000;	comm.OY = 350;
% IMDH_reco( holo, 0, initSet, z, comm);
% saveas(gcf,[SVFOLDER SVF 'HPF�Ń[�����̗}��' comm.method '.png']);
% 
% comm.method = 'DOUBLE_ANGULAR';	comm.OY = 350;
% IMDH_reco( holo .* (Rwave.spatialShiftPhase), 0, initSet, z, comm);	
% saveas(gcf,[SVFOLDER SVF 'HPF�Ń[�����̗}��' comm.method '.png']);

