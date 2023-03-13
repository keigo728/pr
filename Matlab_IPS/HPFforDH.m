function Result_Data = HPFforDH( data, z, initSet, CTLflag)
global DEBUG

%=========================================================================
%%% method=='HPF_OneMinusGaussianLPF'		'1 - Gaussian LPF【引き算】'
%%%         'HPF_FastOneMinusGaussianLPF'	'1 - Gaussian LPF【一括カーネル引き算】'
%%% 		'HPF_OneDivGaussianLPF'			'1 / Gaussian LPF 【割り算】'
%%%
%%% 		'HPF_OneMinusMean'			'1 - 平均値 【引き算】'
%%% 		'HPF_OneDivMean'			'1 / 平均値 【割り算】'
%%% 		'HPF_OneMinusAverage33'		'1 - 3x3平滑化フィルタ【引き算】'
%%% 		'HPF_OneDivAverage33'		'1 / 3x3平滑化フィルタ【割り算】'
%%%
%%%			'HPF_OneMinusORGLPF'	1*@$	'1 - H*@_B$psk.dat【オリジナルLPF引き算】
%%% 		'HPF_OneMinusQBS4LPF'			'1 - B4-spline LPF 【引き算】'
%%%			'HPF_FastOneMinusQBS4LPF'		'1 - B4-spline LPF 【一括カーネル引き算】'
%%% 		'HPF_OneDivQBS4LPF'				'1 / B4-spline LPF 【割り算】'
%%% 		'HPF_OneMinusQBS4LPF'			'1 - B6-spline LPF 【引き算】'
%%%			'HPF_FastOneMinusQBS4LPF'		'1 - B6-spline LPF 【一括カーネル引き算】'
%%% 		'HPF_OneDivQBS4LPF'				'1 / B6-spline LPF 【割り算】'
%=========================================================================
%%%		initSet.Method : 方法
%%%		initSet.XKSize : X方向のサイズ
%%% 	initSet.YKSize : Y方向のサイズ
%%%		initSet.Sigma  : σ
%%%		initSet.CheckFig  : 確認用の図のオン・オフ

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch initSet.Method
case 'HPF_OneMinusGaussianLPF'

	sss='★ 1 - Gaussian LPF【引き算】';disp(sss);
	
	% ガウシアンフィルタで低周波成分のみを取り出す
	h = fspecial('gaussian',[initSet.XKSize initSet.YKSize],initSet.Sigma);
	averaging_data = imfilter(data,h, 'replicate' );
	
	% 【引き算】これで低周波成分成分が除かれる
	Result_Data = data - averaging_data;
	
	%%% 確認
	if nargin > 3,  check_figure(data,averaging_data,Result_Data,z,'sub',sss);  end

			
case 'HPF_FastOneMinusGaussianLPF'

	sss='◆ 1 − Gaussian LPF【一括カーネル引き算】';disp(sss);
	
	% 元画像から低周波成分の引き算を行うフィルタ係数
	u = zeros(initSet.XKSize,initSet.YKSize);
	u(round(initSet.XKSize/2), round(initSet.YKSize/2))=1;
	h = u - fspecial('gaussian',[initSet.XKSize initSet.YKSize],initSet.Sigma);
	
	% 【一括カーネル引き算】これで低周波成分成分が除かれる
	Result_Data = imfilter(data,h, 'replicate' );
	
	%%% 確認
	if nargin > 3,  check_figure(data,zeros(size(data)),Result_Data,z,'sub',sss);  end

			
case 'HPF_OneDivGaussianLPF'

	sss='★ 1 / Gaussian LPF【割り算】';disp(sss);
	
	% ガウシアンフィルタで低周波成分のみを取り出す
	h = fspecial('gaussian',[initSet.XKSize initSet.YKSize],initSet.Sigma);	
	averaging_data = imfilter(data,h, 'replicate' );
	
	% ゼロ割防止のための処置
	ctlparam=zeros(size(averaging_data));
	ctlparam( averaging_data <  50  ) = 1;
	disp(['●Sum: ', num2str(sum(ctlparam(:))),'  Mean: ', num2str(mean(ctlparam(:)))]);
	averaging_data = averaging_data.*(1-ctlparam) + 1e4*ctlparam;	%.*rand(size(ctlparam))*1e-16;
	
	% 【割り算、そして、1を引く】これで低周波成分成分が除かれる
	Result_Data = data./averaging_data;
	disp([ '◆ Average in DHremove_ZerothOrder() : ',num2str(mean(Result_Data(:))) ]);
 	Result_Data = Result_Data - 1;		% １を引く			%Result_Data=Result_Data-mean(Result_Data(:));%平均値を引く
	Result_Data = Result_Data.*(1-ctlparam) - 0*ctlparam;
	
	%%% 確認
	if nargin > 3,  check_figure(data,1./averaging_data,Result_Data,z,'div',sss);  end


