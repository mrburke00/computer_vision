# Names: Devin Burke, Ty Tomlin
# Course #: CSCI 5722
# Assignment #: 2
# Instructor: Fleming

import numpy as np
import matplotlib.pyplot as plt
from math import floor, ceil
from scipy import interpolate
from scipy import linalg

def warp1(hmg, ref, to_warp):

    ref_rows, ref_cols = ref.shape[0], ref.shape[1]
    warp_rows, warp_cols = to_warp.shape[0], to_warp.shape[1]

    # get a list of points to create a bounding box, so put the corners of ref image and project corners of the warped
    # image into a single object
    points = [hmg @ np.array([0, 0, 1]).transpose(),
              hmg @ np.array([warp_cols, 0, 1]).transpose(),
              hmg @ np.array([0, warp_rows , 1]).transpose(),
              hmg @ np.array([warp_cols, warp_rows, 1]).transpose(),
              np.array([0, 0, 1]).transpose(),
              np.array([ref_cols, 0, 1]).transpose(),
              np.array([0, ref_rows , 1]).transpose(),
              np.array([ref_cols, ref_rows , 1]).transpose()# possible -1
             ]

    # scale the homogenous coords by z - note that for the ref image z is always 1
    bb_input_coords = [np.array([x/z,y/z]) for (x,y,z) in points]
    x_coords,y_coords = zip(*bb_input_coords)

    # get the bounding box given a list of x and y coords https://stackoverflow.com/questions/46335488/how-to-efficiently-find-the-bounding-box-of-a-collection-of-points
    x_min,y_min,x_max,y_max = floor(min(x_coords)),floor(min(y_coords)),ceil(max(x_coords)),ceil(max(y_coords))
    x_range,y_range = x_max - x_min, y_max - y_min

    # allocate ouput image using calculated values of the bounding box
    out_img = np.zeros([y_range, x_range, 3], dtype=np.uint8)

    # set the offsets - note we only have to do this if the warped image has one or both coods negative, otherwise, there is no offset
    x_off, y_off = 0, 0
    if x_min < 0:
        x_off = abs(x_min)

    if y_min < 0:
        y_off = abs(y_min)

    # copy over the reference image to output image
    out_img[y_off:y_off+ref_rows, x_off:x_off+ref_cols] = ref

    # basically create a inteprolation map before hand, so we can reference it in our loops without recalculating every time
    inv_H = np.linalg.inv(hmg)
    #generate the interpolation function for the image to warp for each color channel
    f_1 = interpolate.interp2d( np.arange(warp_cols), np.arange(warp_rows), to_warp[:,:,0] )
    f_2 = interpolate.interp2d( np.arange(warp_cols), np.arange(warp_rows), to_warp[:,:,1] )
    f_3 = interpolate.interp2d( np.arange(warp_cols), np.arange(warp_rows), to_warp[:,:,2] )

    # loop through the output image
    for row in range(y_range):
        for col in range(x_range):
            # if we have a blank pixel, i.e. ref has not filled it already
            comp = out_img[row, col] == np.array([0,0,0])
            if comp.all(): # if the pixel is all zeros then it does not belong to the reference image
                # map that pixel back to the image to warp
                orig_loc =  inv_H @ np.array([col - x_off, row - y_off, 1]).transpose()
                orig_col = orig_loc[0] / orig_loc[2]
                orig_row = orig_loc[1] / orig_loc[2]
                # if we have mapped within the warped image bounds, interpolate and fill
                if 0 <= orig_col < warp_cols and 0 <= orig_row < warp_rows:
                    #out_img[row,col] = to_warp[orig_row,orig_col]
                    # take the mapped pixel and perform interpolation to extract its intensity
                    out_img[row,col,0] = f_1(orig_col, orig_row)
                    out_img[row,col,1] = f_2(orig_col, orig_row)
                    out_img[row,col,2] = f_3(orig_col, orig_row)


    fig, (ax1, ax2, ax3) = plt.subplots(1, 3)
    ax1.imshow(ref)
    ax1.set_title('Reference')
    ax2.imshow(to_warp)
    ax2.set_title('To Warp')
    ax3.imshow(out_img)
    ax3.set_title('Result')


    #plt.imshow(out_img, interpolation='bicubic')
    # plt.plot(bb_input_coords[0][0] + x_off, bb_input_coords[0][1]+ y_off,marker='o', color='red')
    # plt.plot(bb_input_coords[1][0] + x_off, bb_input_coords[1][1]+ y_off,marker='o', color='red')
    # plt.plot(bb_input_coords[2][0] + x_off, bb_input_coords[2][1]+ y_off,marker='o', color='red')
    # plt.plot(bb_input_coords[3][0] + x_off, bb_input_coords[3][1]+ y_off,marker='o', color='red')
    plt.show()
    # plt.imsave('out_mosaic.jpg', out_img)
