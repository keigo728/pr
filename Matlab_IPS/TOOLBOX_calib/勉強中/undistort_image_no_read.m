%%% INPUT THE IMAGE FILE NAME:

if ~exist('fc')|~exist('cc')|~exist('kc')|~exist('alpha_c'),
   fprintf(1,'No intrinsic camera parameters available.\n');
   return;
end;

KK = [fc(1) alpha_c*fc(1) cc(1);0 fc(2) cc(2) ; 0 0 1];

disp('Program that undistorts images');
disp('The intrinsic camera parameters are assumed to be known (previously computed)');

fprintf(1,'\n');

quest = input('Do you want to undistort all the calibration images ([],0) or a new image (1)? ');

if isempty(quest),
   quest = 0;
end;

if ~quest,

	%if ~exist(['I_' num2str(ind_active(1))]),
   	%ima_read_calib;
    %end;
    
    if n_ima == 0,
        fprintf(1,'No image data available\n');
        return;
    end;
    
   check_active_images;   
   
   format_image2 = format_image;
   if format_image2(1) == 'j',
      format_image2 = 'bmp';
   end;
   
   for kk = 1:n_ima,
    
       if ~type_numbering,   
           number_ext =  num2str(image_numbers(kk));
       else
           number_ext = sprintf(['%.' num2str(N_slots) 'd'],image_numbers(kk));
       end;
       ima_name = [calib_name  number_ext '.' format_image];
       
       if ~exist(ima_name),   
           fprintf(1,'Image %s not found!!!\n',ima_name);  
       else
           fprintf(1,'Loading image %s...\n',ima_name);
           
           if format_image(1) == 'p',
               if format_image(2) == 'p',
                   I = double(loadppm(ima_name));
               else
				   I = imreadPGM16(ima_name);%           I = double(loadpgm(ima_name));	   
               end;
           else
               if format_image(1) == 'r',
                   I = readras(ima_name);
               else
                   I = double(imread(ima_name));
               end;
           end;
           
           
           if size(I,3)>1,
               I = 0.299 * I(:,:,1) + 0.5870 * I(:,:,2) + 0.114 * I(:,:,3);
           end;

           [I2] = rect(I,eye(3),fc,cc,kc,KK);
           
           if ~type_numbering,   
               number_ext =  num2str(image_numbers(kk));
           else
               number_ext = sprintf(['%.' num2str(N_slots) 'd'],image_numbers(kk));
           end;
           ima_name2 = [calib_name '_rect' number_ext '.' format_image2];
           fprintf(1,['Saving undistorted image under ' ima_name2 '...\n']); 
           
           if format_image2(1) == 'p',
               if format_image2(2) == 'p',
                   saveppm(ima_name2,uint8(round(I2)));
               else 			   
				   imwritePGM16(uint16(round(I2)),ima_name2);%      savepgm(ima_name2,uint8(round(I2)));				   
               end;
           else
               if format_image2(1) == 'r',
                   writeras(ima_name2,round(I2),gray(256));
               else
                   imwrite(uint8(round(I2)),gray(256),ima_name2,format_image2);
               end;
           end;
		   
         
       end;      
   end;  
   fprintf(1,'done\n');   
end;
