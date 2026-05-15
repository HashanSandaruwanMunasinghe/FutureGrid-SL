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
%clear;

t_dist = 200;
rocof_meas_window = 0.18 ;


%% Global System Values
f_base = 50;           % Nominal frequency in Hz
S_base_sys = 1000e6;   % 1000 MVA System Base for CEB Grid
D_T = 1500e6/S_base_sys;             % Total system damping

% Universal Governor Settings
T_G = 0.2;             % Standard valve actuator delay (Applies to all plants)




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



%% 11. Maduru Oya Solar PV Farm (Inverter-Based Resource)
MAD_Unit_S_nom = 100e6;  % 100 MVA Solar Park
MAD_H = 0.0;             % ZERO physical inertia (Decoupled by inverters)

% Active Power Control (Primary Frequency Response)
MAD_R = 0.05;            % 5% Droop (Assuming curtailed operation for grid support)

% Inverter & Measurement Dynamics (Lightning Fast)
MAD_T_INV = 0.02;        % Inverter processing delay (Extremely fast 20ms)
MAD_T_FILT = 0.02;       % PLL Frequency Measurement Filter (20ms)


%% 12. LAUGFS Hambantota Solar Power Plant (IBR)
LAU_Unit_S_nom = 20e6;   % 20 MVA Solar Park
LAU_H = 0.0;             % ZERO physical inertia 

% Active Power Control (Primary Frequency Response)
LAU_R = 0.05;            % 5% Droop

% Inverter & Measurement Dynamics 
LAU_T_INV = 0.02;        % Inverter processing delay (20ms)
LAU_T_FILT = 0.02;       % PLL Frequency Measurement Filter (20ms)

%% 13. Solar One Ceylon Solar Farm (IBR)
SOC_S_nom = 12.6e6; % 12.6 MVA Solar Park
SOC_H = 0.0;             % ZERO physical inertia 

% Active Power Control (Primary Frequency Response)
SOC_R = 0.05;            % 5% Droop

% Inverter & Measurement Dynamics 
SOC_T_INV = 0.02;        % Inverter processing delay (20ms)
SOC_T_FILT = 0.02;       % PLL Frequency Measurement Filter (20ms)





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



%% Uppudaluwa Wind Farm Parameters
UPP_Unit_S_nom = 10e6;   % 10 MVA Wind Park
UPP_H = 0.0;             % ZERO physical inertia
UPP_K_vir = 10.0;        % Synthetic Inertia Gain (Adjustable based on contract)
UPP_T_INV = 0.05;        % Inverter processing delay (50ms)
UPP_T_FILT = 0.02;       % PLL Frequency Measurement Filter (20ms)
UPP_R_P = 0.04;







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



%% Hambanthota Solar Farm 
HBT_S_nom = 1.2e6; % 1.2 MVA Solar Park
HBT_H = 0.0;       % ZERO physical inertia 

% Inverter & Measurement Dynamics 
HBT_T_INV = 0.02;        % Inverter processing delay (20ms)

%% Saga Solar Farm 
SAG_S_nom = 10e6; % 10 MVA Solar Park
SAG_H = 0.0;       % ZERO physical inertia 

% Inverter & Measurement Dynamics 
SAG_T_INV = 0.02;        % Inverter processing delay (20ms)

%% Suryashakthi 1 Solar Farm 
SS1_S_nom = 1.2e6; % 12.6 MVA Solar Park
SS1_H = 0.0;       % ZERO physical inertia 

% Inverter & Measurement Dynamics 
SS1_T_INV = 0.02;        % Inverter processing delay (20ms)

%% Suryashakthi 2 Solar Farm 
SS2_S_nom = 1.2e6; % 12.6 MVA Solar Park
SS2_H = 0.0;       % ZERO physical inertia 

% Inverter & Measurement Dynamics 
SS2_T_INV = 0.02;        % Inverter processing delay (20ms)


%% Ambewela Aitken Spence Wind Farm Parameters
AMB_Unit_S_nom = 3e6;   % 3 MVA Wind Park
AMB_H = 0.0;             % ZERO physical inertia
AMB_T_INV = 0.05;        % Inverter processing delay (50ms)

