%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%物体に点光源があるか検索
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [TF, flag] = objectSearch( datafile, initSet, dx, dy)

% データサイズは２のべき乗にする
N = initSet.CCDX;

im = double(imread([datafile.FOLDER datafile.name]))/255;
M = length(im);	% 画像サイズ

% ◆◆◆ 今回は９６×９６画素なので周囲に０を埋める
img=zeros(N,N);
img(N/2-M/2+1:N/2+M/2,N/2-M/2+1:N/2+M/2) = im;

if img(dx, dy) ~= 0
    TF = 1;
else
    TF = -1;
end