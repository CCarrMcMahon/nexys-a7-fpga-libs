# Nexys A7 FPGA Libraries

A collection of libraries for the Nexys A7 Board which features the XC7A100T-1CSG324C FPGA.

## Table of Contents

-   [Overview](#overview)
-   [Features](#features)
-   [Getting Started](#getting-started)
-   [Usage](#usage)
-   [License](#license)

## Overview

This repository contains a wide variety of FPGA libraries for the Nexys A7 Board. These range from protocol implementations to display drivers, audio interfaces, and more.

## Features

-   **Modularized Codebase:** Organized into various modules for different functionalities.

## Getting Started

To get started with the `nexys-a7-fpga-libs` project, follow these steps:

1. Clone the repository:

    ```bash
    git clone git@github.com:CCarrMcMahon/nexys-a7-fpga-libs.git
    ```

2. Open the project in Vivado:

-   **Method 1**: Open Vivado Design Suite, then navitage to `File > Open Project` and select the `nexys_a7_fpga_libs.xpr` file.
-   **Method 2**: Navigate to the cloned repository and double-click the `nexys_a7_fpga_libs.xpr` file to open it directly in vivado.

3. For detailed instructions, see the [Getting Started Guide](docs/getting_started.md)

## Usage

### Building the Project

1. Open the Vivado project.
2. Synthesize and implement your design.
3. Generate the bitstream.
4. Program the Nexys A7 board with the generated bitstream.

### Simulation

1. Navigate to the `nexys_a7_fpga_libs.srcs/sim_1/` directory.
2. Run the provided simulation scripts to verify your design.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
