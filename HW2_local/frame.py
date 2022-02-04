# Names: Devin Burke
# Course #: CSCI 5722
# Assignment #: 2
# Instructor: Fleming

import os
import matplotlib as mpl
from matplotlib import pyplot as plt
from get_points import get_points, parse_points
from warp import warp1
import numpy as np
from random import sample

def parse_points(file):
    f = open(file, "r")
    points = []
    for line in f:
        coords = [float(tmp) for tmp in line.split()]
        points.append(coords)
    return points

def get_computed_hmg(corr):
    # Given 4 correspdonce points, compute a homography matrix H by solving the homogenous system Ah=0
    A = []
    for xp,yp,x,y in corr:
        A.append([-x, -y, -1, 0, 0, 0, x*xp, y*xp, xp])
        A.append([0, 0, 0, -x, -y, -1, x*yp, y*yp, yp])

    # cast to numpy array for lin alg ops
    A = np.array(A)

    # perform SVD on A, note V is not transposed
    U, Sigma, V = np.linalg.svd(A)

    # take the row of V (col of V^T) that corresponds to the minimized singular value, this is h, reshape to 3x3 to get H
    H = np.reshape(V[-1], (3,3))

    return H

def compute_H(corr):
    min_err = 999999.0
    min_H = []

    for i in range(200):
        #rand_indices = np.random.choice(10, 4, replace=False)
        #rand_corr = corr[rand_indices, :]
        rand_corr = corr
        H = get_computed_hmg(rand_corr)

        error = []
        #iterate thru selected points
        for xp,yp,x,y in corr:

            # project the point, returns 1x3 vector
            xy_h = H @ np.array([x, y, 1]).transpose()

            # scale x and y by z to get from homogenous coordinates to cartesian
            P_act = np.array([xy_h[0] / xy_h[2], xy_h[1] / xy_h[2]])

            #get true values
            P_exp = np.array([xp, yp])

            # store error for each of the 10 correspondence points
            error.append(np.linalg.norm(P_exp - P_act))

        # store the average error for the candidate homography matrix in a dict with the homography matrix as the key
        avg_err = np.average(np.array(error))

        if avg_err < min_err:
            min_H = H
            min_err = avg_err

    return(min_H)


def main(reset_points = False):

    billboard = plt.imread(os.path.join('img', 'billboard.jpg'))
    dog = plt.imread(os.path.join('img', 'dog.jpg'))
    points = parse_points("frame_points.txt")
    print(points)
    #fig, (ax1) = plt.subplots(1, 1)
    #ax1.imshow(billboard)
    #coord_list_flat = plt.ginput(4, -1, show_clicks=True)
    #coord_map =  np.reshape(coord_list_flat, (10, 4))
    #plt.clf()
    # TL, BL, BR, TR
    #mxm = np.shape()
    #bill_coordinates = [[75.62903225806451, 78.33870967741933], [70.46774193548387, 255.11290322580643], [568.5322580645161, 257.69354838709677], [563.3709677419355, 77.0483870967742]]
    dog_coordinates = [[0,0], [0,dog.shape[0]], [dog.shape[0],dog.shape[1]], [dog.shape[1],0]]
    #points = [[75.62903225806451, 78.33870967741933 0,0], [70.46774193548387, 255.11290322580643, 0, dog_y], [568.5322580645161, 257.69354838709677, dog_x, dog_y], [563.3709677419355, 77.0483870967742, dog_x, 0]]
    

    H = compute_H(points)    

    out_img = np.zeros([billboard.shape[0], billboard.shape[1], 3], dtype=np.uint8)

    out_img = out_img + billboard

    inv_H = np.linalg.inv(H)



    for row in range(dog.shape[0]):
        for col in range(dog.shape[1]):
            orig_loc =  inv_H @ np.array([col, row , 1]).transpose()
            orig_col = int(orig_loc[0] / orig_loc[2])
            orig_row = int(orig_loc[1] / orig_loc[2])
            #print(orig_col)
            #print(orig_row)
            if 0 <= orig_col < dog.shape[1] and 0 <= orig_row < dog.shape[0]:

                out_img[row,col] = dog[orig_row, orig_col]



    fig, (ax1, ax2, ax3) = plt.subplots(1, 3)
    ax1.imshow(billboard)
    ax1.set_title('Frame')
    ax2.imshow(dog)
    ax2.set_title('Subject')
    ax3.imshow(out_img)
    ax3.set_title('Result')
    plt.show()

if __name__ == "__main__":
    main()