# DMA Controller Design in Verilog

---

## Overview
This project implements a synthesizable Direct Memory Access (DMA) Controller using Verilog HDL.
The DMA transfers data between memory locations without continuous CPU intervention.

---

## Features
- Memory-to-memory DMA transfer
- FSM-based control logic
- Register interface (SAR, DAR, LENGTH, CONTROL, STATUS)
- Valid/Ready handshake
- Fully verified using a Verilog testbench

---

## Architecture
- DMA Top Module
- FSM Controller
- Register Block
- Bus Master Interface
- Memory Model

---

## Tools Used
- Verilog HDL
- ModelSim (Simulation)
- RTL FSM Design

---

## How to Run Simulation
1. Compile all RTL files from `/rtl`
2. Compile memory model and testbench
3. Run `dma_tb.v`
4. Observe waveforms and output logs

---
© 2025 Aryan Sengar – All Rights Reserved  
Unauthorized copying is strictly prohibited.
---

> 💬 *Feel free to drop a ⭐ if you find this helpful!*
**Aryan Sengar**  
B.Tech CSE | RTL Design & Verilog
