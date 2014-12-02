function distance = Toss(v0,theta)
%Toss is a function that approximates the trajectory of a ping pong ball
%using a simple forward euler.
%Toss takes inputs of the initial speed of the ball, v0, and the launch
%angle in radians, theta. Toss outputs the range of the ball if the ball
%were to land directly on top of a Red Solo cup.


g = 9.81; % Acceleration due to gravity in m/s^2
Cd = .5; % Unitless quantity representing the drag of a ping pong ball
d = .04; % diameter of a ping pong ball
rho = 1.225; % Density of air
r = d/2;
A = pi*r^2;
m = .007; % mass of a ping pong ball
coeff = 1/2 * Cd * rho * A / m; % This coefficient simplifies the expression of the drag force

N = 5000; % This constant represents the max number of time steps
dt = 1e-3; % This constant represents the timestep size
x(1) = 0; % Initial x position of ball
y(1) = 0; % Initial position of ball
vx(1) = v0*cos(theta); % Initial x velocity
vy(1) = v0*sin(theta); % Initial y velocity

% Below is a simple forward euler that breaks when the ball is falling and
% is below the height of the red solo cup.
for i=1:N
    x(i+1) = x(i) + dt*vx(i);
    y(i+1) = y(i) + dt*vy(i);
    v_mag = sqrt(vx(i)^2 + vy(i)^2);
    vx(i+1) = vx(i) + dt*-coeff*v_mag*vx(i);
    vy(i+1) = vy(i) + dt*(-g - coeff*v_mag*vy(i));
    
    if (y(i+1) < .12065) && (vy(i+1)<0)
        break;
    end
    
end
distance = x(end);
end