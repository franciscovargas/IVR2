function [] = partA()
% PARTA Part A of the assignment - Implementing an wall-following obstacle avoiding
% algorithm that uses proportional error control 

    % define the constants for proportional movement
    TIME_STEP = 64;
    GOAL_SENSOR_VALUES = 250;
    DEFAULT_SPEED = 4;
    left_speed = 4;
    right_speed = 4;
    Kp = 0.000025;
    Kd = 0.025;
    err_current = 0;
    err_previous = 0;
    
    % initialise encoders
    wb_differential_wheels_enable_encoders(TIME_STEP);
    wb_differential_wheels_set_encoders(0, 0);
    
    % initialise variables for odometry
    x = 0;
    y = 0;
    phi = 0;
    l1 = 0;
    r1 = 0;
    AREA = 0.005;
    
    % initialise camera
    camera = wb_robot_get_device('camera');
    wb_camera_enable(camera, TIME_STEP)
    
    % loop
    i = 0;
    flag = 1;
    
    error_array = [];

    while (flag == 1)
        
    % Proportional - differential control
        % read all distance sensors
        sensor_values = get_sensor_values();
        
        % sum the values of left sensors
        left_sensors = mean(sensor_values(1:2));

        % proportional error control
        err_current = GOAL_SENSOR_VALUES - left_sensors;
        delta_speed_p = Kp * err_current;
        
        % differential error control
        delta_speed_d = Kd * (err_current - err_previous);
        err_previous = err_current;
        
        delta_speed = delta_speed_p + delta_speed_d;
        
        % set speeds
        left_speed = left_speed - delta_speed;
        right_speed = right_speed + delta_speed;
        
        % move
        wb_differential_wheels_set_speed(left_speed,right_speed);
        
        
    % Odometry
        % get encoder speeds
        l1temp = wb_differential_wheels_get_left_encoder();
        r1temp = wb_differential_wheels_get_right_encoder();
        d1 = (l1temp - l1) ;
        d2 = (r1temp - r1) ;
        l1 = l1temp;
        r1 = r1temp;
        
        % calculate odometry
        [x, y, phi] = odometry( x, y, phi, d1, d2);

    % Detect intruder
        % read image from camera
        %img = wb_camera_get_image(camera);

        % transform image to HSV
        %hsv_img = rgb2hsv(img);

        % perform thresholding
        %t_im = thresh(hsv_img(:,:,1));

    % Home detection
        % detect if it is close to 'home' area - point(0,0)
        if (i > 100 && ((x < 0.002 && y < 0.002 && x >= 0 && y >= 0) ...
         || (x > -1*AREA && y > -1*AREA && x <= 0 && y <= 0)))
            
            % stop the robot
            wb_differential_wheels_set_speed(0,0);
    
            disp ('I am Home')
    
            % end while loop
            flag = 0;
        end
         
        %error_array = [error_array; [i err_current left_sensors delta_speed]];
        i = i+1;
        wb_robot_step(TIME_STEP);

    end

       % save('error_kd_min.mat', 'error_array');
