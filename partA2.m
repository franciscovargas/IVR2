function [] = partA()
% PARTA Part A1 of the assignment

    % constants
    TIME_STEP = 64;
    N = 8;
    GOAL_DISTANCE = 300;
    DEFAULT_SPEED = 4;
    K = 0.01;
    x = 0;
    y = 0;
    phi = 0;
    wb_differential_wheels_enable_encoders(TIME_STEP);
    wb_differential_wheels_set_encoders(0, 0);
    % main loop:
    % perform simulation steps of TIME_STEP milliseconds
    % and leave the controll to the keyboard
    l1 = 0;
    r1 = 0;
    while wb_robot_step(TIME_STEP) ~= -1
        
        % read all distance sensors
            sensor_values = get_sensor_values();
        
        % sum the values of left sensors
            left_sensors = sum(sensor_values(1:3));

        % proportional error control
            error = K*(left_sensors - GOAL_DISTANCE*2);

        % % set speeds
        l1temp = wb_differential_wheels_get_left_encoder();
        r1temp = wb_differential_wheels_get_right_encoder();
        d1 =  (l1temp - l1) ;
        d2 =   (r1temp - r1) ;
        l1 =  l1temp; %*0.0008 + error
        r1 =  r1temp; %*0.0008 - error
        left_speed = DEFAULT_SPEED + error; 
        right_speed = DEFAULT_SPEED - error;
        % disp('PRe phi');
        % phi
        % disp('######');
        wb_differential_wheels_set_speed(left_speed,right_speed);
        [x, y, phi] = odometry( x, y, phi, d1, d2,TIME_STEP);
        [x*100, y*100, phi]
        % muahahahahahahahahahah
        wb_robot_step(TIME_STEP);  
        
        
        % is it home yet?   TODO: make it actually go there
        if ((x*100 < 0.9 && y*100 < 0.9 && x*100 >= 0 && y*100 >= 0) || (x*100 > -0.9 && y*100 > -0.9 && x*100 <= 0 && y*100 <= 0))
            disp "homeeee"
        end
            
    end



