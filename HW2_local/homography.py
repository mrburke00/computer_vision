# Names: Devin Burke, Ty Tomlin
# Course #: CSCI 5722
# Assignment #: 2
# Instructor: Fleming

import matplotlib.pyplot as plt
import numpy as np
from random import sample

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
    print(corr)
    for i in range(200):
        rand_indices = np.random.choice(10, 4, replace=False)
        rand_corr = corr[rand_indices, :]
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
