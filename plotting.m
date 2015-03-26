m1 = matfile('error_kp_op.mat');
m2 = matfile('error_kd_med.mat');
m3 = matfile('error_kd_max.mat');

A1 = m1.error_array;
A2 = m2.error_array;
A3 = m3.error_array;

figure
plot(A3(:,1), A3(:,2), 'g', A2(:,1), A2(:,2), 'r', A1(:,1), A1(:,2), 'b');
