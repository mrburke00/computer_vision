% This script creates a menu driven application

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Names: Devin Burke, Ty Tomlin
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming
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
    'Frosty Filter', 'Scale Nearest', 'Scale Bilinear', 'Swirl Filter', 'Famous Me');  % as you develop functions, add buttons for them here
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
            while user_input ~= 1 % keep iterating until user input meets criteria
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
           current_img = imread(filename);
           user_input=0; 
           while user_input ~= 1
            brightness = input('Enter brightness value [-255,255]');
            if (brightness>=-255) && (brightness <= 255)
                user_input=1;
            end
           end
           new_img = makeBright_L(current_img, brightness);

           subplot(1, 2, 1);
           imagesc(current_img);
           title("Original");
           axis image
           subplot(1, 2, 2);
           imagesc(new_img);
           title("Result");
           axis image

       case 6
           %Brighten_NL

           % Ask user for brightness
           current_img = imread(filename);
           user_input=0; 
           while user_input ~= 1
            brightness = input('Enter brightness value [-255,255]');
            if (brightness>=-255) && (brightness <= 255)
                user_input=1;
            end
           end
           new_img = makeBright_NL(current_img, brightness);

           subplot(1, 2, 1);
           imagesc(current_img);
           title("Original");
           axis image
           subplot(1, 2, 2);
           imagesc(new_img);
           title("Result");
           axis image

       case 7
           %Invert_L

           current_img = imread(filename);
           new_img = invert_L(current_img);
           
           subplot(1, 2, 1);
           imagesc(current_img);
           title("Original");
           axis image
           subplot(1, 2, 2);
           imagesc(new_img);
           title("Result");
           axis image

       case 8
           %Invert_NL

           current_img = imread(filename);
           new_img = invert_NL(current_img);
           
           subplot(1, 2, 1);
           imagesc(current_img);
           title("Original");
           axis image
           subplot(1, 2, 2);
           imagesc(new_img);
           title("Result");
           axis image

       case 9
           %addRandomNoise_NL

           current_img = imread(filename);
           new_img = addRandomNoise_NL(current_img);
           
           subplot(1, 2, 1);
           imagesc(current_img);
           title("Original");
           axis image
           subplot(1, 2, 2);
           imagesc(new_img);
           title("Result");
           axis image

       case 10
           %Luminance_NL

           current_img = imread(filename);
           new_img = luminance_NL(current_img);
           
           subplot(1, 2, 1);
           imagesc(current_img);
           title("Original");
           axis image
           subplot(1, 2, 2);
           imagesc(new_img);
           colormap(gray)
           title("Result");
           axis image
       
       case 11
           %Red Filter
           % Ask user for brightness
           current_img = imread(filename);
           user_input=0; 
           while user_input ~= 1
            red_val = input('Enter red filter value [0,1]');
            if (red_val>=0) && (red_val <= 1)
                user_input=1;
            end
           end
           new_img = redFilter(current_img, red_val);

           subplot(1, 2, 1);
           imagesc(current_img);
           title("Original");
           axis image
           subplot(1, 2, 2);
           imagesc(new_img);
           colormap(gray)
           title("Result");
           axis image

       case 12
           %Binary Mask
            
           current_img = imread(filename);
           new_img = binaryMask(current_img);
           
           subplot(1, 2, 1);
           imagesc(current_img);
           title("Original");
           axis image
           subplot(1, 2, 2);
           imagesc(new_img);
           colormap(gray)
           title("Result");
           axis image

        
       case 13
           %Frosty Filter

           current_img = imread(filename);
           user_input=0; 
           while user_input ~= 1
            n = input('Enter n > 0');
            m = input('Enter m > 0');
            if (n>0) && (m>0)
                user_input=1;
            end
           end
           new_img = frosty(current_img, n, m);

           subplot(1, 2, 1);
           imagesc(current_img);
           title("Original");
           axis image
           subplot(1, 2, 2);
           imagesc(new_img);
           title("Result");
           axis image

       case 14
           %Scale Nearest
           current_img = imread(filename);
           user_input=0; 
           while user_input ~= 1
            factor = input('Enter factor > 0');
            if (factor>0)
                user_input=1;
            end
           end
           new_img = scaleNearest(current_img, factor);

           subplot(1, 2, 1);
           imagesc(current_img);
           title("Original");
           axis image
           subplot(1, 2, 2);
           imagesc(new_img);
           title("Result");
           axis image
       
       case 15
           %Scale Bilinear

           current_img = imread(filename);
           user_input=0; 
           while user_input ~= 1
            factor = input('Enter factor > 0');
            if (factor>0)
                user_input=1;
            end
           end
           new_img = scaleBilinear(current_img, factor);

           subplot(1, 2, 1);
           imagesc(current_img);
           title("Original");
           axis image
           subplot(1, 2, 2);
           imagesc(new_img);
           title("Result");
           axis image

       case 16
           %Swirl
           factor = 0;
           ox = 0;
           oy = 0;
           current_img = imread(filename);
           factor = input('Enter factor : ');
           ox = input('Enter ox : ');
           oy = input('Enter oy : ');
           new_img = swirlFilter(current_img, factor, ox, oy);

           subplot(1, 2, 1);
           imagesc(current_img);
           title("Original");
           axis image
           subplot(1, 2, 2);
           imagesc(new_img);
           title("Result");
           axis image



       case 17
           %Famous Me
           background_img = imread("sun.jpg");
           foreground_img = imread("me.png");
           new_img = famousMe(background_img, foreground_img);
           subplot(1, 3, 1);
           imagesc(background_img);
           title("Background");
           axis image
           subplot(1, 3, 2);
           imagesc(foreground_img);
           title("Foreground");
           axis image
           subplot(1, 3, 3);
           imagesc(new_img);
           title("Result");
           axis image

       %....
   end
   % Display menu again and get user's choice
choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter', 'Brighten_L', 'Brighten_NL', 'Invert_L', ...
    'Invert_NL', 'Add Random Noise', 'Luminance_NL', 'Red Filter', 'Binary Mask', ...
    'Frosty Filter', 'Scale Nearest', 'Scale Bilinear', 'Swirl Filter', 'Famous Me');  % as you develop functions, add buttons for them here
end



  