%% Madurankuliya Wind Farm Parameters
MADK_Unit_S_nom = 12e6;   % 12 MVA Wind Park
MADK_H = 0.0;             % ZERO physical inertia
MADU_T_INV = 0.05;        % Inverter processing delay (50ms)

%% Mampuri I Wind Farm Parameters
MAM1_Unit_S_nom = 10e6;   % 10 MVA Wind Park
MAM1_H = 0.0;             % ZERO physical inertia
MAM1_T_INV = 0.05;        % Inverter processing delay (50ms)

%% Mampuri II Wind Farm Parameters
MAM2_Unit_S_nom = 10e6;   % 10 MVA Wind Park
MAM2_H = 0.0;             % ZERO physical inertia
MAM2_T_INV = 0.05;        % Inverter processing delay (50ms)

%% Mampuri III Wind Farm Parameters
MAM3_Unit_S_nom = 10e6;   % 10 MVA Wind Park
MAM3_H = 0.0;             % ZERO physical inertia
MAM3_T_INV = 0.05;        % Inverter processing delay (50ms)

%% Naladanavi Wind Farm Parameters
NAL_Unit_S_nom = 4.8e6;   % 4.8 MVA Wind Park
NAL_H = 0.0;             % ZERO physical inertia
NAL_T_INV = 0.05;        % Inverter processing delay (50ms)

%% Nirmalapura Wind Farm Parameters
NIR_Unit_S_nom = 10.5e6;   % 10.5 MVA Wind Park
NIR_H = 0.0;             % ZERO physical inertia
NIR_T_INV = 0.05;        % Inverter processing delay (50ms)

%% Pawan Danavi Wind Farm Parameters
PWD_Unit_S_nom = 10.2e6;   % 10.2 MVA Wind Park
PWD_H = 0.0;             % ZERO physical inertia
PWD_T_INV = 0.05;        % Inverter processing delay (50ms)

%% Pollupalai Wind Farm Parameters
POLW_Unit_S_nom = 12e6;   % 12 MVA Wind Park
POLW_H = 0.0;             % ZERO physical inertia
POLW_T_INV = 0.05;        % Inverter processing delay (50ms)

%% Segawantivu Wind Farm Parameters
SEG_Unit_S_nom = 9.6e6;   % 10 MVA Wind Park
SEG_H = 0.0;             % ZERO physical inertia
SEG_T_INV = 0.05;        % Inverter processing delay (50ms)

%% Vallimunai Wind Farm Parameters
VALL_Unit_S_nom = 12e6;   % 10 MVA Wind Park
VALL_H = 0.0;             % ZERO physical inertia
VALL_T_INV = 0.05;        % Inverter processing delay (50ms)

%% Vidatamunai Wind Farm Parameters
VID_Unit_S_nom = 10.4e6;   % 10 MVA Wind Park
VID_H = 0.0;             % ZERO physical inertia
VID_T_INV = 0.05;        % Inverter processing delay (50ms)

%% Will Wind Farm Parameters
WILL_Unit_S_nom = 0.85e6;   % 10 MVA Wind Park
WILL_H = 0.0;             % ZERO physical inertia
WILL_T_INV = 0.05;        % Inverter processing delay (50ms)

%% Windscape Wind Farm Parameters
WSC_Unit_S_nom = 20e6;   % 10 MVA Wind Park
WSC_H = 0.0;             % ZERO physical inertia
WSC_T_INV = 0.05;        % Inverter processing delay (50ms)



%% Anuththara 

%% Victoria Power Station (Francis - Hydro)
VIC_Unit_S_nom = 70e6;    % 70 MVA per unit (3 units total)
VIC_H = 3.5;              % High inertia for large vertical Francis units
VIC_R_P = 0.05;           % 5% Permanent Droop
% Hydro Turbine Dynamics
VIC_T_R = 5.0;            % Temporary droop reset time
VIC_R_T = 0.38;           % Temporary droop constant
VIC_T_W = 1.2;            % Water starting time


