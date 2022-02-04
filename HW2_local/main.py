# Names: Devin Burke, Ty Tomlin
# Course #: CSCI 5722
# Assignment #: 2
# Instructor: Fleming

import os
import matplotlib as mpl
from matplotlib import pyplot as plt
from get_points import get_points, parse_points
from homography import compute_H
from warp import warp1
import numpy as np


def main(reset_points = False):
    mos_0 = plt.imread(os.path.join('img', 'room0.jpg'))
    mos_1 = plt.imread(os.path.join('img', 'room1.jpg'))
    points_file = "room_points.txt"

    #mos_0 = plt.imread(os.path.join('img', 'Square0.jpg'))
    #mos_1 = plt.imread(os.path.join('img', 'Square1.jpg'))
    #points_file = "square_points.txt"

    #mos_0 = plt.imread(os.path.join('img', '3.jpg'))
    #mos_1 = plt.imread(os.path.join('img', '4.jpg'))
    #points_file = "34_points.txt"

    #mos_0 = plt.imread(os.path.join('img', '5.jpg'))
    #mos_1 = plt.imread(os.path.join('img', '6.jpg'))
    #points_file = "56_points.txt"

    #mos_0 = plt.imread(os.path.join('img', '7.jpg'))
    #mos_1 = plt.imread(os.path.join('img', '8.jpg'))
    #points_file = "78_points.txt"

    if reset_points:
        points = get_points(mos_0, mos_1)
        print(points)
    else:
        # points = parse_points(points_file)
        points = parse_points("square_points.txt")
        points = np.array(points)

    H = compute_H(points)
    warp1(H, mos_0, mos_1)


if __name__ == "__main__":
    main()
