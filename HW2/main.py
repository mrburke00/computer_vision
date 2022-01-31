import os
import matplotlib as mpl
from matplotlib import pyplot as plt
from get_points import get_points
from get_points import rearrange_matrix
from compute_h import compute_h
#from warp import warp1

def main(redo_points=False, iterations=20):
    mos_1 = plt.imread(os.path.join('imgs', 'Square0.jpg'))
    mos_2 = plt.imread(os.path.join('imgs', 'Square1.jpg'))

    if redo_points:
      points = get_points(mos_1, mos_2)
      print(points)
    else:
      points = [(272.01612903225805, 255.39677419354837), (63.24193548387086, 263.9129032258064), (555.8870967741935, 292.29999999999995), (347.11290322580624, 292.29999999999995), (632.5322580645161, 207.13870967741934), (420.9193548387094, 215.6548387096774), (317.4354838709677, 158.88064516129032), (111.49999999999989, 156.04193548387093), (311.758064516129, 87.91290322580642), (108.66129032258061, 85.07419354838703), (402.5967741935484, 428.55806451612904), (190.98387096774184, 431.39677419354837), (533.1774193548388, 167.39677419354837), (327.24193548387086, 175.91290322580642), (348.6612903225806, 363.26774193548385), (137.04838709677404, 368.94516129032263), (445.17741935483866, 246.88064516129032), (242.08064516129014, 244.04193548387093), (320.2741935483871, 283.7838709677419), (114.33870967741916, 283.7838709677419)]

    corr_matrix = rearrange_matrix(points)
    homog_matrix = compute_h(corr_matrix, iterations)
    #print(homog_matrix)

    #warp1(homog_matrix, mos_1, mos_2)


if __name__ == "__main__":
    main()