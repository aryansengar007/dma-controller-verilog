<div align="center">

<!-- ╔══════════════════════════════════════════════════════════════╗ -->
<!--                   ANIMATED WAVE HEADER                         -->
<!-- ╚══════════════════════════════════════════════════════════════╝ -->

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:0a0a0a,40:0f1923,80:1e3a4f,100:0e7490&height=220&section=header&text=DMA%20Controller%20Design&fontSize=46&fontColor=ffffff&fontAlignY=38&desc=Verilog%20HDL%20%7C%20FSM%20%7C%20RTL%20Design%20%7C%20ModelSim&descSize=17&descAlignY=60&animation=fadeIn" width="100%"/>

<!-- ╔══════════════════════════════════════════════════════════════╗ -->
<!--                  ANIMATED TYPING TAGLINE                       -->
<!-- ╚══════════════════════════════════════════════════════════════╝ -->

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=20&duration=2800&pause=900&color=22D3EE&center=true&vCenter=true&width=720&lines=Synthesizable+DMA+Controller+in+Verilog+HDL+%F0%9F%94%A7;Memory-to-Memory+Transfer+without+CPU+%F0%9F%92%BE;FSM-Based+Control+Logic+%2B+Register+Interface;SAR+%7C+DAR+%7C+LENGTH+%7C+CONTROL+%7C+STATUS+Regs;Fully+Verified+with+Verilog+Testbench+%E2%9C%85" alt="Typing SVG"/>

<br/>

