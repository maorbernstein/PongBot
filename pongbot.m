function pongbot()

    clear all;
    cam=webcam('USB2.0');
    preview(cam);
    max_rpm = 6000;
    a = arduino('com5', 'uno', 'Libraries', 'Adafruit\MotorShieldV2');
    b = arduino('com7', 'uno', 'Libraries', 'Adafruit\MotorShieldV2');
    shield = addon(a, 'Adafruit\MotorShieldV2');
    shield_second = addon(b,'Adafruit\MotorShieldV2');
    %s = servo(shield, 1); 
    dcm1 = dcmotor(shield, 1);
    dcm2 = dcmotor(shield, 2);
    lin = dcmotor(shield, 3);
    fan = stepper(shield_second,2,200,'RPM',10,'stepType','microstep');
    % move(fan,60)
    while true
        button=buttondetect(a);
        making_image(cam);
        circles = openCV();
        number_cups=size(circles.cen_cups,1);
        number = select_cup(number_cups)
        pixel = circles.cen_cups(number,:)
        [x, y] = conversion(pixel(1),pixel(2))
        distance = calc_dist(x,y)
        angle_scaled = calc_angle(x,y)/180; % scale angle to [0,1]
        rpm = VelocityFunc(distance, 4, 0.0275);
        wheel_speed = rpm/max_rpm; % scale rpm to speed [-1,1]
        dcm1.Speed = -1.2*wheel_speed;
        dcm2.Speed = -1.2*wheel_speed;
        lin.Speed = 0.3;
        start(dcm1);
        start(dcm2);
        start(lin);
        button=buttondetect(a);
        if button
            dcm1.Speed = 0;
            dcm2.Speed = 0;
            lin.Speed = 0;
            start(dcm1);
            start(dcm2);
            start(lin); 
        end
    end
    % writePosition(s,angle_scaled);
    
end

function result=buttondetect(a)
    result = true;
    while result
        voltage=readDigitalPin(a,2);
        if voltage == 1
            result = false;
        end
    end
    pause(0.2)
    result = ~result;
end


function making_image(cam)
    pause(1)
    img = snapshot(cam);
    imwrite(img,sprintf('img%d.jpg',1));
end

function number=select_cup(number_cups)
    number=randi(number_cups);
end

function [x, y] = conversion(pixel_x,pixel_y)

width = .611;    % table width [cm]
length = 2.37;   % table length [cm]
x = pixel_x * width*1.1 / 640;
y = length - pixel_y * width*1.1 / 640;
end

function distance = calc_dist(x,y)
width = .611;
distance = sqrt((x-width)^2 + y^2 );
end

function angle = calc_angle(x,y)
width = .611;
angle = atand( y / (x - width/2) ); % servo angle = [0,180]
if angle < 0
    angle = angle + 180;
end
end