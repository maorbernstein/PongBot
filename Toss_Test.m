%This simple script tests the Toss function. It loops through toss with
%different initial velocities and plots the output distances against them.
%We expect a parabola for small values (1/2*m*v^2 = m*g*h), but for large
%values, we expect root-like behavior.

N = 100;
v0 = linspace(0,100,N);

for i=1:N
    d(i) = Toss(v0(i),pi/3) - 2.44;
end
plot(v0,d);
xlabel('Initial Velocity');
ylabel('Distance');