# FutureGrid-SL: Reduced-Order Dynamic Model of Sri Lanka’s Power System

![Status](https://img.shields.io/badge/Status-Finalized-success)
![Platform](https://img.shields.io/badge/Platform-MATLAB%20%2F%20Simulink-blue)
![Grid Base](https://img.shields.io/badge/System%20Base-1000%20MVA-orange)

## Project Overview
**FutureGrid-SL** is an advanced, deviation-based (small-signal) dynamic Simulink model developed to study the frequency stability of the Sri Lankan national grid. Built as a Final Year Project for the B.Sc. Engineering (Honors) degree at the University of Ruhuna, this digital twin accurately simulates the real-time kinematic and thermodynamic responses of the country's power generation mix during major load disturbances.

The model successfully integrates **47 parallel generation units**, capturing the complex dynamics of thermal delays, hydro penstock water-hammer effects, and renewable energy synthetic inertia.

## Key Technical Specifications
The model is anchored by the following verified grid parameters:
* **System Base (S_base_sys):** 1000 MVA
* **Nominal Frequency (f_base):** 50 Hz
* **Master System Equivalent Inertia (H_eq):** 9.700 seconds
* **Kundur's Load Damping Constant (D):** 1.5 (1.5% load drop per 1% frequency drop)

## Generation Portfolio
The model features mathematically rigorous transfer functions for the following plants:

### 1. Thermal Base & Peaking Units
* **Lakvijaya Coal Power Plant:** 3x300 MW (Standard reheat steam turbine dynamics).
* **Kelanitissa Complex:** 165 MW CCGT (Precise 67/33 GT/ST thermodynamic split with 10.0s HRSG delay), GT-7 (115 MW), and Frame 5 OCGTs (4x20 MW).
* **Sobadhanavi & Yugadhanavi CCGTs:** Fully integrated Combined Cycle Gas Turbines.
* **Uthuru Janani:** 3x8 MW fast-acting diesel peaking units (0.1s actuator delay).

### 2. Hydroelectric Cascades & Run-of-River
Features non-minimum phase penstock delays (water starting times) and transient droop dashpot governors.
* **Mahaweli Cascade:** Samanalawewa, Randenigala, Rantambe, Bowatenna, Ukuwela.
* **Laxapana Complex:** New Laxapana, Old Laxapana, Polpitiya, Canyon, Wimalasurendra, Broadlands.
* **Independent Hydro:** Uma Oya, Kukuleganga.

### 3. Renewable Integration
* **Thambapavani (Mannar) Wind Farm:** 100 MW Type 4 Full-Converter integration featuring **Synthetic Inertia / Fast Frequency Response (FFR)** with derivative control and a 20ms PLL measurement filter.

## Repository Structure
* `Sri_Lanka_FINAL.m` - The master MATLAB initialization script. Contains all concatenated generation arrays, inertia calculations, and governor time-constant parameters.
* `Sri_Lanka_S_FINAL.slx` - The master Simulink block diagram containing the 47 parallel feedback loops, the Swing Equation grid block, and the load disturbance inputs.

## Usage Instructions
1. Clone the repository to your local machine.
2. Open MATLAB and navigate to the project directory.
3. **Crucial Step:** Run `Sri_Lanka_FINAL.m` in the command window first. This loads the master variables (like `H_eq` and the plant arrays) into the MATLAB workspace.
4. Open `Sri_Lanka_S_FINAL.slx` in Simulink.
5. To test grid stability, configure the `Load Disturbance (ΔPL)` Step Block:
   * **Small-Signal Test:** Set final value to `0.05` p.u. (50 MW step).
   * **N-1 Contingency (Lakvijaya Trip):** Set final value to `0.30` p.u. (300 MW loss of generation).
6. Run the simulation (Recommended stop time: 30 seconds) and open the main Scope to view the time-domain frequency deviation ($\Delta\omega$).

## Project Team
* **Agampodige Helan Sanjeewa** - Thermal Base, Mahaweli Cascade & Wind FFR Integration
* **Dinitha** - CCGT Expansion (Sobadhanavi/Yugadhanavi) & Laxapana Models
* **Nayanajith** - National Hydro Expansion & Run-of-River Integration
* **Anuththara** - Scope Simulations, Scenario Testing & Data Analysis
