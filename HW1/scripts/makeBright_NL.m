% Names: Devin Burke, Ty Tomlin
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [ outImg ]= makeBright_NL(current_img, brightness)
    outImg=current_img + brightness; % element wise addition of brightness to each pixel
    imwrite(outImg,'hw1_2_dark.png'); 
end