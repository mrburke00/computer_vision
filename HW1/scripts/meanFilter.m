% Names: Devin Burke, Ty Tomlin
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

% conditional implementation attempt
function [outImg] = meanFilter(current_img, kernel_size)
    pad = floor(kernel_size/2); % amount of padding from kernel size 
    [x,y,z] = size(current_img);
    outImg = current_img; % retain same coordinate mapping
    for i = 1:x % row
        for j = 1:y % coloumn 
            %edge neighbor cases (i.e. (1,1) left, top neighbors dont exist)
            left = i - pad; % neighbor to left
            right = i + pad; % neighbor to right
            top = j - pad; % neighbor above
            bottom = j + pad; % neigbhor below

            if left < 1 % no neighbor to left
                left = 1;
            end
            if right > x % no neighbor to right
                right = x; % reset right to max number of rows
            end
            if top < 1 % no neighbor above
                top = 1; 
            end
            if bottom > y % no neighbor below
                bottom = y; % reset bottom to max number of cols
            end

            % extract neighbors within kernel space given calculated
            % indexes for each color 
            kernel_space = current_img(left:right, top:bottom, :);
            % separate by color, take mean and assign to output image 
            % nested mean because first mean gets average for each row
            % second mean gets average of all averaged rows
            outImg(i,j,1) = mean(mean(kernel_space(:,:,1)));
            outImg(i,j,2) = mean(mean(kernel_space(:,:,2)));
            outImg(i,j,3) = mean(mean(kernel_space(:,:,3)));
        end
    end
    imwrite(outImg,'hw1_9.png');
end

% below is the padded implementation attempt - couldn't get operational
%function [outImg] = meanFilter(current_img, kernel_size)
%    %pad image based on kernel size
%    pad = floor(kernel_size/2);
%    [x,y,z] = size(current_img);
%    %add zeroes to each side of image
%    lr_edge = zeros(x, pad, z);
%    new_img = horzcat(current_img, lr_edge);
%    new_img = horzcat(lr_edge, new_img);
%
%    %add zeroes to top and bottom of image (add 2 here instead of sides)
%    tb_edge = zeros(pad, y+(2*pad), z);
%    new_img = vertcat(new_img, tb_edge);
%    new_img = vertcat(tb_edge, new_img);
%    %https://stackoverflow.com/questions/31025506/average-filter-matlab
%    outImg = zeros(x,y,z);   
%    [x,y,z] = size(new_img);
%    for i = 1:z % ensures we don't mix colors
%        for j = 1 + pad:x - pad % don't want to iterate on pads %row
%            for k = 1 + pad:y - pad % column
%                sum = 0;
%                for kernel_row = j - pad:j + pad % now extract kernel values with pad included
%                    for kernel_column = k - pad: k + pad %kernel column
%                        % get sum of kernel area for single color 
%                        sum = sum + new_img(kernel_row, kernel_column, i);
%                    end                    
%                end
%                avg = sum/(kernel_size * kernel_size);
%                outImg(j - pad, k - pad, i) = avg;
%            end
%        end
%    end
%    imwrite(outImg,'hw1_9.png');
%end