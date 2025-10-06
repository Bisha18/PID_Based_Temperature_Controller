# Smart PID-Based Temperature Control Simulation

## Project Overview
This project simulates a **PID (Proportional-Integral-Derivative) controller** for controlling the output of a system (e.g., temperature control, DC motor speed) using **MATLAB**. The purpose of this project is to demonstrate **control system design, feedback control, and system performance optimization** purely through software simulation.

---

## Features
- Simulates multiple **plant models** (second-order thermal systems, motor systems)
- Tests multiple **PID gain sets** for each plant
- Plots **step response** and **error signal** for each case
- Compares **P, PI, PD, and PID controllers**
- Calculates **performance metrics**: Rise Time, Settling Time, Overshoot, Steady-State Error

---

## Tools Used
| Tool/Software          | Purpose                                 |
|------------------------|-----------------------------------------|
| MATLAB                 | Main simulation and coding              |
| Control System Toolbox | PID design, feedback, step response     |
| VS Code (optional)     | Code editing and GitHub integration     |

---

## How to Run
1. Install **MATLAB** (R2018 or newer recommended)  
2. Open `PID_Temperature_Control.m` in MATLAB  
3. Run the script to generate:
   - Step response plots for all plants and gain sets
   - Error signal plots
   - Console output with performance metrics
4. Optional: Modify **PID gains** or **plant models** in the script to experiment with different scenarios


---

## Observations
- **PID controller** gives the **best response**: fast rise time, minimal overshoot, zero steady-state error.  
- **P-only controller** reacts fast but may overshoot.  
- **PI controller** eliminates steady-state error but may be slower.  
- **PD controller** reduces overshoot but cannot remove steady-state error.  

---

## Author
**Bishal Paul** – ECE Student

- GitHub: [https://github.com/Bisha18/PID_Controller](#)
- Email: d.bishalpaul@gmail.com

