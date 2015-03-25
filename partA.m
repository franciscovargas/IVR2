function [] = partA()
% PARTA Part A1 of the assignment

    % constants
    TIME_STEP = 64;
    N = 8;
    GOAL_DISTANCE = 300;
    DEFAULT_SPEED = 4;
    K = 0.01;

    % main loop:
    % perform simulation steps of TIME_STEP milliseconds
    % and leave the controll to the keyboard

    while wb_robot_step(TIME_STEP) ~= -1
        
        % read all distance sensors
        sensor_values = get_sensor_values();
            
        % sum the values of left sensors
        left_sensors = sum(sensor_values(1:3));

        % proportional error control
        error = K*(left_sensors - GOAL_DISTANCE*2);

        % set speeds
        left_speed = DEFAULT_SPEED + error; 
        right_speed = DEFAULT_SPEED - error;

        wb_differential_wheels_set_speed(left_speed,right_speed);
        wb_robot_step(TIME_STEP);
    end