%% Kotmale Power Station (Francis - Hydro)
KOT_Unit_S_nom = 67e6;    % 67 MVA per unit (3 units total)
KOT_H = 3.5;              
KOT_R_P = 0.05;
% Hydro Turbine Dynamics
KOT_T_R = 5.0;
KOT_R_T = 0.38;
KOT_T_W = 1.1;            % Slightly shorter penstock delay than Victoria



%% Upper Kotmale Power Station (Francis - Hydro)
UKT_Unit_S_nom = 83e6;    % 83 MVA per unit (2 units total)
UKT_H = 4.0;              % Larger units typically have higher relative inertia
UKT_R_P = 0.05;
% Hydro Turbine Dynamics
UKT_T_R = 5.0;
UKT_R_T = 0.40;
UKT_T_W = 1.4;            % High head leads to higher water inertia



%% Sapugaskanda Power Station
SAP_R = 0.04;          % 4% Droop
SAP_T_ACT = 0.1;       % Fast Actuator & Combustion Delay (s)

% Station A (4 Units - 20 MVA each)
SAP_A_Unit_S_nom = 20e6; 
SAP_A_H = 2.0;         %

% Station B (8 Units - 10 MVA each)
SAP_B_Unit_S_nom = 10e6; 
SAP_B_H = 1.8;         % Slightly lower inertia for smaller units[cite: 1]

%% Colombo Port Barge
BAR_Unit_S_nom = 15e6;   % 15 MW per unit (4 units total)
BAR_H = 2.5;             % Two-stroke engines often have higher rotational mass
BAR_R = 0.04;
BAR_T_ACT = 0.1;

%% Aggregated Forecasted Solar PV Farm (IBR)
AGG_SOL_S_nom = 980e6;   % 920 MVA Forecasted Capacity
AGG_SOL_H = 0.0;         % ZERO physical inertia (Decoupled by inverters)
AGG_SOL_R = inf;        % inf Droop (Active Power Control)
AGG_SOL_T_INV = 0.02;    % Inverter processing delay (Extremely fast 20ms)


%% ========================================================================
% Plese leave the below section in below in order to omit the running
% conflicts and when you add the plant just update the Plant_S_nom and
% Plant_H array
% Define your plants in a specific order.
% Index Order: [Lakvijaya 1, Lakvijaya 2, Lakvijaya 3, Mahaweli, Kelanitissa]

