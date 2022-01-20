% Names: Devin Burke, Ty Tomlin
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming


function s_plot_save(img, mod_img)
%S_PLOT_SAVE Given two images, and an oufn, plot the images side by side,
%and save the modified image at the given filename
%   Detailed explanation goes here
    subplot(1, 2, 1);
    imagesc(img);
    title("Original");
    axis image
    subplot(1, 2, 2);
    imagesc(mod_img);
    title("Result");
    axis image
    imwrite(mod_img, oufn)
end