# Names: Devin Burke, Ty Tomlin
# Course #: CSCI 5722
# Assignment #: 2
# Instructor: Fleming

import matplotlib.pyplot as plt
import numpy as np
from random import sample

def parse_points(file):
    f = open(file, "r")
    points = []
    for line in f:
        coords = [float(tmp) for tmp in line.split()]
        points.append(coords)
    return points

def get_points(img1, img2):
    fig, (ax1, ax2) = plt.subplots(1, 2)

    ax1.imshow(img1)
    ax2.imshow(img2)

    # gets a list of (x,y) or (col, row) coordinates
    coord_list_flat = plt.ginput(20, -1, show_clicks=True)
    coord_map =  np.reshape(coord_list_flat, (10, 4))
    plt.clf()
    return(coord_map)
