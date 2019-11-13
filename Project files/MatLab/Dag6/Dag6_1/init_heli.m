% FOR HELICOPTER NR 3-10
% This file contains the initialization for the helicopter assignment in
% the course TTK4115. Run this file before you execute QuaRC_ -> Build 
% to build the file heli_q8.mdl.

% Oppdatert h�sten 2006 av Jostein Bakkeheim
% Oppdatert h�sten 2008 av Arnfinn Aas Eielsen
% Oppdatert h�sten 2009 av Jonathan Ronen
% Updated fall 2010, Dominik Breu
% Updated fall 2013, Mark Haring
% Updated spring 2015, Mark Haring


%%%%%%%%%%% Calibration of the encoder and the hardware for the specific
%%%%%%%%%%% helicopter
Joystick_gain_x = 1;
Joystick_gain_y = 1;


%%%%%%%%%%% Physical constants
g = 9.81; % gravitational constant [m/s^2]
l_c = 0.46; % distance elevation axis to counterweight [m]
l_h = 0.66; % distance elevation axis to helicopter head [m]
l_p = 0.175; % distance pitch axis to motor [m]
m_c = 1.92; % Counterweight mass [kg]
m_p = 0.72; % Motor mass [kg]


% V_s0    
V_s0 = 0.7;

% Motor constants
K_f = 1.28;


%Helicopter moment of inertia
J_p = 2*m_p*l_p.^2;
J_e = m_c*l_c.^2 + 2*m_p*l_h.^2;
J_l = m_c*l_c.^2 + 2*m_p*(l_h.^2 + l_p.^2);

% Elevation Reg parameters
K_2 = K_f*l_h/J_e;                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
%Pitch Regulator parameters
K_1 = K_f*l_p/J_p;
zeta = 0.6;
w_0 = 1;

K_pp = (w_0.^2)/K_1;
K_pd = (2*zeta*w_0)/K_1;

%Lambda parameters
K_3 = (K_f*l_h/J_l)*V_s0;
% Set up port

PORT = 3;