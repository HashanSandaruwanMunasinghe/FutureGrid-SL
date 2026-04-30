% ========================================================================
% ========================================================================
% ========================================================================
% ========================================================================
% ====================     SRI LANKA POWER MODEL   =======================
% ========================================================================
% ========================================================================
% ========================================================================
% ========================================================================
% ========================================================================
t_dist = 200;
rocof_meas_window = 0.18 ;


%% Global System Values
f_base = 50;           % Nominal frequency in Hz
S_base_sys = 1000e6;   % 1000 MVA System Base for CEB Grid
D_T = 1.5;             % Total system damping

%% 1. LAKVIJAYA POWER PLANT START ===========================================

% Lakvijaya Coal Power Plant (Reheat Steam Unit) Parameters

% 1. Power and Grid Integration
LAK_S_nom = 300e6;   % Nominal Capacity: 300 MVA (One unit)
LAK_H = 3.0;         % Inertia Constant: 3.0 seconds (Heavy coal rotor)
LAK_R = 0.04;        % Droop Setting: 4% (Standard CEB grid compliance)

% 2. Governor and Turbine Time Constants
RHT_F_HP = 0.3;      % High-Pressure (HP) turbine power fraction
RHT_T_RH = 7.0;      % Reheater time constant (Massive steam delay)
RHT_T_CH = 0.3;      % Steam chest time constant


% LAKVIJAYA END ========================================================

%% 2. Samanalawewa
SAM_Unit_S_nom = 60e6;   % 60 MVA per unit
SAM_H = 3.5;             % Hydro rotor inertia
SAM_R_P = 0.05;          % 5% Permanent Droop

% Hydro Turbine Dynamics (Applies to both units)
SAM_T_R = 5.0;         
SAM_R_T = 0.38;        
SAM_T_W = 1.5;

% Samanalawewa End =====================================================

%% 3. Kelanitissa Specific Parameters (Gas & CCGT)
KEL_R = 0.04;          % 4% Droop (Applies to all units)
KEL_T_CH = 0.3;        % Combustor Delay for Gas Turbines (s)
KEL_UNIT1_S_nom = 20e6;
KEL_UNIT2_S_nom = 115e6;
KEL_UNIT3_S_nom = 165e6;


% Combined Cycle Block (165 MW) Specific Fractions
KEL_CC_F_GT = 0.67;    % Gas Turbine Power Fraction (110 MW)
KEL_CC_F_ST = 0.33;    % Steam Turbine Power Fraction (55 MW)
KEL_CC_T_HRSG = 10.0;  % Heat Recovery Steam Generator Delay (s)


%% 4. Kelanitissa Individual Inertia Constants (Seconds)
KEL_CC_H = 4.0;       % Combined Cycle Block (Heavy dual-rotor system)
KEL_GT7_H = 2.5;      % Fiat-Avio Open Cycle (Single rotor)
KEL_U1_H = 2.5;   % Frame 5 Open Cycle (Single rotor, applies to all 4)
% Kelanitissa End


%% 5. Uthuru Janani (Chunnakam) Specific Parameters (Diesel)
UTH_R = 0.04;          % 4% Droop
UTH_T_ACT = 0.1;       % Diesel Engine Actuator & Combustion Delay (s)
UTH_Unit_S_nom = 8e6;  % 8 MVA per unit (3 units total)
UTH_H = 1.5;           % 1.5s Inertia (Low mass, fast spin)
% Uthuru Janani End

%% 6. Randenigala Specific Parameters (Francis Hydro)
RAN_R_P = 0.05;          % 5% Permanent Droop
RAN_R_T = 0.38;          % Transient Droop Compensation
RAN_T_R = 5.0;           % Transient Droop Time Constant (s)
RAN_T_W = 1.2;           % Water Column / Penstock Delay (s)

RAN_Unit_S_nom = 63e6;   % 63 MVA per unit (2 units total)
RAN_H = 3.5;             % 3.5s Inertia (Standard for heavy hydro rotors)

%% 7. Rantambe Specific Parameters (Francis Hydro)
RTB_R_P = 0.05;          % 5% Permanent Droop
RTB_R_T = 0.38;          % Transient Droop Compensation
RTB_T_R = 5.0;           % Transient Droop Time Constant (s)
RTB_T_W = 1.0;           % Water Column / Penstock Delay (s)

RTB_Unit_S_nom = 26e6;   % 26 MVA per unit (2 units total)
RTB_H = 3.0;             % 3.0s Inertia


%% 8. Bowatenna Specific Parameters (Francis Hydro)
BWT_R_P = 0.05;          % 5% Permanent Droop
BWT_R_T = 0.38;          % Transient Droop Compensation
BWT_T_R = 5.0;           % Transient Droop Time Constant (s)
BWT_T_W = 1.5;           % Water Column / Penstock Delay (s)

BWT_Unit_S_nom = 40e6;   % 40 MVA (Only 1 unit!)
BWT_H = 3.0;             % 3.0s Inertia

%% 9. Ukuwela Specific Parameters (Francis Hydro)
UKU_R_P = 0.05;          % 5% Permanent Droop
UKU_R_T = 0.38;          % Transient Droop Compensation
UKU_T_R = 5.0;           % Transient Droop Time Constant (s)
UKU_T_W = 1.2;           % Water Column / Penstock Delay (s)

UKU_Unit_S_nom = 20e6;   % 20 MVA per unit (2 units total)
UKU_H = 3.0;             % 3.0s Inertia (Standard for this size)









%% ========================================================================
% Plese leave the below section in below in order to omit the running
% conflicts and when you add the plant just update the Plant_S_nom and
% Plant_H array
% Define your plants in a specific order.
% Index Order: [Lakvijaya 1, Lakvijaya 2, Lakvijaya 3, Mahaweli, Kelanitissa]

% 1. Plant Capacities (VA)
Plant_S_nom = [LAK_S_nom, LAK_S_nom, LAK_S_nom , SAM_Unit_S_nom , SAM_Unit_S_nom,  KEL_UNIT1_S_nom,KEL_UNIT1_S_nom,KEL_UNIT1_S_nom,KEL_UNIT1_S_nom,KEL_UNIT2_S_nom, KEL_UNIT3_S_nom ,UTH_Unit_S_nom,UTH_Unit_S_nom,UTH_Unit_S_nom,RAN_Unit_S_nom,RAN_Unit_S_nom, RTB_Unit_S_nom,RTB_Unit_S_nom,BWT_Unit_S_nom, UKU_Unit_S_nom,UKU_Unit_S_nom ]; 

% 2. Plant Inertias (Seconds)
Plant_H     = [ LAK_H,   LAK_H,   LAK_H, SAM_H, SAM_H,KEL_U1_H,KEL_U1_H,KEL_U1_H,KEL_U1_H,KEL_U1_H,KEL_CC_H, UTH_H, UTH_H ,UTH_H,RAN_H,RAN_H , RTB_H, RTB_H, BWT_H,UKU_H,UKU_H]; 

% Automatic Equivalent Inertia Calculation
% The '.*' operator multiplies matching pairs, and 'sum' adds them all together.
H_eq = sum(Plant_H .* Plant_S_nom) / S_base_sys;

% Universal Governor Settings
T_G = 0.2;             % Standard valve actuator delay (Applies to all plants)
