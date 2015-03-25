function values = get_sensor_values()

% constants
TIME_STEP = 64;
N = 8;

% get and enable distance sensors
for i=1:N
  ps(i) = wb_robot_get_device(['ds' int2str(i-1)]);
  wb_distance_sensor_enable(ps(i),TIME_STEP);
end

% store all distance sensors
for i=1:N
    values(i) = wb_distance_sensor_get_value(ps(i));
end