%=====================================================================================

case 'HPF_OneMinusMean'
		
	sss='★ 1 - 平均値 【引き算】';disp(sss);	h=0;
	
	% 平均値を引く
	Result_Data = data - mean(data(:));
			%Result_Data = data - mean(data(:))*0.9;	%%% 平均値の1割落ちを引いてみる
			
	s=sprintf('MEAN: %f  MAX: %f   MIN: %f',mean(data(:)),max(data(:)),min(data(:)));disp(s);
		
	%%% 確認
	if nargin > 3,  check_figure(data,mean(data(:))*ones(size(data)),Result_Data,z,'sub',sss);  end

			
case 'HPF_OneDivMean'
	
	sss='★ 1 / 平均値 【割り算】';disp(sss);	h=0;
	
	% 平均値で割る、そして、1を引く
	Result_Data = data./mean(data(:)) - 1;

	s=sprintf('MEAN: %f  MAX: %f   MIN: %f',mean(data(:)),max(data(:)),min(data(:)));disp(s);
	
	%%% 確認
	if nargin > 3,  check_figure(data,ones(size(data))./mean(data(:)),Result_Data,z,'div',sss);  end


%=====================================================================================

case 'HPF_OneMinusAverage33'

	sss='★ 1 - 3x3平滑化フィルタ【引き算】';disp(sss);
	numb = 3;
	h = ones(numb,numb)/numb.^2;
	averaging_data =  imfilter(data,h, 'replicate' );
	
	% 【引き算】これで低周波成分成分が除かれる
	Result_Data = data - averaging_data;
	
	%%% 確認
	if nargin > 3,  check_figure(data,averaging_data,Result_Data,z,'sub',sss);  end

		
case 'HPF_OneDivAverage33'
	
	sss='★ 1 / 3x3平滑化フィルタ【割り算】';disp(sss);
	h = ones(3,3)/9;
	averaging_data =  imfilter(data,h, 'replicate' );
	
	% 【割り算】これで低周波成分成分が除かれる
	Result_Data = data./averaging_data - 1;
	
	%%% 確認
	if nargin > 3,  check_figure(data,1./averaging_data,Result_Data,z,'div',sss);  end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if strcmp(initSet.Method,'HPF_OneMinusORGLPF')
% 	
% 	s0 = fix((method-1000)/10);
% 	s1 = method - 1000 - s0*10;
% 	
% 	fname = sprintf('H%02d_B%1dspk.dat',s0,s1);
% 	sss=['★ 1 - ',fname,'【引き算】'];disp(sss);
% 	
% 	h = load(fname);
% 	averaging_data =  imfilter(data,h, 'replicate' );
% 	Result_Data = data - averaging_data;	% 【引き算】これで低周波成分成分が除かれる
% 	        
% 			check_figure(data,averaging_data,Result_Data,z,'sub',sss);		%%% 確認


%=====================================================================================

case 'HPF_OneMinusQBS4LPF'
		
	sss='★ 1 - B4-spline LPF 【引き算】';disp(sss);
	h = load('B4splineKernel4.dat');
	averaging_data = imfilter(data,h, 'replicate' );
	
	% 【引き算】これで低周波成分成分が除かれる
	Result_Data = data - averaging_data;
	
	%%% 確認
	if nargin > 3,  check_figure(data,averaging_data,Result_Data,z,'sub',sss);  end

			
case 'HPF_FastOneMinusQBS4LPF'
		
	sss='★ 1 - B4-spline LPF 【一括カーネル引き算】';disp(sss);
	h = load('B4splineKernel4.dat');
	[ux,uy]=size(h);
	u = zeros(ux,uy);
	u(round(ux/2),round(uy/2))=1;
	
	% 元画像から低周波成分の引き算を行うフィルタ係数
	h = u - h;
% 	sumb=sum(h(:));sumabsb=sum(abs(h(:)));sumabsb2=sum(abs(h(:)).^2);

	% 【引き算】これで低周波成分成分が除かれる
	Result_Data =  imfilter(data,h, 'replicate' );
	
	%%% 確認
	if nargin > 3,  check_figure(data,zeros(size(data)),Result_Data,z,'sub',sss);  end

			
