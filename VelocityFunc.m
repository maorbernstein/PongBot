function rpm = VelocityFunc(d_set,v0_guess,radius)
%VelocityFunc is a function that finds what rpm for the motors ouputs a set
%distance using MATLAB function fzero and Toss. 
%The inputs are the set distance of interest, d_set, a guess for the
%initial velocity neccessary, v0_guess, and the radius of the wheels
%attached the motors are.
theta = pi/3; % The pitch angle is set as a constant in our design, so it is a constant in the code. 
tossfunc = @(v) Toss(v,theta) - d_set; % Here we create an anonymous function that outputs a distance that is nonzero for all values that are not d_set.
v_optimal = fzero(tossfunc,v0_guess); 
omega = v_optimal/radius;% The angular speed of the motors is the speed of the ball over the radius of the wheels
rpm = omega * 60/(2*pi); % Convert angular speed in radians/second to rounds/minute.


end

