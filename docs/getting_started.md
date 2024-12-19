# Getting Started

This guide will walk you through the process of setting up the `nexys-a7-fpga-template` project and getting started with FPGA development on the Nexys A7 Board.

## Prerequisites

Before you begin, ensure you have the following tools installed:

-   [Vivado Design Suite](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools.html) installed on your computer.
-   [MinGW-w64](https://www.mingw-w64.org/) (for GCC):
    -   **Manual Installation**:
        -   Download and install [MinGW-w64](https://www.mingw-w64.org/downloads/).
    -   **Automatic Installation**:
        -   Download [MinGW-W64 online installer](https://github.com/niXman/mingw-builds-binaries) from the README.
        -   Run executable as Admin and choose `C:/Program Files/` as your directory.
    -   Add the MinGW-w64 bin folder (e.g., `C:/Program Files/mingw64/bin/`) to your system's PATH environment variable.
    -   Create a new Environmental Variable called `GCC_SIM_EXE_PATH` and set the value to the same directory as above.
    -   Verify the installation by opening a Command Prompt and typing `gcc --version`.
-   If using [VSCode](https://code.visualstudio.com/):
    -   Install the recommended workspace extensions.
    -   Install [verible](https://github.com/chipsalliance/verible) and place the binaries in `C:/Program Files/verible`.

## Installation

Follow these steps to set up the project on your local machine:

1. Clone the repository:

```bash
git clone git@github.com:CCarrMcMahon/nexys-a7-fpga-template.git
```

2. Open the project in Vivado:

-   **Method 1**: Open Vivado Design Suite, then navitage to `File > Open Project` and select the `nexys_a7_fpga_template.xpr` file.
-   **Method 2**: Navigate to the cloned repository and double-click the `nexys_a7_fpga_template.xpr` file to open it directly in vivado.

## Project Structure

Here's an overview of the key directories and files in this template, following the default Vivado directory structure:

```
nexys_a7_fpga_template/
├── docs/
│   └── getting_started.md
├── nexys_a7_fpga_template.runs/
│   ├── impl_1/
│   │   └── nexys_a7_fpga_template.bit
│   └── synth_1/
├── nexys_a7_fpga_template.srcs/
│   ├── constrs_1/
│   ├── sim_1/
│   └── sources_1/
├── nexys_a7_fpga_template.xpr
```

-   `docs/`: Documentation files.
-   `runs/`: Holds the output of synthesis and implementation processes.
    -   `impl_1/`: Contains the results of the implementation process, which maps the netlist onto the FPGA fabric and includes placement and routing information.
        -   `nexys_a7_fpga_template.bit`: The bitstream file used to program the FPGA.
    -   `synth_1/`: Contains the results of the synthesis process, which converts HDL code into a netlist.
-   `srcs/`: Contains various source files for the FPGA.
    -   `constrs_1/`: Includes constraint files for the Nexys A7 board.
    -   `sim_1/`: Contains simulation files and testbenches.
    -   `sources_1/`: Contains the source files for your FPGA design.
-   `nexys_a7_fpga_template.xpr`: Vivado project file.

## Building and Programming

### Synthesize and Implement

1. Open the Vivado project.
2. In the Flow Navigator, click on `Run Synthesis`.
3. After synthesis completes, click on `Run Implementation`.
4. Review and address any design rule violations or warnings.

### Generate Bitstream

1. Once implementation completes, click on `Generate Bitstream`.
2. After the bitstream generation is complete, click on `Open Hardware Manager`.

### Program the Board

1. Connect your Nexys A7 board to your computer via USB.
2. In the Hardware Manager, click on `Auto Connect` to connect to the board.
3. Select the generated bitstream file (`*.bit`) and click on `Program Device`.

## Running Simulations

To verify your design, you can run simulations using the provided testbenches:

1. Navigate to the `nexys_a7_fpga_tempalte/srcs/sim_1/` directory.
2. Use the provided simulation scripts to run the simulations and analyze the results.