% Index Order: [LAK1, LAK2, LAK3, SAM1, SAM2, SOBA_GT, SOBA_ST]
Plant_S_nom = [LAK_S_nom, LAK_S_nom, LAK_S_nom , ...
    SAM_Unit_S_nom , SAM_Unit_S_nom, ...
    KEL_UNIT1_S_nom,KEL_UNIT1_S_nom,KEL_UNIT1_S_nom,KEL_UNIT1_S_nom,KEL_UNIT2_S_nom, KEL_UNIT3_S_nom , ... 
    UTH_Unit_S_nom,UTH_Unit_S_nom,UTH_Unit_S_nom, ... 
    RAN_Unit_S_nom,RAN_Unit_S_nom, ...
    RTB_Unit_S_nom,RTB_Unit_S_nom, ... 
    BWT_Unit_S_nom, ... 
    UKU_Unit_S_nom,UKU_Unit_S_nom, ...
    MAN_Unit_S_nom, ...
    AMB_Unit_S_nom, ...
    MADK_Unit_S_nom, ...
    MAD_Unit_S_nom, ...
    MAM1_Unit_S_nom,...
    MAM2_Unit_S_nom,...
    MAM3_Unit_S_nom,...
    NAL_Unit_S_nom, ...
    NIR_Unit_S_nom, ...
    PWD_Unit_S_nom, ...
    POLW_Unit_S_nom,...
    SEG_Unit_S_nom,...
    VALL_Unit_S_nom,...
    VID_Unit_S_nom,...
    WILL_Unit_S_nom ,...
    WSC_Unit_S_nom,...
    LAU_Unit_S_nom,...
    SOC_S_nom, ...
    HBT_S_nom, ...
    SAG_S_nom, ...
    SS1_S_nom, ...
    SS2_S_nom , ...
    SOBA_GT_S_nom, SOBA_ST_S_nom, ...
    YUGA_GT_S_nom, YUGA_GT_S_nom, YUGA_ST_S_nom, ...
    NLX_Unit_S_nom,NLX_Unit_S_nom, ...
    POL_Unit_S_nom, POL_Unit_S_nom,...
    UPP_Unit_S_nom, ...
    CAN_Unit_S_nom,CAN_Unit_S_nom, ...
    WIM_Unit_S_nom, WIM_Unit_S_nom, ...
    OLX_Unit_S_nom_1, OLX_Unit_S_nom_1, OLX_Unit_S_nom_2, OLX_Unit_S_nom_2, OLX_Unit_S_nom_2, ...
    BRO_Unit_S_nom, BRO_Unit_S_nom, ...
    UMA_Unit_S_nom, UMA_Unit_S_nom, ...
    KUK_Unit_S_nom,KUK_Unit_S_nom, ...
    VIC_Unit_S_nom, VIC_Unit_S_nom, VIC_Unit_S_nom, ...
    KOT_Unit_S_nom, KOT_Unit_S_nom, KOT_Unit_S_nom, ...
    UKT_Unit_S_nom, UKT_Unit_S_nom, ...
    SAP_A_Unit_S_nom, SAP_A_Unit_S_nom, SAP_A_Unit_S_nom, SAP_A_Unit_S_nom,SAP_B_Unit_S_nom, SAP_B_Unit_S_nom, SAP_B_Unit_S_nom, SAP_B_Unit_S_nom,SAP_B_Unit_S_nom, SAP_B_Unit_S_nom, SAP_B_Unit_S_nom, SAP_B_Unit_S_nom, ...
    BAR_Unit_S_nom, BAR_Unit_S_nom, BAR_Unit_S_nom, BAR_Unit_S_nom,...
    AGG_SOL_S_nom,...           %Aggregated Solar
    ];    




    Plant_H     = [LAK_H,   LAK_H,   LAK_H, ...
        SAM_H, SAM_H, ...
        KEL_U1_H,KEL_U1_H,KEL_U1_H,KEL_U1_H,KEL_U1_H,KEL_CC_H, ...
        UTH_H, UTH_H ,UTH_H, ...
        RAN_H,RAN_H , ...
        RTB_H, RTB_H, ...
        BWT_H, ...
        UKU_H,UKU_H, ...
        MAN_H, ...
        AMB_H, ...
        MADK_H, ...
        MAD_H, ...
        MAM1_H,...
        MAM2_H,...
        MAM3_H,...
        NAL_H, ...
        NIR_H, ...
        PWD_H,...
        POLW_H,...
        SEG_H,...
        VALL_H,...
        VID_H, ...
        WILL_H,...
        WSC_H,...
        LAU_H, ...
        SOC_H, ...
        HBT_H, ...
        SAG_H, ...
        SS1_H, ...
        SS2_H, ...
        SOBA_GT_H, SOBA_ST_H, ...
        YUGA_GT_H, YUGA_GT_H,YUGA_ST_H, ... 
        NLX_H,NLX_H, ...
        POL_H, POL_H, ...
        UPP_H, ...
        CAN_H,CAN_H, ...
        WIM_H, WIM_H, ...
        OLX_H_1, OLX_H_1, OLX_H_2, OLX_H_2, OLX_H_2, ...
        BRO_H, BRO_H, ...
        UMA_H, UMA_H, ...
        KUK_H,KUK_H, ...
        VIC_H, VIC_H, VIC_H, ...
        KOT_H, KOT_H, KOT_H, ...
        UKT_H, UKT_H, ...
        SAP_A_H, SAP_A_H, SAP_A_H, SAP_A_H, SAP_B_H, SAP_B_H, SAP_B_H, SAP_B_H,SAP_B_H, SAP_B_H, SAP_B_H, SAP_B_H, ...
        BAR_H, BAR_H, BAR_H, BAR_H,...
        AGG_SOL_H, ...          %Aggregated Solar
        ]; 


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ========================================================================
%% FUTUREGRID-SL: AUTOMATIC DISPATCH INITIALIZATION (2500 MW PEAK)
%% ========================================================================

