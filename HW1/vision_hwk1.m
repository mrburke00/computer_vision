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
    'Invert_NL', 'Add Random Noise', 'Luminance_NL', 'Red Filter', 'Binary Mask');  % as you develop functions, add buttons for them here
 
% Choice 1 is to exit the program
while choice ~= 1
   switch choice
       case 0
           disp('Error - please choose one of the options.')
           % Display a menu and get a choice
    choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter', 'Brighten_L', 'Brighten_NL', 'Invert_L', ...
    'Invert_NL', 'Add Random Noise', 'Luminance_NL', 'Red Filter', 'Binary Mask');  % as you develop functions, add buttons for them here
        case 2
           % Load an image
           image_choice = menu('Choose an image', 'sully', 'mandrill1');
           switch image_choice
               case 1
                   filename = 'sully.bmp';
               case 2
                   filename = 'mandrill1.jpg';
               % fill in cases for all the images you plan to use
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
           % Mean Filter
           
           % 1. Ask the user for size of kernel
           
           % 2. Call the appropriate function
           current_img = imread("sully.bmp");
           k_size = 3;
           newImage = meanFilter(current_img, k_size); % create your own function for the mean filter
           
           % 3. Display the old and the new image using subplot
           % ....
           %subplot(...)
           %imagesc(current_img)
           
           % subplot(...)
           %imagesc(newImage)
           
           
           % 4. Save the newImage to a file
           
              
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
       %....
   end
   % Display menu again and get user's choice
choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter', 'Brighten_L', 'Brighten_NL', 'Invert_L', ...
    'Invert_NL', 'Add Random Noise', 'Luminance_NL', 'Red Filter', 'Binary Mask');  % as you develop functions, add buttons for them here
end



  


