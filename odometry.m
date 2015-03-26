function [ x, y, phi ] = odometry( x, y, phi, left_speed, right_speed )
%ODOMETRY returns the estimated x,y and phi value in reference to the starting position

R = 0.053 /2;  % half of the axis length of the robot

% transform speeds into distances    
left_speed = left_speed*0.008/100;
right_speed = right_speed*0.008/100;
    
% calculate x-coordinate
x = x + 0.5 * (left_speed+right_speed) * cos(phi);
    
% calculate y-coordinate
y = y - 0.5 * (left_speed + right_speed) * sin(phi);

% calculate angle phi
phi = phi - (left_speed - right_speed) / (2 * R);

end