Load_pu = 2388.8 / 1000; % Sets the pu load based on the 10:15 graph total
% --- 1. Thermal Coal (Total = 0.2568) ---
K_LAK   = 0.0668;   % Lakvijaya (UNCHANGED)
% --- 2. Thermal Oil / Gas / CCGT (Total = 0.1417) ---
% All thermal load shifted to Sobadhanavi to reduce active machines
K_SOBA1 = 0.0017/2; % Sobadhanavi GT
K_SOBA2 = 0.1317/2; % Sobadhanavi ST
K_YUGA1 = 0.1000;   % Yugadhanavi GT (Turned OFF)
K_YUGA2 = 0.0000;   % Yugadhanavi ST (Turned OFF)
K_KEL1  = 0.0000;   % Kelanitissa GTs (Turned OFF)
K_KEL2  = 0.0000;   % Kelanitissa CCGT Gas (Turned OFF)
K_KEL3  = 0.0000;   % Kelanitissa CCGT Steam (Turned OFF)
K_SAP1  = 0.0813;   % Sapugaskanda Station A (Turned OFF)
K_SAP2  = 0.0000;   % Sapugaskanda Station B (Turned OFF)
K_UTH   = 0.0000;   % Uthuru Janani (Standby)
K_BAR   = 0.1000;   % Colombo Port Barge (Standby)
% --- 3. Hydro Complexes (Total = 0.1680) ---
% All hydro load shifted to Victoria and Kotmale to reduce active machines
K_VIC   = 0.0850;   % Victoria
K_KOT   = 0.0830;   % Kotmale
K_SAM   = 0.0000;   % Samanalawewa (Turned OFF)
K_NLX   = 0.0000;   % New Laxapana (Turned OFF)
K_UMA   = 0.000;   % Uma Oya (Turned OFF)
K_RAN   = 0.5000;   % Randenigala (Standby)
K_RTB   = 0.0000;   % Rantambe (Standby)
K_BWT   = 0.0000;   % Bowatenna (Standby)
K_UKU   = 0.0000;   % Ukuwela (Standby)
K_POL   = 0.0000;   % Polpitiya (Standby)
K_CAN   = 0.0000;   % Canyon (Standby)
K_WIM   = 0.0000;   % Wimalasurendra (Standby)
K_BRO   = 0.0000;   % Broadlands (Standby)
K_KUK   = 0.0000;   % Kukuleganga (Standby)
K_UKT   = 0.0000;   % Upper Kotmale (Standby)
K_OLX1  = 0.0000;   % Old Laxapana 1 (Standby)
K_OLX2  = 0.0000;   % Old Laxapana 2 (Standby)
% --- 4. Solar IBR (Total = 0.4320) ---
% Forecasted Solar (UNCHANGED)
K_AGG_SOL = 0.0; % Aggregated Solar Block
% Existing Solar
K_MAD   = 0.0307;   % Maduru Oya
K_LAU   = 0.0100;   % Laugfs Hambantota
K_SOC   = 0.0100;   % Solar One Ceylon
K_HBT   = 0.0000;  
K_SAG   = 0.0000;  
K_SS1   = 0.0000;  
K_SS2   = 0.0000;
% --- 5. Wind IBR (Total = 0.0015) ---
K_MAN   = 0.0015;   % Mannar Thambapavani
K_AMB   = 0.0000;
K_MADK  = 0.0000;
K_UPP   = 0.0000;  
K_MAM1  = 0.0000;
K_MAM2  = 0.0000;
K_MAM3  = 0.0000;
K_NAL   = 0.0000;
K_NIR   = 0.0000;
K_PWD   = 0.0000;
K_POLW  = 0.0000;
K_SEG   = 0.0000;
K_VALL  = 0.0000;   % Vallimunai Wind Farm
K_VID   = 0.0000;   % Vidatamunai Wind Farm
K_WILL  = 0.0000;   % Will Wind Farm
K_WSC   = 0.0000;   % Windscape Wind Farm




%% =============================================================================

