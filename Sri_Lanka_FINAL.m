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



%% Hashan

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




%% 10. Mannar (Thambapavani) Wind Farm Parameters
MAN_Unit_S_nom = 100e6;  % 100 MVA Wind Park
MAN_H = 0.0;             % ZERO physical inertia (Decoupled by inverters)

MAN_K_vir = 12.0;        % Synthetic/Virtual Inertia Gain (Derivative Control)
MAN_T_INV = 0.05;        % Inverter processing delay (Lightning fast 50ms)
MAN_T_FILT = 0.02;       % NEW: 20ms PLL Frequency Measurement Filter














%% Dinitha

%% Sobadhanavi Power Plant (GT)
% 1. Power and Grid Integration
SOBA_GT_S_nom = 220e6;   % Nominal Capacity (Approx 220 MVA)
SOBA_GT_H = 4.5;         % Inertia Constant (Gas turbines have lower inertia than coal)
SOBA_GT_R = 0.04;        % 4% Droop

% Turbine Dynamics
SOBA_GT_T_g = 0.05;      % Fast fuel valve actuator
SOBA_GT_T_t = 0.2;       % GT torque constant

% Sobadhanavi GT End



%% Sobadhanavi Power Plant (ST)
% Steam Turbine (ST)
SOBA_ST_S_nom = 130e6;   % Nominal Capacity (Approx 130 MVA)
SOBA_ST_H = 3.5;         % ST rotor inertia
SOBA_ST_R = 0.04;        % 4% Droop

% Turbine Dynamics
SOBA_ST_T_hrsga = 10.0;  % HRSG "Boiler" lag (Very slow)
SOBA_ST_T_ch = 0.5;      % Steam chest constant
% Sobadhanavi ST end


%% Yugadhanavi Power Plant (GT)
%Grid Integration
YUGA_GT_S_nom = 100e6;  % 100 MVA per GT
YUGA_GT_H = 4.5;        
YUGA_GT_R = 0.04;

% Turbine/Governer Dynamics
YUGA_GT_T_G = 0.1;  % Governer
YUGA_GT_T_t = 0.4;      % Turbine
% Yugadhanavi GT end

%% Yugadhanavi Power Plant (ST)
%Grid Integration
YUGA_ST_S_nom = 100e6;  % 100 MVA for the ST
YUGA_ST_H = 3.5;
YUGA_ST_R = 0.04;

%Turbine/Governer Dynamics
YUGA_ST_T_hrsga = 15.0;  % HRSG "Boiler" lag (Very slow)
YUGA_ST_T_ch = 0.3;      % Steam chest constant

%End Yugadhanavi


%% New Laxapana Power Station (Hydro - Pelton)
NLX_Unit_S_nom = 50e6;    % 50 MVA per unit (2 units total)
NLX_H = 3.5;              % Hydro rotor inertia (Typical)
NLX_R_P = 0.05;           % 5% Permanent Droop (CEB standard)

% Hydro Turbine Dynamics
NLX_T_G = 0.2;            % Main servo time constant
NLX_T_R = 5.0;            % Reset time (Temporary droop time constant)
NLX_R_T = 0.40;           % Temporary droop dashpot constant
NLX_T_W = 1.2;            % Water starting time (Slightly lower than Samanalawewa)


%% Polpitiya Power Station (Hydro - Francis)
POL_Unit_S_nom = 45e6;    % 45 MVA per unit (2 units total)
POL_H = 3.0;              % Hydro rotor inertia 
POL_R_P = 0.05;           % 5% Permanent Droop (CEB standard)

% Hydro Turbine Dynamics
POL_T_G = 0.2;            % Main servo time constant
POL_T_R = 5.0;            % Reset time (Transient time constant)
POL_R_T = 0.40;           % Temporary droop dashpot constant
POL_T_W = 1.4;            % Water starting time (Slightly lower than Samanalawewa)








%% Nayanajith

%% Canyon Power Station (Hydro - Francis)
CAN_Unit_S_nom = 30e6;    % 30 MVA per unit(2 units Total)
CAN_H = 3.0;              % Hydro Rotor inertia
CAN_R_P =0.05;            % 5% Permanent Droop (CEB standard)

% Hydro Turbine Dynamics
CAN_T_G = 0.2;            % Main servo time constant
CAN_T_R = 5.0;            % Reset time (Transient time constant)
CAN_R_T = 0.38;           % Temporary droop dashpot constant
CAN_T_W = 1.0;            % Water starting time

%% Wimalasurendra Power Station (Hydro - Francis)
WIM_Unit_S_nom = 25e6;    % 25 MVA per unit(2 units Total)
WIM_H = 3.0;              % Hydro Rotor inertia
WIM_R_P =0.05;            % 5% Permanent Droop (CEB standard)

% Hydro Turbine Dynamics
WIM_T_G = 0.2;            % Main servo time constant
WIM_T_R = 5.0;            % Reset time (Transient time constant)
WIM_R_T = 0.38;           % Temporary droop dashpot constant
WIM_T_W = 1.0;            % Water starting time

