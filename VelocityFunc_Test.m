%This simple function tests the VelocityFunc. It loops through VelocityFunc
%for given distance settings, and plots the output. We expect it to be
%approximately root-like and then for large values to be polynomial
%(approx. quadratic)

N = 100;
d0 = linspace(0,25,N);

for i=1:N
    v(i) = VelocityFunc(d0(i),i,.055);
end
plot(d0,v);
xlabel('Set Distance');
ylabel('Velocity');