% --- 3. Calculate Local Reference Setpoints (Pref) ---
% Formula: (Global Load pu * K) * (System Base / Total Plant Base)

% Thermal Coal
Pref_Set_LAK  = (Load_pu * K_LAK)  * (S_base_sys / (3 * LAK_S_nom));

% Thermal Oil / CCGT
% Note: By applying the same pu setpoint to both GT and ST, the power naturally 
% splits 2:1 in MW based on their respective MVA bases!
Pref_Set_YUGA1 = (Load_pu * K_YUGA1) * (S_base_sys / (2*YUGA_GT_S_nom));
Pref_Set_YUGA2 = (Load_pu * K_YUGA2) * (S_base_sys / (YUGA_ST_S_nom));

Pref_Set_KEL1  = (Load_pu * K_KEL1)  * (S_base_sys / (4*KEL_UNIT1_S_nom));
Pref_Set_KEL2 = (Load_pu * K_KEL2)  * (S_base_sys / (KEL_UNIT2_S_nom ));
Pref_Set_KEL3 = (Load_pu * K_KEL3)  * (S_base_sys / (KEL_UNIT3_S_nom));


Pref_Set_SAP_A  = (Load_pu * K_SAP1)  * (S_base_sys / (4*SAP_A_Unit_S_nom ));
Pref_Set_SAP_B  = (Load_pu * K_SAP2)  * (S_base_sys / (8*SAP_B_Unit_S_nom));

Pref_Set_SOBA1 = (Load_pu * K_SOBA1) * (S_base_sys / (SOBA_GT_S_nom));
Pref_Set_SOBA2 = (Load_pu * K_SOBA2) * (S_base_sys / (SOBA_ST_S_nom ));

% Hydro
Pref_Set_VIC  = (Load_pu * K_VIC)  * (S_base_sys / (3 * VIC_Unit_S_nom));
Pref_Set_KOT  = (Load_pu * K_KOT)  * (S_base_sys / (3 * KOT_Unit_S_nom));
Pref_Set_SAM  = (Load_pu * K_SAM)  * (S_base_sys / (2 * SAM_Unit_S_nom));
Pref_Set_NLX  = (Load_pu * K_NLX)  * (S_base_sys / (2 * NLX_Unit_S_nom));
Pref_Set_UMA  = (Load_pu * K_UMA)  * (S_base_sys / (2 * UMA_Unit_S_nom));

% Inverter-Based Resources (Solar & Wind)
Pref_Set_MAD  = (Load_pu * K_MAD)  * (S_base_sys / MAD_Unit_S_nom);
Pref_Set_LAU  = (Load_pu * K_LAU)  * (S_base_sys / LAU_Unit_S_nom);
Pref_Set_SOC  = (Load_pu * K_SOC)  * (S_base_sys / SOC_S_nom);
Pref_Set_MAN  = (Load_pu * K_MAN)  * (S_base_sys / MAN_Unit_S_nom);
Pref_Set_HBT  = (Load_pu * K_HBT)  * (S_base_sys / HBT_S_nom);
Pref_Set_SAG  = (Load_pu * K_SAG)  * (S_base_sys / SAG_S_nom);
Pref_Set_SS1  = (Load_pu * K_SS1)  * (S_base_sys / SS1_S_nom);
Pref_Set_SS2  = (Load_pu * K_SS2)  * (S_base_sys / SS2_S_nom);

Pref_Set_AGG_SOL = (Load_pu * K_AGG_SOL)  * (S_base_sys / AGG_SOL_S_nom);





