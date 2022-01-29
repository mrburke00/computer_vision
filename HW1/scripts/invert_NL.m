% Names: Devin Burke, Ty Tomlin
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = invert_NL( current_img)
    outImg = 255 - current_img; % subtract element wise each pixel by the max value to invert
    imwrite(outImg,'hw1_4.png'); 
end