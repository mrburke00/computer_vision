% Names: Devin Burke, Ty Tomlin
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = swirlFilter(current_img, factor, ox, oy)
    % used factor and max rotation angle as described in swirl filter
    % lecture video 

    % preallocate image
    [rows, cols, ~] = size(current_img);
    current_img = double(current_img);
    outImg = current_img;

    % radius of swirl from origin to nearest edge 
    r = min([cols-ox+1, rows-oy+1, ox-1, oy-1]);

    % max possible rotation, i.e. a  point on the edge where r == d, other
    % rotations will be a fraction of this value
    max_rot = 2*pi*factor;

    for row=1:rows
        for col=1:cols
            % calculate the distance between the origin of rotation and the
            % mapped point
            d = sqrt((row - oy)^2 + (col - ox)^2);

            % only rotate the points that lie within the region we are
            % swirling
            if d <= r
                % scale theta based on how far the point is from the origin
                % of rotation
                theta = - max_rot * (d / r);
                
                % inverse rotation matrix for backwards mapping to original
                % coordinates
                R = [cos(theta) sin(theta);
                     -sin(theta) cos(theta)];
                  
                % conduct the rotation relative to ox, and oy, then add
                % back the offset to get img coordinates
                coord_vec = R * [col - ox; row - oy] + [ox; oy];

                % clamp indices to image bounds
                y = min(max(round(coord_vec(2)), 1),rows);
                x = min(max(round(coord_vec(1)), 1),cols);
                
                % populate intensity
                outImg(row, col, :) = current_img(y, x, :);
            end
        end
    end
    outImg = uint8(outImg);
    imwrite(outImg,'hw1_swirlFilter_result.png');

end