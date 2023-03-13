function wave = selectWaveType( wave, initSet, fname)
global SVFOLDER
global SVF

switch (wave.type)
case 'sphere'

	disp('●●●　球面波　●●●');
	twaveData = waveSphereINI( initSet, wave );

	%====================================================================
	% 再生像を中央にシフトさせる位相成分をここでつくっておく
	% 3次元極座標系では、(X,Y,Z)=(rsinQcosP,rsinQcosP,rcosQ)より、
	% 球面波の原点の方向からの平面波を考える
	%====================================================================
	dx = initSet.CCDdx;
	dy = initSet.CCDdy;
	k  = 2*pi/initSet.lamda;	
	OX = wave.OX;
	OY = wave.OY;
	PP = atan2(OY,OX);
	QQ = acos( (wave.Z)/sqrt( (OX*dx).^2 + (OY*dy).^2 + (wave.Z).^2) );
	shiftPhase = exp( 1i * k * sin(QQ) * ( initSet.SX*dx*cos(PP) + initSet.SY*dy*sin(PP) ));
	
	
case 'plane'
	
	disp('■■■　平面波　■■■');	
	twaveData = wavePlaneINI( initSet, wave );
	
	%====================================================================
	% 再生像を中央にシフトさせる位相成分をここでつくっておく
	%====================================================================
	shiftPhase = exp( 1i * angle(twaveData) );
	
end

wave.WAVE = twaveData;
wave.spatialShiftPhase = shiftPhase;

	%showWaveRealImagAbsAngle( wave.WAVE, [wave.type '@selectWaveType'] );	

	if nargin > 2
%		disp('波面データのセーブ');
		save([SVFOLDER SVF fname '.mat'], 'wave');
	end
