import math
import numpy as np
import matplotlib.pyplot as plt

def Toss(v,theta):
	max_iter = 10000
	dt = .001
	g = 9.81 #In m/s^2
	Cd = 0 #Coefficient of Diameter
	d = 40.0/1000 #Diameter of a ping pong ball
	A = math.pi * (d/2.0)**2
	m = 2.7/1000 #mass in kg 
	rho = 1.28 #density of a ping pong ball
	coeff = .5 * rho * Cd * A / m
	r0 = [0,0]
	v0 = [v*math.cos(theta), v*math.sin(theta)]
	val = math.sqrt(v0[0]**2 + v0[1]**2) - v
	x = []
	y = []
	vx = []
	vy = []
	x.append(r0[0])
	y.append(r0[1])
	vx.append(v0[0])
	vy.append(v0[1])
	for i in range(max_iter):
		v_mag = math.sqrt(vx[-1]**2 + vy[-1]**2)
		ax = -coeff*v_mag *vx[-1]
		ay = -coeff*v_mag * vy[-1]  - g
		x_new = x[-1] + dt * vx[-1]
		y_new = y[-1] + dt * vy[-1]
		vx_new = vx[-1] + dt * ax
		vy_new = vy[-1] + dt * ay

		if (y_new>.12065)or(vy_new>0):
			x.append(x_new)
			y.append(y_new)
			vx.append(vx_new)
			vy.append(vy_new)
		else:
			break
	pong_range = x[-1]
	descent_angle = np.arctan(vy[-1]/vx[-1])*180/math.pi
	return (x[-1],descent_angle)
def Pong(d_set,phi_set,v_0,theta_0):
	alpha = 1
	max_iter = 100
	tol = 1e-02
	v = v_0
	theta = theta_0
	for i in range(max_iter):
		(d,phi) = Toss(v,theta)
		error = d_set - d
		print error
		if (abs(error) <= tol)and (abs(phi) >= phi_set):
			break
		if (abs(error) > tol):
			v += error*alpha
		if (abs(phi) < phi_set):
			theta += alpha*(phi_set - abs(phi))

	return (v,180*theta/math.pi)
		
	


if __name__ == "__main__":
	pass

	# colors = ['b','g','r','c','m']
	# i=0
	# for angle in [45,55,65,75,85]:
	# 	x,y,vx,vy = Toss(5,angle*math.pi/180)
	# 	descent_angle = vy[-1]/vx[-1]
	# 	print "The descent angle for " + str(angle) + " is " + str(descent_angle)
	# 	plt.plot(x,y,colors[i])
	# 	i += 1

	# plt.show()