case 'HPF_OneDivQBS4LPF'
	
	sss='★ 1 / B4-spline LPF 【割り算】';disp(sss);
	h = load('B4splineKernel4.dat');
	averaging_data =  imfilter(data,h, 'replicate' );
	
	% 【割り算、そして、1を引く】これで低周波成分成分が除かれる
	Result_Data = data./averaging_data - 1;

	%%% 確認
	if nargin > 3,  check_figure(data,1./averaging_data,Result_Data,z,'div',sss);  end


%=====================================================================================

case 'HPF_OneMinusQBS6LPF'
		
	sss='★ 1 - B6-spline LPF 【引き算】';disp(sss);
	h = load('B6splineKernel4.dat');
	averaging_data =  imfilter(data,h, 'replicate' );
	
	% 【引き算】これで低周波成分成分が除かれる
	Result_Data = data - averaging_data;
	 
	%%% 確認
	if nargin > 3,  check_figure(data,averaging_data,Result_Data,z,'sub',sss);  end

		
case 'HPF_FastOneMinusQBS6LPF'
		
	sss='★ 1 - B6-spline LPF 【一括カーネル引き算】';disp(sss);
	h = load('B6splineKernel4.dat');
	[ux,uy]=size(h);
	u = zeros(ux,uy);
	u(round(ux/2),round(uy/2))=1;
	
	% 元画像から低周波成分の引き算を行うフィルタ係数
	h = u - h;
% 	sumb=sum(h(:));sumabsb=sum(abs(h(:)));sumabsb2=sum(abs(h(:)).^2);

	% 【引き算】これで低周波成分成分が除かれる
	Result_Data =  imfilter(data,h, 'replicate' );
	
	%%% 確認
	if nargin > 3,  check_figure(data,zeros(size(data)),Result_Data,z,'sub',sss);  end

			
case 'HPF_OneDivQBS6LPF'
	
	sss='★ 1 / B6-spline LPF 【割り算】';disp(sss);
	h = load('B6splineKernel4.dat');
	averaging_data =  imfilter(data,h, 'replicate' );
	
	% 【割り算、そして、1を引く】これで低周波成分成分が除かれる
	Result_Data = data./averaging_data - 1;
	
	%%% 確認
	if nargin > 3,  check_figure(data,1./averaging_data,Result_Data,z,'div',sss);  end


%=====================================================================================

case 99
	
	heikin=mean(data(:))
	[px,fval] = fminsearch(@data_minus_baseline,heikin,[],data)
	Result_Data = data - px;

otherwise
	
	sss='◆そのままです。再チェックしてください！';disp(sss);
	Result_Data = data;
	
	%%% 確認
	if nargin > 3,  check_figure(Result_Data,z,CTLflag,fignum,sss);  end

end

%-----------------------------------------------------------------------------

% フィルタ特性確認用のグラフ表示
if initSet.CheckFig > 0
	[hx,hy]=size(h);
	if hx==1 & hx==hy
			disp(' ');
	elseif hx>1 & hy>1
			figure;	surf(h);shading interp;axis tight;view(-25,50);		% カーネルを図示する
					title([sss,num2str(initSet.XKSize),'-', num2str(initSet.YKSize), 'カーネル']);
			figure;	freqz2(h,128);view(-25,50);caxis([-0.13,1]);
					title([sss ,num2str(initSet.XKSize),'-', num2str(initSet.YKSize), '周波数特性']);
			drawnow;
	else
			figure;	plot(h,'mo-');axis tight;ylim([0,max(h(:))]);		% カーネルを図示する
					title([sss ,num2str(initSet.XKSize),'-', num2str(initSet.YKSize),'カーネル']);
			figure;	freqz(h,128);
					title([sss ,num2str(initSet.XKSize),'-', num2str(initSet.YKSize), '周波数特性']);
					drawnow;
	end			
end


%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

function check_figure( XData, AveData, ResData, z, CTLflag, sss)

hh=figure;  set_figure(hh,200,30,1050,900);
[tx,ty]=size(XData);
		
% 【オリジナル】
maxp=max( XData(:) );
minp=min( XData(:) );												% avep=mean( XData(:) );stdp=std( XData(:) );
subplot(3,3,1);	subimage(uint8(XData),gray(255));			% imshow(XData,[],'notruesize');colorbar;
				title(['Original  Max:',num2str(maxp),' Min:',num2str(minp)]);axis on;

% 【平滑化】
maxp=max( AveData(:) );
minp=min( AveData(:) );												% avep=mean( AveData(:) );stdp=std( AveData(:) );
subplot(3,3,2);
if CTLflag=='sub'
	subimage(uint8(AveData),gray(255));						% imshow(AveData,[],'notruesize');colorbar;
