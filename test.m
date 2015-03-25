% Main script for making the robot navigate around walls/objects
TIME_STEP = 64;
ERROR_DISTANCE = 200;
DEFAULT_SPEED = 3;
x = 0;
y = 0;
phi = 0;
K = 0.001;
left_speed = 3;
right_speed = -3;


for i = 1:54    %108
    
    wb_differential_wheels_set_speed(left_speed,right_speed);
    [x, y, phi] = odometry( x, y, phi, left_speed, right_speed);
    wb_robot_step(TIME_STEP);  
    i
    phi
end


for i = 1:50    %108
    wb_differential_wheels_set_speed(left_speed,left_speed);
    [x, y, phi] = odometry( x, y, phi, left_speed, left_speed);
    wb_robot_step(TIME_STEP);  
    i
    phi
    x
    y
end

wb_differential_wheels_set_speed(0,0);
wb_robot_step(TIME_STEP);   
    







