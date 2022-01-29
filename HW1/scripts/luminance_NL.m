% Names: Devin Burke, Ty Tomlin
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = luminance_NL( current_img )
    % convert image to grayscale via intensity equation
    % each color's pixel is multiplied element wise by the corresponding
    % weight and mapped to the new image with the same coordinate. 
    outImg = current_img(:,:,1)*0.299 + current_img(:,:,2)*0.587 + current_img(:,:,3)*0.114;
    outImg = uint8(outImg);
    imwrite(outImg,'hw1_6.png');
end