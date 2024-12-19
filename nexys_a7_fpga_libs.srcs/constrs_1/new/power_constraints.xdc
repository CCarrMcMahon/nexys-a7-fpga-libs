########################################################################################################################
## @file power_constraints.xdc
##
## @brief This file defines the power constraints for the FPGA project.
##
## Detailed Description:
## This XDC (Xilinx Design Constraints) file specifies the power-related constraints for the FPGA project. These
## constraints include voltage levels, current limits, and other power management settings required for optimal
## performance and reliability of the design.
##
## Key Commands:
## - **set_operating_conditions**: Used to define various operating conditions including voltage levels, current
## limits, and power budgets for the design.
##
## Revision History:
## - v1.0: Initial release.
##
## License Info:
## This file is provided under the MIT license. Please review the terms and conditions before use.
##
## Author: Christopher McMahon
## Date: 12/19/2024
########################################################################################################################

# Power Supply Constraints
set_operating_conditions -voltage {Vccint 1.000}
set_operating_conditions -voltage {Vccaux 1.800}
set_operating_conditions -voltage {Vcco33 3.300}
set_operating_conditions -voltage {Vcco25 2.500}
set_operating_conditions -voltage {Vcco18 1.800}
set_operating_conditions -voltage {Vcco15 1.500}
set_operating_conditions -voltage {Vcco135 1.350}
set_operating_conditions -voltage {Vcco12 1.200}
set_operating_conditions -voltage {Vccaux_io 1.800}
set_operating_conditions -voltage {Vccbram 1.000}
set_operating_conditions -voltage {MGTAVcc 1.000}
set_operating_conditions -voltage {MGTAVtt 1.200}
set_operating_conditions -voltage {Vccadc 1.800}

# Power Budget Constraints
set_operating_conditions -design_power_budget 5.0

# Current Limit Constraints
set_operating_conditions -supply_current_budget {Vccint 2.500}
set_operating_conditions -supply_current_budget {Vccaux 0.500}
set_operating_conditions -supply_current_budget {Vcco33 0.500}
set_operating_conditions -supply_current_budget {Vcco25 0.500}
set_operating_conditions -supply_current_budget {Vcco18 0.500}
set_operating_conditions -supply_current_budget {Vcco15 0.500}
set_operating_conditions -supply_current_budget {Vcco135 0.500}
set_operating_conditions -supply_current_budget {Vcco12 0.500}
set_operating_conditions -supply_current_budget {Vccaux_io 0.200}
set_operating_conditions -supply_current_budget {Vccbram 1.500}
set_operating_conditions -supply_current_budget {MGTAVcc 0.900}
set_operating_conditions -supply_current_budget {MGTAVtt 0.300}
set_operating_conditions -supply_current_budget {Vccadc 0.100}