% Wind IBR
Pref_Set_UPP = (Load_pu * K_UPP) * (S_base_sys / UPP_Unit_S_nom);
Pref_Set_AMB = (Load_pu * K_AMB) * (S_base_sys / AMB_Unit_S_nom);
Pref_Set_MADK = (Load_pu * K_MADK) * (S_base_sys / AMB_Unit_S_nom);
Pref_Set_MAM1 = (Load_pu * K_MAM1) * (S_base_sys / MAM1_Unit_S_nom);
Pref_Set_MAM2 = (Load_pu * K_MAM2) * (S_base_sys / MAM2_Unit_S_nom);
Pref_Set_MAM3 = (Load_pu * K_MAM3) * (S_base_sys / MAM3_Unit_S_nom);
Pref_Set_NAL  = (Load_pu * K_NAL) * (S_base_sys / NAL_Unit_S_nom);
Pref_Set_NIR  = (Load_pu * K_NIR) * (S_base_sys / NIR_Unit_S_nom);
Pref_Set_PWD  = (Load_pu * K_PWD) * (S_base_sys / PWD_Unit_S_nom);
Pref_Set_POLW  = (Load_pu * K_POLW) * (S_base_sys / POLW_Unit_S_nom);
Pref_Set_SEG  = (Load_pu * K_SEG) * (S_base_sys / SEG_Unit_S_nom);
Pref_Set_VALL = (Load_pu * K_VALL) * (S_base_sys / VALL_Unit_S_nom);
Pref_Set_VID  = (Load_pu * K_VID)  * (S_base_sys / VID_Unit_S_nom);
Pref_Set_WILL = (Load_pu * K_WILL) * (S_base_sys / WILL_Unit_S_nom);
Pref_Set_WSC  = (Load_pu * K_WSC)  * (S_base_sys / WSC_Unit_S_nom);


% --- 4. Standby/Idle Plants (Dynamic Equations) ---
% These will automatically output 0 MW as long as their 'K' values are set to 0.000.
% If you change their K values > 0, they will seamlessly dispatch!

% Thermal / Oil
Pref_Set_UTH = (Load_pu * K_UTH) * (S_base_sys / (3 * UTH_Unit_S_nom));
Pref_Set_BAR = (Load_pu * K_BAR) * (S_base_sys / (4 * BAR_Unit_S_nom));

% Hydro Complexes
Pref_Set_RAN = (Load_pu * K_RAN) * (S_base_sys / (2 * RAN_Unit_S_nom));
Pref_Set_RTB = (Load_pu * K_RTB) * (S_base_sys / (2 * RTB_Unit_S_nom));
Pref_Set_BWT = (Load_pu * K_BWT) * (S_base_sys / (1 * BWT_Unit_S_nom)); % Only 1 unit
Pref_Set_UKU = (Load_pu * K_UKU) * (S_base_sys / (2 * UKU_Unit_S_nom));
Pref_Set_POL = (Load_pu * K_POL) * (S_base_sys / (2 * POL_Unit_S_nom));
Pref_Set_CAN = (Load_pu * K_CAN) * (S_base_sys / (2 * CAN_Unit_S_nom));
Pref_Set_WIM = (Load_pu * K_WIM) * (S_base_sys / (2 * WIM_Unit_S_nom));
Pref_Set_BRO = (Load_pu * K_BRO) * (S_base_sys / (2 * BRO_Unit_S_nom));
Pref_Set_KUK = (Load_pu * K_KUK) * (S_base_sys / (2 * KUK_Unit_S_nom));
Pref_Set_UKT = (Load_pu * K_UKT) * (S_base_sys / (2 * UKT_Unit_S_nom));

% Old Laxapana (Split into the two different turbine sizes)
% Note: Make sure you define K_OLX1 and K_OLX2 in your participation factors!
Pref_Set_OLX1 = (Load_pu * K_OLX1) * (S_base_sys / (2 * OLX_Unit_S_nom_1));
Pref_Set_OLX2 = (Load_pu * K_OLX2) * (S_base_sys / (3 * OLX_Unit_S_nom_2));



%% ========================================================================
% Define your plants in a specific order... 
% [Keep your existing Plant_S_nom and Plant_H arrays exactly as they are here]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ========================================================================
%% FUTUREGRID-SL: DYNAMIC INERTIA CALCULATOR (ONLY CONNECTED PLANTS)
%% ========================================================================