%% Old Laxapana Power Station (Hydro - Pelton )
OLX_Unit_S_nom_1 = 12.5e6;    % 12.5 MVA per unit(2 units Total)
OLX_Unit_S_nom_2 = 8.33e6;    % 8.33 MVA per unit(3 units Total)
OLX_H_1 = 3.0;                % Hydro Rotor inertia for unit 12.5 MVA
OLX_H_2 = 3.0;                % Hydro Rotor inertia for unit 8.33 MVA
OLX_R_P =0.05;                % 5% Permanent Droop (CEB standard)

% Hydro Turbine Dynamics
OLX_T_G = 0.2;            % Main servo time constant
OLX_T_R = 5.0;            % Reset time (Transient time constant)
OLX_R_T = 0.38;           % Temporary droop dashpot constant
OLX_T_W = 1.0;            % Water starting time

%% Broadland Power Station (Hydro - Francis)
BRO_Unit_S_nom = 17.5e6;    % 17.5 MVA per unit(2 units Total)
BRO_H = 3.0;                % Hydro Rotor inertia
BRO_R_P =0.05;              % 5% Permanent Droop (CEB standard)

% Hydro Turbine Dynamics
BRO_T_G = 0.2;            % Main servo time constant
BRO_T_R = 5.0;            % Reset time (Transient time constant)
BRO_R_T = 0.38;           % Temporary droop dashpot constant
BRO_T_W = 1.0;            % Water starting time

%% Uma Oya Power Station (Hydro - Pelton)
UMA_Unit_S_nom = 60e6;   % 60 MVA per unit(total 2 units)
UMA_H = 3.5;             % Hydro rotor inertia
UMA_R_P = 0.05;          % 5% Permanent Droop

% Hydro Turbine Dynamics (Applies to both units)
UMA_T_R = 5.0;           % Reset time (Transient time constant)
UMA_R_T = 0.38;          % Temporary droop dashpot constant
UMA_T_W = 1.5;           % Water starting time

%% Kukuleganga Runoff River power Station (Hydro - Francis)
KUK_Unit_S_nom = 40e6;   % 40 MVA per unit(total 2 units)
KUK_H = 3.0;             % Hydro rotor inertia
KUK_R_P = 0.05;          % 5% Permanent Droop

% Hydro Turbine Dynamics (Applies to both units)
KUK_T_R = 5.0;           % Reset time (Transient time constant)
KUK_R_T = 0.38;          % Temporary droop dashpot constant
KUK_T_W = 0.8;           % Water starting time





%% ========================================================================
% Plese leave the below section in below in order to omit the running
% conflicts and when you add the plant just update the Plant_S_nom and
% Plant_H array
% Define your plants in a specific order.
% Index Order: [Lakvijaya 1, Lakvijaya 2, Lakvijaya 3, Mahaweli, Kelanitissa]

% Index Order: [LAK1, LAK2, LAK3, SAM1, SAM2, SOBA_GT, SOBA_ST]
Plant_S_nom = [LAK_S_nom, LAK_S_nom, LAK_S_nom , SAM_Unit_S_nom , SAM_Unit_S_nom,  KEL_UNIT1_S_nom,KEL_UNIT1_S_nom,KEL_UNIT1_S_nom,KEL_UNIT1_S_nom,KEL_UNIT2_S_nom, KEL_UNIT3_S_nom ,UTH_Unit_S_nom,UTH_Unit_S_nom,UTH_Unit_S_nom,RAN_Unit_S_nom,RAN_Unit_S_nom, RTB_Unit_S_nom,RTB_Unit_S_nom,BWT_Unit_S_nom, UKU_Unit_S_nom,UKU_Unit_S_nom, MAN_Unit_S_nom,SOBA_GT_S_nom, SOBA_ST_S_nom,YUGA_GT_S_nom, YUGA_GT_S_nom, YUGA_ST_S_nom, NLX_Unit_S_nom,NLX_Unit_S_nom, POL_Unit_S_nom, POL_Unit_S_nom,CAN_Unit_S_nom, CAN_Unit_S_nom, WIM_Unit_S_nom, WIM_Unit_S_nom, OLX_Unit_S_nom_1, OLX_Unit_S_nom_1, OLX_Unit_S_nom_2, OLX_Unit_S_nom_2, OLX_Unit_S_nom_2, BRO_Unit_S_nom, BRO_Unit_S_nom, UMA_Unit_S_nom, UMA_Unit_S_nom, KUK_Unit_S_nom,KUK_Unit_S_nom ];  
Plant_H     = [LAK_H,   LAK_H,   LAK_H, SAM_H, SAM_H,KEL_U1_H,KEL_U1_H,KEL_U1_H,KEL_U1_H,KEL_U1_H,KEL_CC_H, UTH_H, UTH_H ,UTH_H,RAN_H,RAN_H , RTB_H, RTB_H, BWT_H,UKU_H,UKU_H,MAN_H,SOBA_GT_H, SOBA_ST_H, YUGA_GT_H, YUGA_GT_H,YUGA_ST_H, NLX_H,NLX_H, POL_H, POL_H,CAN_H,CAN_H, WIM_H, WIM_H, OLX_H_1, OLX_H_1, OLX_H_2, OLX_H_2, OLX_H_2, BRO_H, BRO_H, UMA_H, UMA_H, KUK_H,KUK_H]; 

% Automatic Equivalent Inertia Calculation
H_eq = sum(Plant_H .* Plant_S_nom) / S_base_sys;

% Universal Governor Settings
T_G = 0.2;             % Standard valve actuator delay (Applies to all plants)
