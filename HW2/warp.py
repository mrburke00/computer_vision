import numpy as np
from scipy import interpolate

#function for binding bounding box of numpy array from https://stackoverflow.com/questions/31400769/bounding-box-of-numpy-array
def bounding_box(img):

    x = np.any(img, axis=(1, 2))
    y = np.any(img, axis=(0, 2))

    xmin, xmax = np.where(x)[0][[0, -1]]
    ymin, ymax = np.where(y)[0][[0, -1]]

    return xmin, xmax, ymin, ymax



'''
def warp1(H, ref_img, warp_img):
	ref_x_min, ref_x_max, ref_y_min, ref_y_max = bounding_box(ref_img)
	warp_x_min, warp_x_max, warp_y_min, warp_y_max = bounding_box(warp_img)

	print(ref_x_min, ref_x_max, ref_y_min, ref_y_max)
	print(warp_x_min, warp_x_max, warp_y_min, warp_y_max)

	bb_x_min = min(ref_x_min, warp_x_min)
	bb_y_min = min(ref_y_min, warp_y_min)
	bb_x_max = max(ref_x_max, warp_x_max)
	bb_y_max = max(ref_y_max, warp_y_max)

	mesh_x = list(range(bb_x_min, bb_x_max, 1))
	mesh_y = list(range(bb_y_min, bb_y_max, 1))

	xx, yy = np.meshgrid(mesh_x, mesh_y)

	out_img = np.zeros([479,639,3],dtype=np.uint8)

	invH = np.linalg.inv(H)


	x1 = np.true_divide(invH[0,0]*xx + invH[0,1]*yy + invH[0,2], invH[2,1]*xx + invH[2,2]*yy + invH[2,1])
	y1 = np.true_divide(invH[1,0]*xx + invH[1,1]*yy + invH[1,2], invH[2,1]*xx + invH[2,2]*yy + invH[2,1])

	print(x1.shape)
	print(y1.shape)
	out_img[:,:,1] = [interpolate.interp2d(warp_img[:,:.,1], 'bilinear')];
	#out_img[:,:,2] = [interpolate.interp2d(warp_img[:,:,2],x1,y1, 'bilinear')];
	#out_img[:,:,3] = [interpolate.interp2d(warp_img[:,:,3],x1,y1, 'bilinear')];

	fig, (ax1, ax2) = plt.subplots(1, 2)
	ax1.imshow(out_img)
	ax2.imshow(out_img)'''
	