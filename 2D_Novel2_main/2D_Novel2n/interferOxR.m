function [holo, z, Imax] = interferOxR( Opwave, Rwave, initSet, Imax, count)
global SVFOLDER
global SVF

%N = initSet.CCDX;
%M = initSet.INPUT_IM_SIZE;

%======================================
%  【物体波】と【参照波】との干渉
%======================================
holo = abs( Opwave.WAVE + Rwave.WAVE ).^2;

%==================================================================
% ◆◆◆ 96x96に直す【この部分をコメントアウトすれば１２８×１２８】
%==================================================================
%holo = holo(N/2-M/2+1:N/2+M/2,N/2-M/2+1:N/2+M/2);

if Imax<0
	Imax = 1.5 * max(holo(:));
end

%----------------------------------------------------------------------
% 8bit画像でセーブすると性能は悪くなる，12bit画像でセーブしたほうが良い
%----------------------------------------------------------------------
filename = sprintf('%sholo1.tif', SVFOLDER);
imwrite( uint8(255*holo/Imax), filename, 'tif');		% 第１フレームの最大値Imaxで正規化して8bitデータに変換している
% imwrite( uint16(4095*holo/Imax), filename, 'tif');	% 第１フレームの最大値Imaxで正規化して12bitデータに変換している
%----------------------
%%% 再生距離の設定
%----------------------
% 球面波のとき、点光源の位置が
%   1. 物体位置と同じときは、レンズレスフーリエ変換型　⇒　FFTで再生可能
%   2. 物体位置と異なるときは、普通のフレネル型　⇒　焦点距離を調整すれば、FTまたはCONVで再生可能                      
if strcmp(Rwave.type,'sphere') && (-Rwave.Z) ~= Opwave.Z
	
	z = Opwave.Z * (-Rwave.Z)/((-Rwave.Z) - Opwave.Z);
	disp(['■再生距離変更@OxR = ' num2str(z)])
	
else
	
	z = Opwave.Z;
	
end

