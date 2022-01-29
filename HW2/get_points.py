
import matplotlib.pyplot as plt

def get_points(img1, img2):
    fig, (ax1, ax2) = plt.subplots(1, 2)
    ax1.imshow(img1)
    ax2.imshow(img2)

    # gets a list of (x,y) or (col, row) coordinates
    coord_list = plt.ginput(20, -1, show_clicks=True)

    return(coord_list)

def rearrange_matrix(matrix):
  corr_matrix = []
  for i in range(0,len(matrix),2):
    new_row = []
    new_row.append(matrix[i][0])
    new_row.append(matrix[i][1])
    new_row.append(matrix[i+1][0])
    new_row.append(matrix[i+1][1])
    corr_matrix.append(new_row)
  return corr_matrix