else
	subimage(uint8(255*32*AveData),gray(255));				
end
	title(['平滑化  Max:',num2str(maxp),' Min:',num2str(minp)]);axis on;

% 【フィルタリング後】
maxp=max( ResData(:) );
minp=min( ResData(:) );												% avep=mean( ResData(:) );stdp=std( ResData(:) );
subplot(3,3,3);
if CTLflag=='sub'
	subimage(uint8(ResData+128),gray(255));					% imshow(ResData,[],'notruesize');colorbar;
else
	subimage(uint8(255*(ResData+1)/2),gray(255));				
end
	title(['Filter後  Max:',num2str(maxp),' Min:',num2str(minp)]);axis on;
	drawnow;

% 【断面図】
set_figure(hh+1,300,100,950,550);
if CTLflag=='sub'
	CTLcoeff=1;
else
	CTLcoeff=2000;
end;
subplot(2,2,1);	plot(1:tx,XData(:,ty/2),'b-',1:tx,CTLcoeff*AveData(:,ty/2),'r-');
				legend('Org X','Ave X');axis tight;title(sss);
subplot(2,2,3);	plot(1:tx,ResData(:,ty/2),'g-');
				legend('Filt X');axis tight;
subplot(2,2,2);	plot(1:tx,XData(tx/2,:),'b-',1:tx,CTLcoeff*AveData(tx/2,:),'r-');
				legend('Org Y','Ave Y');axis tight;title(sss);
subplot(2,2,4);	plot(1:tx,ResData(tx/2,:),'g-');
				legend('Filt Y');axis tight;
				drawnow;

%%% フーリエ変換【オリジナル】%%%
XData = shiftfft2( XData );
	
intensity=abs(XData).^2;
maxSideI=max2d( intensity(1:tx/2-50,:) )
TOTALmax=max( intensity(:) )		% TOTALmin=min( intensity(:) )	% TOTALave=mean( intensity(:) )	% TOTALstd=std( intensity(:) )
maxforGraph = 1.2*maxSideI;
	
figure(hh);
upperlevel=maxSideI/500;
subplot(3,3,4);	imshow( intensity ,[],'notruesize');
				title(['ＦＴ  SideMax:',num2str(maxSideI)]);
				caxis([0 upperlevel]);colorbar;colormap(jet);axis on;
subplot(3,3,7);	plot( intensity(:,ty/2+1:ty/2+6));
				title(['ＦＴ  Max:',num2str(TOTALmax)]);
				xlim([1,tx]);ylim([0,maxforGraph]);

%%% フーリエ変換【平滑化】%%%
AveData = shiftfft2( AveData );

intensity=abs(AveData).^2;
maxSideI=max2d( intensity(1:tx/2-50,:) )
TOTALmax=max( intensity(:) )		% TOTALmin=min( intensity(:) )	% TOTALave=mean( intensity(:) )	% TOTALstd=std( intensity(:) )

if CTLflag=='div'
	maxforGraph = TOTALmax/50;
	TOTALmax=TOTALmax/10000;
end

subplot(3,3,5);	imshow( intensity ,[],'notruesize');
				title(['ＦＴ  SideMax:',num2str(maxSideI)]);
				caxis([0 TOTALmax]);colorbar;colormap(jet);axis on;
subplot(3,3,8);	plot( intensity(:,ty/2+1:ty/2+6));
				title(['ＦＴ  Max:',num2str(TOTALmax)]);
				xlim([1,tx]);ylim([0,maxforGraph]);

%%% フーリエ変換【フィルタリング後】%%%
ResData = shiftfft2( ResData );

intensity=abs(ResData).^2;
maxSideI=max2d( intensity(1:tx/2-50,:) )
TOTALmax=max( intensity(:) )		% TOTALmin=min( intensity(:) )	% TOTALave=mean( intensity(:) )	% TOTALstd=std( intensity(:) )

if CTLflag=='div'
	upperlevel=maxSideI/100;
	maxforGraph = TOTALmax;
end

subplot(3,3,6);	imshow( intensity ,[],'notruesize');
				title(['ＦＴ  SideMax:',num2str(maxSideI)]);
				caxis([0 upperlevel]);colorbar;colormap(jet);axis on;
subplot(3,3,9);	plot( intensity(:,ty/2+1:ty/2+6));
				title(['ＦＴ  Max:',num2str(TOTALmax)]);
				xlim([1,tx]);ylim([0,maxforGraph]);
				drawnow;