% 1. Create a matching array of the Setpoints (Pref_Set) 
% (This perfectly matches the 74 elements in your Plant_S_nom and Plant_H arrays)
Plant_Pref = [ ...
    Pref_Set_LAK, Pref_Set_LAK, Pref_Set_LAK, ... % Lakvijaya
    Pref_Set_SAM, Pref_Set_SAM, ...               % Samanalawewa
    Pref_Set_KEL1, Pref_Set_KEL1, Pref_Set_KEL1, Pref_Set_KEL1, Pref_Set_KEL2, Pref_Set_KEL3, ...             % Kelanitissa 
    Pref_Set_UTH, Pref_Set_UTH, Pref_Set_UTH, ... % Uthuru Janani
    Pref_Set_RAN, Pref_Set_RAN, ...               % Randenigala
    Pref_Set_RTB, Pref_Set_RTB, ...               % Rantambe
    Pref_Set_BWT, ...                             % Bowatenna
    Pref_Set_UKU, Pref_Set_UKU, ...               % Ukuwela
    Pref_Set_MAN, ...
    Pref_Set_AMB ,...
    Pref_Set_MADK,...
    Pref_Set_MAD, ...
    Pref_Set_MAM1,...
    Pref_Set_MAM2,...
    Pref_Set_MAM3,...
    Pref_Set_NAL, ...
    Pref_Set_NIR, ...
    Pref_Set_PWD,...
    Pref_Set_POLW, ...
    Pref_Set_SEG,...
    Pref_Set_VALL,...
    Pref_Set_VID,...
    Pref_Set_WILL,...
    Pref_Set_WSC,...
    Pref_Set_LAU, ...
    Pref_Set_SOC, ...                              % SOC
    Pref_Set_HBT, ...
    Pref_Set_SAG, ...
    Pref_Set_SS1, ...
    Pref_Set_SS2, ...
    Pref_Set_SOBA1, Pref_Set_SOBA2, ...           % Sobadhanavi
    Pref_Set_YUGA1, Pref_Set_YUGA1, Pref_Set_YUGA2, ... % Yugadhanavi
    Pref_Set_NLX, Pref_Set_NLX, ...               % New Laxapana
    Pref_Set_POL, Pref_Set_POL, ...               % Polpitiya
    Pref_Set_UPP, ...                              % Uppudaluwa
    Pref_Set_CAN,  Pref_Set_CAN, ...               % Canyon 
    Pref_Set_WIM, Pref_Set_WIM, ...               % Wimalasurendra
    Pref_Set_OLX1, Pref_Set_OLX1, Pref_Set_OLX2, Pref_Set_OLX2, Pref_Set_OLX2, ...                            % Old Laxapana (No Pref_Set assigned)
    Pref_Set_BRO, Pref_Set_BRO, ...               % Broadlands
    Pref_Set_UMA, Pref_Set_UMA, ...               % Uma Oya
    Pref_Set_KUK, Pref_Set_KUK, ...               % Kukuleganga
    Pref_Set_VIC, Pref_Set_VIC, Pref_Set_VIC, ... % Victoria
    Pref_Set_KOT, Pref_Set_KOT, Pref_Set_KOT, ... % Kotmale
    Pref_Set_UKT, Pref_Set_UKT, ...               % Upper Kotmale
    Pref_Set_SAP_A, Pref_Set_SAP_A, Pref_Set_SAP_A, Pref_Set_SAP_A, Pref_Set_SAP_B, Pref_Set_SAP_B, Pref_Set_SAP_B, Pref_Set_SAP_B, Pref_Set_SAP_B, Pref_Set_SAP_B, Pref_Set_SAP_B, Pref_Set_SAP_B, ... % Sapugaskanda 
    Pref_Set_BAR, Pref_Set_BAR, Pref_Set_BAR, Pref_Set_BAR ...          % Colombo Port Barge
    Pref_Set_AGG_SOL, ...           %Aggregated Solar
];

% 2. The Binary Multiplier (Logical Array)
% Returns '1' if the plant is dispatched (>0 MW), Returns '0' if it is idle.
Plant_Status = (Plant_Pref > 0);

% 3. Calculate the New Dynamic Equivalent Inertia
H_eq = sum(Plant_H .* Plant_S_nom .* Plant_Status) / S_base_sys;

% 4. Print to Command Window to verify
disp('====================================================');
disp(['Dynamic System Inertia (H_eq) = ', num2str(H_eq), ' seconds']);
disp('====================================================');







