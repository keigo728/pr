function wave = selectWaveType( wave, initSet, fname)
global SVFOLDER
global SVF

switch (wave.type)
case 'sphere'

	disp('�������@���ʔg�@������');
	twaveData = waveSphereINI( initSet, wave );

	%====================================================================
	% �Đ����𒆉��ɃV�t�g������ʑ������������ł����Ă���
	% 3�����ɍ��W�n�ł́A(X,Y,Z)=(rsinQcosP,rsinQcosP,rcosQ)���A
	% ���ʔg�̌��_�̕�������̕��ʔg���l����
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
	
	disp('�������@���ʔg�@������');	
	twaveData = wavePlaneINI( initSet, wave );
	
	%====================================================================
	% �Đ����𒆉��ɃV�t�g������ʑ������������ł����Ă���
	%====================================================================
	shiftPhase = exp( 1i * angle(twaveData) );
	
end

wave.WAVE = twaveData;
wave.spatialShiftPhase = shiftPhase;

	%showWaveRealImagAbsAngle( wave.WAVE, [wave.type '@selectWaveType'] );	

	if nargin > 2
%		disp('�g�ʃf�[�^�̃Z�[�u');
		save([SVFOLDER SVF fname '.mat'], 'wave');
	end
