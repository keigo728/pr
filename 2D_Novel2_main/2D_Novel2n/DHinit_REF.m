Rwave.type = 'plane';
Rwave.INLINE_and_OFFAXIS = 'OFFAXIS';		%'INLINE';		%	'OFFAXIS';		%

% 初期位相
Rwave.PHSshift = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-----------------------------------
% 参照波 の設定
%-----------------------------------
switch(Rwave.type)
case 'plane'
	
	% 平面波　デフォルト(theta,XYangle)=(1.5*pi/180,45*pi/180)
	switch  Rwave.INLINE_and_OFFAXIS
	case 'INLINE'
		Rwave.theta = 0;
		Rwave.XYangle = 0;
	case 'OFFAXIS'	
		Rwave.theta   = 1.5 * (pi/180);		% 入射角度φ（干渉縞の周期に影響する）	% 1.5*pi/180;		1.5	% theta=asin(1.7*lamda/CCD.dx)
		Rwave.XYangle =  30 * (pi/180);		% 入射角度θ（中心からずれたときの方向）	45
	end
	
case 'sphere'
	
	% 球面波の点光源の位置 [m] デフォルト(X,Y,Z)=(500,-1000,0.5)
% 	Rwave.Z  = -0.5;		% レンズレスフーリエ変換型
% 	Rwave.OX = 1000; 	Rwave.OY = 1100;		%	Rwave.OX = 512;	Rwave.OY = 400;		% 	
		
		% (OX,OY)=(1500,1500)のときシフト量はちょうど中心から角になる
		% (OX,OY)=(2000,1700)のときシフト量は一周り回ってしまう
		% (OX,OY)=(1000,1100)程度がちょうどよさそう
		
	%---------------------------------------------------------------------
	% 物体位置=0.5と異なる位置
	%---------------------------------------------------------------------
% 	Rwave.Z  = -1.2;
% 	Rwave.OX = 2000;	Rwave.OY = 1800;		%	Rwave.OX = 512;	Rwave.OY = 400;		% 	
		
% 	Rwave.Z  = -0.8;
% 	Rwave.OX = -2000; 	Rwave.OY = 700;	%	Rwave.OX = 512;	Rwave.OY = 400;		% 	
	
	%---------------------------------------------------------------------
	% 点光源参照の位置を変えたときの再生像
	%---------------------------------------------------------------------
	Rwave.Z  = -0.05;
	Rwave.OX = 16;	Rwave.OY = 8;		%	Rwave.OX = 50;	Rwave.OY = 30;		%	
		
end

%---------------------------------------------------
%%% 初期位相を決める、デフォルトは「4*exp(1i*0)」
%---------------------------------------------------
Rwave.amp = 2 * exp(1i * (Rwave.PHSshift) )
