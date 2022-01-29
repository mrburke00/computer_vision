% Names: Devin Burke, Ty Tomlin
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = frosty (current_img, n, m)
    [x,y,z] = size(current_img);
    outImg = current_img; % retain same coordinate mapping
    for i = 1:x % row
        for j = 1:y % coloumn 
            % get how range of neighbors in x and y direction for current
            % indexes (divide by 2 because n,m gives window) 
            left = round(i-m/2);
            right = round(i+m/2);
            bottom = round(j+n/2);
            top = round(j-n/2);
            %similar to mean filter we need to reset indexes to stay in
            %bounds of image
            if left < 1 % outside image to left
                left = 1;
            end
            if right > x % outside image to right
                right = x;
            end
            if bottom > y % outside image at bottom
                bottom = y;
            end
            if top < 1 % outside image at top
                top = 1;
            end

            % get random indices within the bounds of the calculated
            % indexes
            row = randi([left, right], 1);
            col = randi([top, bottom], 1);
            % assign random pixel from original image to current
            % position in final image
            % retain all color panes for that pixel 
            outImg(i,j,:) = current_img(row,col,:);
        end
    end
    imwrite(outImg,'hw1_10.png');
end