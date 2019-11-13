%% QUESTION 3
init_heli_d3p3;
% State space model
A = zeros(5,5);
B = zeros(5,2);

A(1,2) = 1;
A(4,1) = 1;
A(5,3) = 1;

B(2,2) = K_1;
B(3,1) = K_2;

C = zeros(2,5);
C(1,1) = 1;
C(2,3) = 1;

% LQR regulator
q_p = 15;
q_pdot = 12;
q_edot = 12;
r_p = 7;
r_edot = 10;
q_gamma = 10;
q_zeta = 10;

Q = diag([q_p q_pdot q_edot q_gamma q_zeta]);
R = diag([r_p r_edot]);
K = lqr(A, B, Q, R);

%Reference feed-forward
F = [0 1; 1 0];     % based off 3.2

%Reference for integral effect
R_r = zeros(5, 2);
R_r(4,1) = -1;
R_r(5,2) = -1;

% Attempting to find feed-forward gain analytically
LOOK_Coeff_F = C*inv(B*K-A)*B;          % = 0 coeff. for F
LOOK_Identity = C*inv(B*K-A)*R_r;       % = I


 