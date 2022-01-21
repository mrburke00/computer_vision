% Names: Devin Burke, Ty Tomlin
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = binaryMask(current_img)
    
   %maxV = max(current_img,[],'all');
   %minV = min(current_img, [], 'all');
   meanV = mean(current_img, 'all'); % calculate mean of the grayscale image to use as threshold
   % if a pixel is less than the threshold then asign it to be 1 otherwise 0  
   outImg = (current_img < (meanV));
   imwrite(outImg,'hw1_8.png');
end