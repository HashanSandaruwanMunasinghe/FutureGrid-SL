FutureGrid-SL
Reduced-Order Dynamic Model of Sri Lanka’s Power System for Frequency Stability Studies

Project Overview
FutureGrid-SL is an advanced mathematical and computational model designed to investigate and solve frequency stability issues in the Sri Lankan power grid. As the grid transitions toward higher penetrations of Inverter-Based Resources (IBR) like solar and wind, system inertia inherently decreases, making the grid vulnerable to high Rates of Change of Frequency (RoCoF) and deep frequency Nadirs during disturbances.

By utilizing a linearized transfer-function approach derived from the classic Swing Equation, this project successfully models the primary frequency response of the entire national grid.

Key Achievements
Extreme Computational Efficiency: The developed transfer-function model is up to 5,700x faster than standard Electromagnetic Transient (EMT) models for reheat generators, simulating a 120-second dynamic event in just fractions of a second.

High-Fidelity Accuracy: Despite the massive reduction in computational load, the model tracks standard EMT frequency Nadirs with a microscopic error margin of just 0.005%, and steady-state errors below 0.005 Hz.

Real-World Application: Fully capable of simulating severe load steps (e.g., sudden Electric Vehicle charging spikes) across different daily grid dispatch profiles.

Model Scope & Architecture
The model accurately represents the modern Sri Lankan power system using 92 dynamic dispatch blocks. It captures the distinct dynamic behaviors (droop, inertia, governor delays, and turbine time constants) of:

47 Diverse Power Stations across the island.

75 Synchronous Generators:

16 Hydro Power Plants (36 physical units)

7 Thermal Power Plants (39 physical units, including Coal, Oil, and CCGT)

24 Inverter-Based Resources (IBR):

17 Wind Power Farms

7 Solar Power Parks (including forecasted distributed solar)

Simulated Dispatch Scenarios
The repository contains initialization scripts to test the grid under three distinct physical states based on real daily load profiles:

Morning High Inertia (06:00): Highly distributed thermal and hydro dispatch.

Daytime Low Inertia (10:15): Massive aggregated solar penetration covering nearly 40% of the load, forcing heavy rotating machines offline and dropping system inertia dangerously low.

Evening Peak (19:00): Maximum system stress requiring near-total conventional thermal and hydro dispatch.

Getting Started
Prerequisites:

MATLAB (R2023a or newer recommended)

Simulink

Control System Toolbox

Usage:

Clone the repository to your local machine.

Open MATLAB and navigate to the Scripts folder.

Run your desired scenario initialization script (e.g., Init_1015_Low_Inertia.m) to load the plant participation factors and time constants into the Workspace.

Open FutureGrid_Main.slx in Simulink and execute the run.

Use the Plot_Frequency_Curves.m script to visualize the output data.

Project Team
This project is conducted as a final year undergraduate B.Sc. Engineering (Hons) research project.

A.M.A.H. Sandaruwan

H.D.R.N. De Silva

R.D.L. Rathnayaka

K.A. Sandamini

Supervisor: Mr. A.S. Mudalige
