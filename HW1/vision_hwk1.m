% This script creates a menu driven application

%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Devin Burke
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;close all;clc;

% Display a menu and get a choice
choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter', 'Brighten_L', 'Brighten_NL', 'Invert_L', ...
    'Invert_NL', 'Add Random Noise', 'Luminance_NL', 'Red Filter', 'Binary Mask', ...
    'Frosty Filter', 'Scale Nearest', 'Scale Bilinear', 'Swirl Filter', 'Famous Me');  % as you develop functions, add buttons for them here
 
% Choice 1 is to exit the program
while choice ~= 1
   switch choice
       case 0
           disp('Error - please choose one of the options.')
           % Display a menu and get a choice
    choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter', 'Brighten_L', 'Brighten_NL', 'Invert_L', ...
    'Invert_NL', 'Add Random Noise', 'Luminance_NL', 'Red Filter', 'Binary Mask',...
    'Frosty Filter', 'Scale Nearest', 'Scale Bilinear');  % as you develop functions, add buttons for them here
        case 2
           % Load an image
           image_choice = menu('Choose an image', 'sully', 'mandrill1', 'lena1_small', ...
               'redBaloon', 'wrench1', 'shrek', 'yoda_small');
           switch image_choice
               case 1
                   filename = 'sully.bmp';
               case 2
                   filename = 'mandrill1.jpg';
               case 3
                   filename = 'lena1_small.jpg';
               case 4
                   filename = 'redBaloon.jpg';
               case 5
                   filename = 'wrench1.jpg';
               case 6
                   filename = 'shrek.bmp';
               case 7
                   filename = 'yoda_small.bmp';                   
           end
           current_img = imread(filename);
       case 3
           % Display image
           figure
           imagesc(current_img);
           if size(current_img,3) == 1
               colormap gray
           end
           
       case 4
           % Mean Filter #9
           
           % 1. Ask the user for size of kernel
           user_input = 0;
            while user_input ~= 1
                k_size = input('Enter kernel size (greater than 1)');
                if (k_size>=1)
                    user_input=1;
                end
            end
           % 2. Call the appropriate function
           current_img = imread(filename);
           new_img = meanFilter(current_img, k_size); 
           
           % 3. Display the old and the new image using subplot
            subplot(1, 2, 1);
            imagesc(current_img);
            title("Original");
            axis image
            subplot(1, 2, 2);
            imagesc(new_img);
            title("Result");
            axis image
            
       case 5
           %Brighten_L
           % Ask user for brightness
           current_img = imread("sully.bmp");
           user_input=0; 
           while user_input ~= 1
            brightness = input('Enter brightness value [-255,255]');
            if (user_input>=-255) && (user_input <= 255)
                user_input=1;
            end
           end
           makeBright_L(current_img, brightness);

       case 6
           %Brighten_NL
           % Ask user for brightness
           current_img = imread("sully.bmp");
           %brightness=-75;
           user_input=0; 
           while user_input ~= 1
            brightness = input('Enter brightness value [-255,255]');
            if (user_input>=-255) && (user_input <= 255)
                user_input=1;
            end
           end
           makeBright_NL(current_img, brightness);

       case 7
           %Invert_L
           current_img = imread("sully.bmp");
           invert_L(current_img);

       case 8
           %Invert_NL
           current_img = imread("sully.bmp");
           invert_NL(current_img);

       case 9
           %Invert_NL
           current_img = imread("sully.bmp");
           addRandomNoise_NL(current_img);

       case 10
           %Luminance_NL
           current_img = imread("sully.bmp");
           luminance_NL(current_img);
       
       case 11
           %Red Filter
           current_img = imread("redBaloon.jpg");
           redVal = 0.5;
           redFilter(current_img, redVal);

       case 12
           %Binary Mask
           current_img = imread("wrench1.jpg");
           binaryMask(current_img);
        
       case 13
           %Frosty Filter
           current_img = imread("sully.bmp");
           n = 3;
           m = 3;
           frosty(current_img, n, m);

       case 14
           %Scale Nearest
           current_img = imread("sully.bmp");
           factor = 0.5;
           scaleNearest(current_img, factor);
       
       case 15
           %Scale Bilinear
           current_img = imread("sully.bmp");
           factor = 0.5;
           scaleBilinear(current_img, factor);
       %....
   end
   % Display menu again and get user's choice
choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter', 'Brighten_L', 'Brighten_NL', 'Invert_L', ...
    'Invert_NL', 'Add Random Noise', 'Luminance_NL', 'Red Filter', 'Binary Mask', ...
    'Frosty Filter', 'Scale Nearest', 'Scale Bilinear');  % as you develop functions, add buttons for them here
end



  


