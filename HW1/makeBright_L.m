% Names: Devin Burke, Ty Tomlin
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [ outImg ]= makeBright_L(current_img, brightness)
    for i = 1:length(current_img) % iterate through rows 
        for j = 1:size(current_img,2) % iterate through columns
            for k = 1:3 % iterate through colors 
                tmp = current_img(i,j,k); % extract current pixel value
                tmp = tmp + brightness; % add input brightness
                outImg(i,j,k) = tmp; % assign pixel to new value 
            end
        end
    end
    imwrite(outImg,'hw1_1_dark.png'); 
end