########################################################################################################################
## @file clock_constraints.xdc
##
## @brief This file defines the clock constraints for the FPGA project.
##
## Detailed Description:
## This XDC (Xilinx Design Constraints) file specifies the clock constraints for the FPGA project. These constraints
## include defining primary clock frequencies, creating generated clocks, and setting clock groups to ensure proper
## timing analysis and optimization during implementation.
##
## Key Commands:
## - **create_clock**: Defines the primary clock with its frequency and other parameters.
## - **create_generated_clock**: Creates derived clocks based on the primary clocks, specifying their relationships.
## - **set_clock_groups**: Sets groups of clocks to handle multi-clock domain designs correctly.
##
## Revision History:
## - v1.0: Initial release.
##
## License Info:
## This file is provided under the [Your License Name Here]. Please review the terms and conditions before use.
##
## Author: [Your Name]
## Date: [Current Date]
########################################################################################################################

# Primary Clock
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk100mhz]