<!-- CTA BUTTONS -->
[![GitHub Repo](https://img.shields.io/badge/💻%20Source%20Code-GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/aryansengar007/DMA-Controller-Verilog)

<br/>

<!-- ANIMATED SKILL ICONS -->
<img src="https://skillicons.dev/icons?i=git&theme=dark&perline=1" />

<br/><br/>

![Verilog](https://img.shields.io/badge/Verilog-HDL-0e7490?style=flat-square)
![ModelSim](https://img.shields.io/badge/ModelSim-Simulation-1e3a4f?style=flat-square)
![FSM](https://img.shields.io/badge/Design-FSM%20Based-22d3ee?style=flat-square)
![RTL](https://img.shields.io/badge/RTL-Synthesizable-06b6d4?style=flat-square)
![Testbench](https://img.shields.io/badge/Verified-Testbench-10b981?style=flat-square)

</div>

<br/>

<!-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ WAVE DIVIDER ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ -->
<img src="https://capsule-render.vercel.app/api?type=rect&color=gradient&customColorList=0,2,4,8,20&height=2" width="100%"/>

<br/>

## 🔌 Overview

A **synthesizable Direct Memory Access (DMA) Controller** implemented in **Verilog HDL**. The controller manages memory-to-memory data transfers autonomously — without continuous CPU intervention — using a clean **FSM-based control architecture** and a register interface.

> ⚙️ Fully verified using a dedicated Verilog testbench with waveform and log-based validation in ModelSim.

<br/>

<div align="center">

| 💾 Transfer | 🔄 Control | 📋 Interface | ✅ Verification |
|:---:|:---:|:---:|:---:|
| Memory-to-memory | FSM-based logic | Register block | Verilog testbench |

</div>

<br/>

<!-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ WAVE DIVIDER ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ -->
<img src="https://capsule-render.vercel.app/api?type=rect&color=gradient&customColorList=0,2,4,8,20&height=2" width="100%"/>

<br/>

## ✨ Features

<br/>

| 🔧 Core Functionality | 📋 Register Interface | ✅ Verification |
|:---|:---|:---|
| Memory-to-memory DMA transfer | `SAR` — Source Address Register | Fully verified Verilog testbench |
| FSM-based control logic | `DAR` — Destination Address Register | Waveform & output log validation |
| Valid/Ready handshake protocol | `LENGTH` — Transfer length control | ModelSim simulation |
| CPU-free autonomous data transfer | `CONTROL` — Start/config register | Synthesizable RTL design |
| — | `STATUS` — Transfer status register | — |

<br/>

<!-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ WAVE DIVIDER ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ -->
<img src="https://capsule-render.vercel.app/api?type=rect&color=gradient&customColorList=0,2,4,8,20&height=2" width="100%"/>

<br/>

## 🏗️ Architecture

<br/>

```
╔══════════════════════════════════════════════════════╗
║                  DMA Top Module                      ║
╠══════════════╦═══════════════╦═══════════════════════╣
║ FSM          ║ Register      ║ Bus Master            ║
║ Controller   ║ Block         ║ Interface             ║
║              ║               ║                       ║
║ IDLE         ║ SAR           ║ Valid/Ready           ║
║ FETCH        ║ DAR           ║ Handshake             ║
║ TRANSFER     ║ LENGTH        ║                       ║
║ DONE         ║ CONTROL       ║                       ║
║              ║ STATUS        ║                       ║
╠══════════════╩═══════════════╩═══════════════════════╣
║                  Memory Model                        ║
║           (Source & Destination Blocks)              ║
╚══════════════════════════════════════════════════════╝
```

<br/>

### 🔄 FSM State Flow

```
  IDLE ──► FETCH ──► TRANSFER ──► DONE
    ▲                               │
    └───────────────────────────────┘
         (reset or new transfer)
```

<br/>

<!-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ WAVE DIVIDER ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ -->
<img src="https://capsule-render.vercel.app/api?type=rect&color=gradient&customColorList=0,2,4,8,20&height=2" width="100%"/>

<br/>

## 🛠️ Tools Used

<br/>

<div align="center">

| Tool | Purpose |
|:---:|:---|
| 🔷 **Verilog HDL** | RTL design & implementation language |
| 🖥️ **ModelSim** | Simulation, waveform analysis & output log verification |
| 📐 **RTL FSM Design** | Finite State Machine-based controller architecture |

</div>

<br/>

<!-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ WAVE DIVIDER ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ -->
<img src="https://capsule-render.vercel.app/api?type=rect&color=gradient&customColorList=0,2,4,8,20&height=2" width="100%"/>

<br/>

## ▶️ How to Run Simulation

**1. Compile all RTL source files**

```bash
# Compile RTL modules from /rtl directory
vlog rtl/dma_top.v rtl/dma_fsm.v rtl/dma_registers.v rtl/bus_master.v
```

**2. Compile memory model and testbench**

```bash
vlog tb/memory_model.v tb/dma_tb.v
```

**3. Run the simulation**

```bash
vsim dma_tb
run -all
```

**4. Observe output**

- 📈 View **waveforms** in ModelSim Wave window
- 📄 Review **output logs** in the transcript console

<br/>

<!-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ WAVE DIVIDER ━━━━━━━━━━━━━━━━━━━━━━━━━━━━ -->
<img src="https://capsule-render.vercel.app/api?type=rect&color=gradient&customColorList=0,2,4,8,20&height=2" width="100%"/>

<br/>

## 👨‍💻 Author

<div align="center">

### Aryan Sengar

💻 RTL Design & Verilog &nbsp;|&nbsp; 📍 Gurgaon, India

<br/>

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/aryan-sengar-786b96290/)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/aryansengar007)

</div>

<br/>

<!-- ╔══════════════════════════════════════════════════════════════╗ -->
<!--                   ANIMATED WAVE FOOTER                         -->
<!-- ╚══════════════════════════════════════════════════════════════╝ -->

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:0a0a0a,40:0f1923,80:1e3a4f,100:0e7490&height=130&section=footer&animation=fadeIn" width="100%"/>

<div align="center">

© 2025 **Aryan Sengar** — All Rights Reserved. Unauthorized copying is strictly prohibited.

<br/>

*If you found this project helpful, consider leaving a* ⭐ *— it means a lot!*

</div>
