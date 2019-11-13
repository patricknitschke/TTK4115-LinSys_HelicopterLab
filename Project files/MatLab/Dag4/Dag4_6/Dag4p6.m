%% Dag 4.1 - 4.6
init_heli_d4p6;
LQR_d4p6;
%% 4.3 Observability

A_3 = zeros(6,6);
C_3 = zeros(3,6);

A_3(1,2) = 1;
A_3(3,4) = 1;
A_3(5,6) = 1;
A_3(6,1) = K_3;

C_3(1,2) = 1;
C_3(2,4) = 1;
C_3(3,6) = 1;

O_3 = obsv(A_3,C_3);
rank_O3 = rank(O_3);

%subset

A_3s = zeros(4);
C_3s = zeros(3,4);

A_3s(1,2) = 1;
A_3s(4,1) = K_3;

C_3s(1,2) = 1;
C_3s(2,3) = 1;
C_3s(3,4) = 1;

O_3s = obsv(A_3s,C_3s);
rank_O3s = rank(O_3s);


%% 4.5 Obs part 2

A_5 = zeros(6,6);
C_5 = zeros(5,6);

A_5(1,2) = 1;
A_5(3,4) = 1;
A_5(5,6) = 1;
A_5(6,1) = K_3;

C_5(1,2) = 1;
C_5(2,4) = 1;
C_5(3,6) = 1;
C_5(4,1) = 1;
C_5(5,3) = 1;

O_5 = obsv(A_5,C_5);
rank_O5 = rank(O_5);


% 4.5 subset

A_5s = zeros(5,5);
C_5s = zeros(5,5);

A_5s(1,2) = 1;
A_5s(3,4) = 1;
A_5s(5,1) = K_3;

C_5s(1,2) = 1;
C_5s(2,4) = 1;
C_5s(3,5) = 1;
C_5s(4,1) = 1;
C_5s(5,3) = 1;

O_5s = obsv(A_5s,C_5s);
rank_O5s = rank(O_5s);

%% Task 6 - Noise

Noise_flying_still = load('Noise_flying_still_final.mat');
Noise_flying_still_vals = Noise_flying_still.Noise_flying_still(:, 10000:end); % remove incorrect start data

IMU_timestamp = Noise_flying_still_vals(1,:);
IMU_pitch_r = Noise_flying_still_vals(2,:);
IMU_elevation_r = Noise_flying_still_vals(3,:);
IMU_travel_r = Noise_flying_still_vals(4,:);
IMU_pitch = Noise_flying_still_vals(5,:);
IMU_elevation = Noise_flying_still_vals(6,:);


figure(1);
x_start = 20;
x_stop = 120;

%plot pitch rate
subplot(5,1,1);

plot(IMU_timestamp, IMU_pitch_r,'r');
hold on;
grid on;
xlabel('seconds [s]');
ylabel('Pitch rate [rad/s]');
xlim([x_start, x_stop]);
title('IMU Pitch rate');

%plot elevation rate
subplot(5,1,2);

plot(IMU_timestamp, IMU_elevation_r,'b');
hold on;
grid on;
xlabel('seconds [s]');
ylabel('Elevation rate [rad/s]');
xlim([x_start, x_stop]);
title('IMU Elevation rate');

%plot lambda rate
subplot(5,1,3);

plot(IMU_timestamp, IMU_travel_r,'g');
hold on;
grid on;
xlabel('seconds [s]');
ylabel('Travel rate [rad/s]');
xlim([x_start, x_stop]);
title('IMU Travel rate');

%plot pitch
subplot(5,1,4);

plot(IMU_timestamp, IMU_pitch,'r');
hold on;
grid on;
xlabel('seconds [s]');
ylabel('Pitch [rad]');
xlim([x_start, x_stop]);
title('IMU Pitch');

%plot elevation
subplot(5,1,5);

plot(IMU_timestamp, IMU_elevation,'b');
hold on;
grid on;
xlabel('seconds [s]');
ylabel('Elevation [rad]');
xlim([x_start, x_stop]);
title('IMU Elevation');

%expected values
pitch_r_mean = mean(IMU_pitch_r, 'omitnan');
elevation_r_mean = mean(IMU_elevation_r, 'omitnan');
travel_r_mean = mean(IMU_travel_r, 'omitnan');

% covariances
IMU_vals_no_time = Noise_flying_still_vals;
IMU_vals_no_time(1,:) = [];
Cov_matrix = cov(IMU_vals_no_time.', 'omitrows');