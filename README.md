# ⚙️ Digital Logic Accelerator (RTL to GDSII)

A high-performance, Verilog-based hardware accelerator designed to efficiently execute core digital logic operations using FPGA and ASIC design methodologies. This project was implemented as part of the 21ECP302L – Project course under the Department of ECE, SRM Institute of Science and Technology.

---

## 🧠 Project Overview

The **Digital Logic Accelerator (DLA)** offloads compute-intensive logic operations like AND, OR, XOR, and NAND from the CPU to specialized reconfigurable hardware. Designed with modularity and pipelined parallelism, it provides ultra-fast performance in real-time systems like AI inference, cryptography, and embedded edge computing.

- RTL designed using Verilog
- FPGA synthesis via Xilinx Vivado 2023.2
- ASIC flow verified via Synopsys DC & ICC II using SAED 32nm PDK
- Modular and pipelined architecture
- Support for runtime logic reconfiguration

---

## 📂 Project Structure

| Folder        | Description                                 |
|---------------|---------------------------------------------|
| `RTL/`        | Verilog HDL for Sobel-based accelerator     |
| `Testbench/`  | Testbench code for simulation               |
| `Waveforms/`  | Simulation waveform screenshots (optional)  |
| `Reports/`    | Power, timing, area analysis (DC & ICC)     |
| `GDSII/`      | Layout and physical design images           |
| `README.md`   | You are here 📘                             |

---

## 🔧 Tools Used

| Tool                | Purpose                                  |
|---------------------|------------------------------------------|
| **Vivado 2023.2**   | RTL design, simulation, synthesis (FPGA) |
| **DC Shell**        | RTL-to-Gate Synthesis (ASIC)             |
| **ICC II**          | Floorplanning, CTS, Placement, Routing   |
| **Verdi**           | RTL-level waveform & schematic viewing   |
| **GTKWave**         | Optional waveform viewing (testbench)    |

---

## 📈 Design Methodology

- Line-buffer and 3×3 window design for Sobel edge detection
- Gx/Gy calculation via signed logic
- Pipeline stages for continuous dataflow
- Valid signal for streaming synchronization
- Clamping logic to fit output to 8-bit grayscale

---

## 🔍 Results Summary

| Metric       | DC Shell                  | ICC Shell                  |
|--------------|---------------------------|----------------------------|
| Area         | 3498.83 nm²               | N/A (disabled in ICC)      |
| Power        | 151.83 µW                 | 66.4 µW (6.64e+10 pW)      |
| Max Delay    | Default (1 GHz)           | Default (1 GHz)            |
| Cell Count   | 6718                      | 6401                       |

---
