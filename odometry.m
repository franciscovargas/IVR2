function [ x, y, phi ] = odometry( x, y, phi, left_speed, right_speed,t )
%ODOMETRY returns the estimated x,y and phi value in reference to the starting position

R = 0.053 /2; % for rad, 0.45 for deg - determined by math

% odometry equations from the lab
    
left_speed = left_speed*0.008/(t*100)
right_speed = right_speed*0.008/(t*100)
    
% x ← x + Δx =x + 0.5*(left_speed + right_speed) cos(φ)
x = x + 0.5 * t*(left_speed+right_speed) * cos(phi);
    
% y ← y + Δy =y + 0.5*(left_speed + right_speed) sin(φ)
y = y - 0.5 * t*(left_speed + right_speed) * sin(phi);

%φ ← φ + Δφ = φ - 0.5*(left_speed - right_speed)/(2R)
phi = phi -  t*(left_speed - right_speed) / (2 * R);
% phi = mod(phi, (2*pi));

end