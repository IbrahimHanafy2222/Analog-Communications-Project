# 📡 Analog Communications Project – CIE 337 (Spring 2025)

This repository contains the implementation of **DSB-QAM** and **Angle Modulation** using MATLAB, developed as part of **CIE 337 – Analog Communications Project**.

---

## 📌 Project Overview

### Part A: DSB-QAM
- Generate the message signals m1(t) and m2(t).
- Generate the modulated signal s(t) using a carrier of amplitude 5 V and frequency 5 kHz.
- Implement a QAM receiver to extract both m1(t) and m2(t).
- Repeat the extraction if the receiver carrier has:
  - a phase offset of pi/3
  - a frequency offset of 0.02 * fc

### Part B: Angle Modulation
- Generate the message signals m1(t) and m2(t).
- Implement Phase Modulation (PM):  
  - Carrier: amplitude 1 V, frequency 10 kHz  
  - Test values of Kp = 0.05, 1, 5, 10  
- Implement Frequency Modulation (FM):  
  - Carrier: amplitude 1 V, frequency 10 kHz  
  - Case 1: FM with message m2(t), Kf = 1000  
  - Case 2: FM with message m1(t), Kf = 2000  

---

## 🧪 Deliverables
- MATLAB source codes (`.m` files) for Part A and Part B.
- Report (`.pdf`) including:
  - Properly labeled/titled figures.
  - Comments and observations.

---

## 📂 Repository Structure

```text
.
├── Part A - DSB QAM/
│   ├── PartA.m              # MATLAB script for DSB-QAM
│   ├── m1_plot.fig
│   ├── m2_plot.fig
│   ├── receiver_output.fig
│   └── ...                  # Other plots/results
│
├── Part B - Angle Modulation/
│   ├── PartB.m              # MATLAB script for Angle Modulation
│   ├── pm_kp_0_05.fig
│   └── ...                  # Other plots/results
│
├── Report.pdf               # Final project report
└── README.md                # Project documentation
