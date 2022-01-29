% Names: Devin Burke, Ty Tomlin
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = invert_L( current_img)
    % iterate thru rows, columns, colors of original image 
    for i = 1:length(current_img)
        for j = 1:size(current_img,2)
            for k = 1:3
                tmp = current_img(i,j,k); % extract current pixel value
                tmp = 255 - tmp; % subtract max value to invert
                outImg(i,j,k) = tmp; % assign inverted value to new image
            end
        end
    end
    imwrite(outImg,'hw1_3.png'); 
end