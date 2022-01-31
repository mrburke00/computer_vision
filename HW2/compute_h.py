import numpy as np
import random
import math
def compute_h(corr_matrix, iterations):
	#each point is in the form [x1,y1,x2,y2]
	min_dist = np.inf
	for itr in range(iterations):
		points = random.choices(corr_matrix, k=4)
		A = []

		for i in range(0,len(points)):
			#A_x = A[i,:] = [-x1, -y1, -1, 0, 0, 0, x1*x2, y1*x2, x2] 
			A.append([-points[i][0], -points[i][1], -1, 0, 0, 0, points[i][0]*points[i][2], points[i][1]*points[i][2], points[i][2]])
			#A_y = A[i+1,:] = [0, 0, 0, -x1, -y1, -1, x1*y2, y1*y2, y2]
			A.append([0, 0, 0, -points[i][0], -points[i][1], -1, points[i][0]*points[i][3], points[i][2]*points[i][3], points[i][3]])

		#Solve linear least squares problem using singular value decomposition
		#V contains coefficients for homography matrix sorted in descending
		A = np.array(A)
		U, Sigma, V = np.linalg.svd(A)
		# take right singular vector of column from V which correpsonds smallest singular signma value
		# this contains the coefficients of homography matrix that best fits points
		H = np.reshape(V[-1], (3,3))
		corr_matrix = np.array(corr_matrix)
		
		#get x2,y2 coordinates and convert to homogenous 
		homog_coords = corr_matrix[:,2:4]
		ones = np.ones((homog_coords.shape[0],1))
		proj_points= np.append(homog_coords, ones, axis=1)

		#X2 = H * X1 
		proj = np.dot(H, proj_points.transpose())

		# get last column coordinate for each point
		v = proj[2,:]

		#convert homogeneous to cartesian 
		predictions = [np.true_divide(proj[0,:], v), np.true_divide(proj[1,:],v)]
		#print(predictions)
		predict_xs = predictions[0]
		predict_ys = predictions[1]

		distance = 0
		for i, (x_p,y_p) in enumerate(zip(predict_xs,predict_ys)):
			#print(corr_matrix[i][0], x_p)
			#print(corr_matrix[i][1], y_p)
			distance += (corr_matrix[i][0] - x_p)**2 + (corr_matrix[i][1] - y_p)**2
			#print(distance)
		distance = np.sqrt(distance)
		if distance <= min_dist:
			min_dist = distance
			min_H = H

	print("Minimum distance : ", min_dist)
	return min_H
