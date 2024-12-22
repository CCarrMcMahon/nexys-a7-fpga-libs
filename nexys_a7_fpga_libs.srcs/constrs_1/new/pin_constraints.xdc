########################################################################################################################
## @file pin_constraints.xdc
##
## @brief This file defines the pin constraints for the FPGA project.
##
## Detailed Description:
## This XDC (Xilinx Design Constraints) file specifies the pin assignments and constraints for the FPGA project. These
## constraints include mapping FPGA pins to external signals, setting I/O standards, drive strengths, slew rates, and
## other pin-related settings required for the design.
##
## Key Properties:
## - **PACKAGE_PIN**: Specifies the physical pin on the FPGA package.
## - **IOSTANDARD**: Defines the I/O standard (e.g., LVCMOS33, SSTL18) to ensure proper voltage levels and interface
##   compatibility.
## - **DRIVE**: Sets the drive strength (e.g., 12mA, 16mA) for the output buffer, which affects the ability to drive
##   different load capacitances.
## - **SLEW**: Specifies the slew rate (e.g., FAST, SLOW) of the output signal, influencing the transition time and
##   reducing potential signal integrity issues.
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

#### Oscillators / Clocks ####
### DSC1033CC1-100.0000T: 3.3V PureSilicon Oscillator
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports clk100mhz]

#### Buttons ####
### PTA-142 Red Knob: 4 Pin Button, SMT
set_property -dict {PACKAGE_PIN C12 IOSTANDARD LVCMOS33} [get_ports cpu_resetn]

### PTA-142: 4 Pin Button, SMT
# set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports {btnu}];  # IO_L4N_T0_D05_14
# set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports {btnl}];  # IO_L12P_T1_MRCC_14
set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS33} [get_ports {btnc}];  # IO_L9P_T1_DQS_14
# set_property -dict {PACKAGE_PIN M17 IOSTANDARD LVCMOS33} [get_ports {btnr}];  # IO_L10N_T1_D15_14
# set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS33} [get_ports {btnd}];  # IO_L9N_T1_DQS_D13_14

#### Slide Switches ####
### SWITCH: SPDT, Thru Hole, Slide Switch
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports {sw[0]}]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports {sw[1]}]
set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [get_ports {sw[2]}]
set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [get_ports {sw[3]}]
set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33} [get_ports {sw[4]}]
set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports {sw[5]}]
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {sw[6]}]
set_property -dict {PACKAGE_PIN R13 IOSTANDARD LVCMOS33} [get_ports {sw[7]}]
set_property -dict {PACKAGE_PIN T8 IOSTANDARD LVCMOS18} [get_ports {sw[8]}]
set_property -dict {PACKAGE_PIN U8 IOSTANDARD LVCMOS18} [get_ports {sw[9]}]
set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS33} [get_ports {sw[10]}]
set_property -dict {PACKAGE_PIN T13 IOSTANDARD LVCMOS33} [get_ports {sw[11]}]
set_property -dict {PACKAGE_PIN H6 IOSTANDARD LVCMOS33} [get_ports {sw[12]}]
set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS33} [get_ports {sw[13]}]
set_property -dict {PACKAGE_PIN U11 IOSTANDARD LVCMOS33} [get_ports {sw[14]}]
set_property -dict {PACKAGE_PIN V10 IOSTANDARD LVCMOS33} [get_ports {sw[15]}]

#### LEDs ####
### Highbright: Generic LED
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports {led[0]}]
set_property -dict {PACKAGE_PIN K15 IOSTANDARD LVCMOS33} [get_ports {led[1]}]
set_property -dict {PACKAGE_PIN J13 IOSTANDARD LVCMOS33} [get_ports {led[2]}]
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [get_ports {led[3]}]
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports {led[4]}]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {led[5]}]
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {led[6]}]
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {led[7]}]
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {led[8]}]
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports {led[9]}]
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports {led[10]}]
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS33} [get_ports {led[11]}]
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports {led[12]}]
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports {led[13]}]
set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports {led[14]}]
set_property -dict {PACKAGE_PIN V11 IOSTANDARD LVCMOS33} [get_ports {led[15]}]

#### Tri-Color LED ####
### VS NRD8: Tri color chip LED
# set_property -dict {PACKAGE_PIN N15 IOSTANDARD LVCMOS33} [get_ports {led16_r}];  # IO_L11P_T1_SRCC_14
# set_property -dict {PACKAGE_PIN M16 IOSTANDARD LVCMOS33} [get_ports {led16_g}];  # IO_L10P_T1_D14_14
# set_property -dict {PACKAGE_PIN R12 IOSTANDARD LVCMOS33} [get_ports {led16_b}];  # IO_L5P_T0_D06_14
# set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports {led16_r}];  # IO_L11N_T1_SRCC_14
# set_property -dict {PACKAGE_PIN R11 IOSTANDARD LVCMOS33} [get_ports {led16_g}];  # IO_0_14
# set_property -dict {PACKAGE_PIN G14 IOSTANDARD LVCMOS33} [get_ports {led16_b}];  # IO_L15N_T2_DQS_ADV_B_15

#### Seven-Segment Display ####
### KW4-281ASB: 4 Digit, 12 Pins, Common Anode, 7 Segment Display, Red
## Anodes
# set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports {an[0]}];  # IO_L23P_T3_FOE_B_15
# set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports {an[1]}];  # IO_L23N_T3_FWE_B_15
# set_property -dict {PACKAGE_PIN T9 IOSTANDARD LVCMOS33} [get_ports {an[2]}];  # IO_L24P_T3_A01_D17_14
# set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports {an[3]}];  # IO_L19P_T3_A22_15
# set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {an[4]}];  # IO_L8N_T1_D12_14
# set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports {an[5]}];  # IO_L14P_T2_SRCC_14
# set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports {an[6]}];  # IO_L23P_T3_35
# set_property -dict {PACKAGE_PIN U13 IOSTANDARD LVCMOS33} [get_ports {an[7]}];  # IO_L23N_T3_A02_D18_14

## Cathodes
# set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports {ca}];  # IO_L24N_T3_A00_D16_14
# set_property -dict {PACKAGE_PIN R10 IOSTANDARD LVCMOS33} [get_ports {cb}];  # IO_25_14
# set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports {cc}];  # IO_25_15
# set_property -dict {PACKAGE_PIN K13 IOSTANDARD LVCMOS33} [get_ports {cd}];  # IO_L17P_T2_A26_15
# set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports {ce}];  # IO_L13P_T2_MRCC_14
# set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports {cf}];  # IO_L19P_T3_A10_D26_14
# set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS33} [get_ports {cg}];  # IO_L4P_T0_D04_14
# set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports {dp}];  # IO_L19N_T3_A21_VREF_15

#### Pmod Ports ####
### PMOD-2x6-S: Pmod System Board Header 2x6, 100mil spaced
## JA
set_property -dict {PACKAGE_PIN C17 IOSTANDARD LVCMOS33} [get_ports {ja[0]}];  # IO_L20N_T3_A19_15
set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports {ja[1]}];  # IO_L21N_T3_DQS_A18_15
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports {ja[2]}];  # IO_L21P_T3_DQS_15
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports {ja[3]}];  # IO_L18N_T2_A23_15
# set_property -dict {PACKAGE_PIN D17 IOSTANDARD LVCMOS33} [get_ports {ja[4]}];  # IO_L16N_T2_A27_15
# set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS33} [get_ports {ja[5]}];  # IO_L16P_T2_A28_15
# set_property -dict {PACKAGE_PIN F18 IOSTANDARD LVCMOS33} [get_ports {ja[6]}];  # IO_L22N_T3_A16_15
# set_property -dict {PACKAGE_PIN G18 IOSTANDARD LVCMOS33} [get_ports {ja[7]}];  # IO_L22P_T3_A17_15

## JB
# set_property -dict {PACKAGE_PIN D14 IOSTANDARD LVCMOS33} [get_ports {jb[0]}];  # IO_L1P_T0_AD0P_15
# set_property -dict {PACKAGE_PIN F16 IOSTANDARD LVCMOS33} [get_ports {jb[1]}];  # IO_L14N_T2_SRCC_15
# set_property -dict {PACKAGE_PIN G16 IOSTANDARD LVCMOS33} [get_ports {jb[2]}];  # IO_L13N_T2_MRCC_15
# set_property -dict {PACKAGE_PIN H14 IOSTANDARD LVCMOS33} [get_ports {jb[3]}];  # IO_L15P_T2_DQS_15
# set_property -dict {PACKAGE_PIN E16 IOSTANDARD LVCMOS33} [get_ports {jb[4]}];  # IO_L11N_T1_SRCC_15
# set_property -dict {PACKAGE_PIN F13 IOSTANDARD LVCMOS33} [get_ports {jb[5]}];  # IO_L5P_T0_AD9P_15
# set_property -dict {PACKAGE_PIN G13 IOSTANDARD LVCMOS33} [get_ports {jb[6]}];  # IO_0_15
# set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports {jb[7]}];  # IO_L13P_T2_MRCC_15

## JC
# set_property -dict {PACKAGE_PIN K1 IOSTANDARD LVCMOS33} [get_ports {jc[0]}];  # IO_L23N_T3_35
# set_property -dict {PACKAGE_PIN F6 IOSTANDARD LVCMOS33} [get_ports {jc[1]}];  # IO_L19N_T3_VREF_35
# set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS33} [get_ports {jc[2]}];  # IO_L22N_T3_35
# set_property -dict {PACKAGE_PIN G6 IOSTANDARD LVCMOS33} [get_ports {jc[3]}];  # IO_L19P_T3_35
# set_property -dict {PACKAGE_PIN E7 IOSTANDARD LVCMOS33} [get_ports {jc[4]}];  # IO_L6P_T0_35
# set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports {jc[5]}];  # IO_L22P_T3_35
# set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS33} [get_ports {jc[6]}];  # IO_L21P_T3_DQS_35
# set_property -dict {PACKAGE_PIN E6 IOSTANDARD LVCMOS33} [get_ports {jc[7]}];  # IO_L5P_T0_AD13P_35

## JD
# set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS33} [get_ports {jd[0]}];  # IO_L21N_T3_DQS_35
# set_property -dict {PACKAGE_PIN H1 IOSTANDARD LVCMOS33} [get_ports {jd[1]}];  # IO_L17P_T2_35
# set_property -dict {PACKAGE_PIN G1 IOSTANDARD LVCMOS33} [get_ports {jd[2]}];  # IO_L17N_T2_35
# set_property -dict {PACKAGE_PIN G3 IOSTANDARD LVCMOS33} [get_ports {jd[3]}];  # IO_L20N_T3_35
# set_property -dict {PACKAGE_PIN H2 IOSTANDARD LVCMOS33} [get_ports {jd[4]}];  # IO_L15P_T2_DQS_35
# set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVCMOS33} [get_ports {jd[5]}];  # IO_L20P_T3_35
# set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVCMOS33} [get_ports {jd[6]}];  # IO_L15N_T2_DQS_35
# set_property -dict {PACKAGE_PIN F3 IOSTANDARD LVCMOS33} [get_ports {jd[7]}];  # IO_L13N_T2_MRCC_35

## JXADC
# set_property -dict {PACKAGE_PIN A14 IOSTANDARD LVCMOS33} [get_ports {xa_n[0]}];  # IO_L9N_T1_DQS_AD3N_15
# set_property -dict {PACKAGE_PIN A13 IOSTANDARD LVCMOS33} [get_ports {xa_p[0]}];  # IO_L9P_T1_DQS_AD3P_15
# set_property -dict {PACKAGE_PIN A16 IOSTANDARD LVCMOS33} [get_ports {xa_n[1]}];  # IO_L8N_T1_AD10N_15
# set_property -dict {PACKAGE_PIN A15 IOSTANDARD LVCMOS33} [get_ports {xa_p[1]}];  # IO_L8P_T1_AD10P_15
# set_property -dict {PACKAGE_PIN B17 IOSTANDARD LVCMOS33} [get_ports {xa_n[2]}];  # IO_L7N_T1_AD2N_15
# set_property -dict {PACKAGE_PIN B16 IOSTANDARD LVCMOS33} [get_ports {xa_p[2]}];  # IO_L7P_T1_AD2P_15
# set_property -dict {PACKAGE_PIN A18 IOSTANDARD LVCMOS33} [get_ports {xa_n[3]}];  # IO_L10N_T1_AD11N_15
# set_property -dict {PACKAGE_PIN B18 IOSTANDARD LVCMOS33} [get_ports {xa_p[3]}];  # IO_L10P_T1_AD11P_15

#### USB-UART Bridge (Serial Port) ####
### FT2232HQ: 1 Channel USB to serial UART interface
# set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVCMOS33} [get_ports {uart_txd_in}];  # IO_L7P_T1_AD6P_35
# set_property -dict {PACKAGE_PIN D4 IOSTANDARD LVCMOS33} [get_ports {uart_rxd_out}];  # IO_L11N_T1_SRCC_35
# set_property -dict {PACKAGE_PIN D3 IOSTANDARD LVCMOS33} [get_ports {uart_cts}];  # IO_L12N_T1_MRCC_35
# set_property -dict {PACKAGE_PIN E5 IOSTANDARD LVCMOS33} [get_ports {uart_rts}];  # IO_L5N_T0_AD13N_35

#### Accelerometer ####
### ADXL362BCCZ: 3 Axis, 2/4/8 Digital Output MEMS Accelerometer
# set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports {acl_mosi}];  # IO_L5N_T0_AD9N_15
# set_property -dict {PACKAGE_PIN E15 IOSTANDARD LVCMOS33} [get_ports {acl_miso}];  # IO_L11P_T1_SRCC_15
# set_property -dict {PACKAGE_PIN F15 IOSTANDARD LVCMOS33} [get_ports {acl_sclk}];  # IO_L14P_T2_SRCC_15
# set_property -dict {PACKAGE_PIN D15 IOSTANDARD LVCMOS33} [get_ports {acl_csn}];  # IO_L12P_T1_MRCC_15
# set_property -dict {PACKAGE_PIN B13 IOSTANDARD LVCMOS33} [get_ports {acl_int[0]}];  # IO_L2P_T0_AD8P_15
# set_property -dict {PACKAGE_PIN C16 IOSTANDARD LVCMOS33} [get_ports {acl_int[1]}];  # IO_L20P_T3_A20_15

#### Temperature Sensor ####
### ADT7420UCPZ: +-25degC Accurate, 16-Bit Digital I2C Temperature Sensor
# set_property -dict {PACKAGE_PIN C14 IOSTANDARD LVCMOS33} [get_ports {tmp_scl}];  # IO_L1N_T0_AD0N_15
# set_property -dict {PACKAGE_PIN C15 IOSTANDARD LVCMOS33} [get_ports {tmp_sda}];  # IO_L12N_T1_MRCC_15
# set_property -dict {PACKAGE_PIN D13 IOSTANDARD LVCMOS33} [get_ports {tmp_int}];  # IO_L6N_T0_VREF_15
# set_property -dict {PACKAGE_PIN B14 IOSTANDARD LVCMOS33} [get_ports {tmp_ct}];  # IO_L2N_T0_AD8N_15

#### Microphone ####
### SPK0833LM4H: Omnidirectional Microphone with Bottom Port and Digital Output
# set_property -dict {PACKAGE_PIN J5 IOSTANDARD LVCMOS33} [get_ports {m_clk}];  # IO_25_35
# set_property -dict {PACKAGE_PIN H5 IOSTANDARD LVCMOS33} [get_ports {m_data}];  # IO_L24N_T3_35
# set_property -dict {PACKAGE_PIN F5 IOSTANDARD LVCMOS33} [get_ports {m_lrsel}];  # IO_0_35

#### PWM Audio Amplifier ####
### Sallen-Key Butterworth Low-pass 4th Order Filter
# set_property -dict {PACKAGE_PIN A11 IOSTANDARD LVCMOS33} [get_ports {aud_pwm}];  # IO_L4N_T0_15
# set_property -dict {PACKAGE_PIN D12 IOSTANDARD LVCMOS33} [get_ports {aud_sd}];  # IO_L6P_T0_15

#### Quad-SPI Flash ####
### S25FL128SAGNFI00: Serial Flash Memory, 128Mbit, Low Voltage, 133MHz SPI Bus Interface
### S25FL127SABMFx00x: Serial Flash Memory, 128Mbit, Low Voltage, 108MHz SPI Bus Interface
# set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS33} [get_ports {qspi_dq[0]}];  # IO_L1P_T0_D00_MOSI_14
# set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVCMOS33} [get_ports {qspi_dq[1]}];  # IO_L1N_T0_D01_DIN_14
# set_property -dict {PACKAGE_PIN L14 IOSTANDARD LVCMOS33} [get_ports {qspi_dq[2]}];  # IO_L2P_T0_D02_14
# set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports {qspi_dq[3]}];  # IO_L2N_T0_D03_14
# set_property -dict {PACKAGE_PIN L13 IOSTANDARD LVCMOS33} [get_ports {qspi_csn}];  # IO_L6P_T0_FCS_B_14

#### MicroSD Slot ####
### microSD-CSD-11-xxxxx: Push-Push, Bottom board mounting micro SD connector
# set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports {sd_dat[0]}];  # IO_L16P_T2_35
# set_property -dict {PACKAGE_PIN E1 IOSTANDARD LVCMOS33} [get_ports {sd_dat[1]}];  # IO_L18N_T2_35
# set_property -dict {PACKAGE_PIN F1 IOSTANDARD LVCMOS33} [get_ports {sd_dat[2]}];  # IO_L18P_T2_35
# set_property -dict {PACKAGE_PIN D2 IOSTANDARD LVCMOS33} [get_ports {sd_dat[3]}];  # IO_L14N_T2_SRCC_35
# set_property -dict {PACKAGE_PIN C1 IOSTANDARD LVCMOS33} [get_ports {sd_cmd}];  # IO_L16N_T2_35
# set_property -dict {PACKAGE_PIN B1 IOSTANDARD LVCMOS33} [get_ports {sd_sck}];  # IO_L9P_T1_DQS_AD7P_35
# set_property -dict {PACKAGE_PIN A1 IOSTANDARD LVCMOS33} [get_ports {sd_cd}];  # IO_L9N_T1_DQS_AD7N_35
# set_property -dict {PACKAGE_PIN E2 IOSTANDARD LVCMOS33} [get_ports {sd_reset}];  # IO_L14P_T2_SRCC_35

#### Ethernet ####
### LAN8720A-CP-TR: 10/100 Ethernet Transceiver with HP Auto-MDIX Support
# set_property -dict {PACKAGE_PIN A10 IOSTANDARD LVCMOS33} [get_ports {eth_txd[0]}];  # IO_L14P_T2_SRCC_16
# set_property -dict {PACKAGE_PIN A8 IOSTANDARD LVCMOS33} [get_ports {eth_txd[1]}];  # IO_L12N_T1_MRCC_16
# set_property -dict {PACKAGE_PIN C11 IOSTANDARD LVCMOS33} [get_ports {eth_rxd[0]}];  # IO_L13P_T2_MRCC_16
# set_property -dict {PACKAGE_PIN D10 IOSTANDARD LVCMOS33} [get_ports {eth_rxd[1]}];  # IO_L19N_T3_VREF_16
# set_property -dict {PACKAGE_PIN D9 IOSTANDARD LVCMOS33} [get_ports {eth_crsdv}];  # IO_L6N_T0_VREF_16
# set_property -dict {PACKAGE_PIN C9 IOSTANDARD LVCMOS33} [get_ports {eth_mdc}];  # IO_L11P_T1_SRCC_16
# set_property -dict {PACKAGE_PIN B9 IOSTANDARD LVCMOS33} [get_ports {eth_txen}];  # IO_L11N_T1_SRCC_16
# set_property -dict {PACKAGE_PIN B8 IOSTANDARD LVCMOS33} [get_ports {eth_intn}];  # IO_L12P_T1_MRCC_16
# set_property -dict {PACKAGE_PIN C10 IOSTANDARD LVCMOS33} [get_ports {eth_rxerr}];  # IO_L13N_T2_MRCC_16
# set_property -dict {PACKAGE_PIN A9 IOSTANDARD LVCMOS33} [get_ports {eth_mdio}];  # IO_L14N_T2_SRCC_16
# set_property -dict {PACKAGE_PIN B3 IOSTANDARD LVCMOS33} [get_ports {eth_rstn}];  # IO_L10P_T1_AD15P_35
# set_property -dict {PACKAGE_PIN D5 IOSTANDARD LVCMOS33} [get_ports {eth_refclk}];  # IO_L11P_T1_SRCC_35

#### USB HID Host ####
### PIC24FJ128GB106-I/MR: General Purpose and USB 16-Bit Flash Microcontroller, 64-Pin
# set_property -dict {PACKAGE_PIN F4 IOSTANDARD LVCMOS33} [get_ports {ps2_clk}];  # IO_L13P_T2_MRCC_35
# set_property -dict {PACKAGE_PIN B2 IOSTANDARD LVCMOS33} [get_ports {ps2_data}];  # IO_L10N_T1_AD15N_35

#### VGA Port ####
### 1-1734530-3: DB15F-HD 15 Pin Edge Connector
# set_property -dict {PACKAGE_PIN A3 IOSTANDARD LVCMOS33} [get_ports {vga_r[0]}];  # IO_L8N_T1_AD14N_35
# set_property -dict {PACKAGE_PIN B4 IOSTANDARD LVCMOS33} [get_ports {vga_r[1]}];  # IO_L7N_T1_AD6N_35
# set_property -dict {PACKAGE_PIN C5 IOSTANDARD LVCMOS33} [get_ports {vga_r[2]}];  # IO_L1N_T0_AD4N_35
# set_property -dict {PACKAGE_PIN A4 IOSTANDARD LVCMOS33} [get_ports {vga_r[3]}];  # IO_L8P_T1_AD14P_35
# set_property -dict {PACKAGE_PIN C6 IOSTANDARD LVCMOS33} [get_ports {vga_g[0]}];  # IO_L1P_T0_AD4P_35
# set_property -dict {PACKAGE_PIN A5 IOSTANDARD LVCMOS33} [get_ports {vga_g[1]}];  # IO_L3N_T0_DQS_AD5N_35
# set_property -dict {PACKAGE_PIN B6 IOSTANDARD LVCMOS33} [get_ports {vga_g[2]}];  # IO_L2N_T0_AD12N_35
# set_property -dict {PACKAGE_PIN A6 IOSTANDARD LVCMOS33} [get_ports {vga_g[3]}];  # IO_L3P_T0_DQS_AD5P_35
# set_property -dict {PACKAGE_PIN B7 IOSTANDARD LVCMOS33} [get_ports {vga_b[0]}];  # IO_L2P_T0_AD12P_35
# set_property -dict {PACKAGE_PIN C7 IOSTANDARD LVCMOS33} [get_ports {vga_b[1]}];  # IO_L4N_T0_35
# set_property -dict {PACKAGE_PIN D7 IOSTANDARD LVCMOS33} [get_ports {vga_b[2]}];  # IO_L6N_T0_VREF_35
# set_property -dict {PACKAGE_PIN D8 IOSTANDARD LVCMOS33} [get_ports {vga_b[3]}];  # IO_L4P_T0_35
# set_property -dict {PACKAGE_PIN B11 IOSTANDARD LVCMOS33} [get_ports {vga_hs}];  # IO_L4P_T0_15
# set_property -dict {PACKAGE_PIN B12 IOSTANDARD LVCMOS33} [get_ports {vga_vs}];  # IO_L3N_T0_DQS_AD1N_15

#### Remaining Pins ####
# set_property -dict {PACKAGE_PIN A2 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN A7 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_35
# set_property -dict {PACKAGE_PIN A12 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN A17 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_15
# set_property -dict {PACKAGE_PIN B5 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN B10 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_16
# set_property -dict {PACKAGE_PIN B15 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN C3 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_35
# set_property -dict {PACKAGE_PIN C8 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN C13 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_15
# set_property -dict {PACKAGE_PIN C18 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN D1 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN D6 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_35
# set_property -dict {PACKAGE_PIN D11 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN D16 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_15
# set_property -dict {PACKAGE_PIN E4 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN E8 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCBATT_0
# set_property -dict {PACKAGE_PIN E9 IOSTANDARD LVCMOS33} [get_ports {}];  # CCLK_0
# set_property -dict {PACKAGE_PIN E10 IOSTANDARD LVCMOS33} [get_ports {}];  # TCK_0
# set_property -dict {PACKAGE_PIN E11 IOSTANDARD LVCMOS33} [get_ports {}];  # TDI_0
# set_property -dict {PACKAGE_PIN E12 IOSTANDARD LVCMOS33} [get_ports {}];  # TMS_0
# set_property -dict {PACKAGE_PIN E13 IOSTANDARD LVCMOS33} [get_ports {}];  # TDO_0
# set_property -dict {PACKAGE_PIN E14 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN F2 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_35
# set_property -dict {PACKAGE_PIN F7 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN F8 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCINT
# set_property -dict {PACKAGE_PIN F9 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN F10 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCBRAM
# set_property -dict {PACKAGE_PIN F11 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN F12 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCAUX
# set_property -dict {PACKAGE_PIN F17 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN G5 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_35
# set_property -dict {PACKAGE_PIN G7 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCINT
# set_property -dict {PACKAGE_PIN G8 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN G9 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCINT
# set_property -dict {PACKAGE_PIN G10 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN G11 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCBRAMA
# set_property -dict {PACKAGE_PIN G12 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN G15 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_15
# set_property -dict {PACKAGE_PIN H3 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN H7 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN H8 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCINT
# set_property -dict {PACKAGE_PIN H9 IOSTANDARD LVCMOS33} [get_ports {}];  # GNDADC_0
# set_property -dict {PACKAGE_PIN H10 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCADC_0
# set_property -dict {PACKAGE_PIN H11 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN H12 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCAUX
# set_property -dict {PACKAGE_PIN H13 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN H18 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_15
# set_property -dict {PACKAGE_PIN J1 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_35
# set_property -dict {PACKAGE_PIN J6 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN J7 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCINT
# set_property -dict {PACKAGE_PIN J8 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN J9 IOSTANDARD LVCMOS33} [get_ports {}];  # VREFN_0
# set_property -dict {PACKAGE_PIN J10 IOSTANDARD LVCMOS33} [get_ports {}];  # VP_0
# set_property -dict {PACKAGE_PIN J11 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCINT
# set_property -dict {PACKAGE_PIN J12 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN J16 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN K3 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L2P_T0_34
# set_property -dict {PACKAGE_PIN K4 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_34
# set_property -dict {PACKAGE_PIN K5 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L5P_T0_34
# set_property -dict {PACKAGE_PIN K6 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_0_34
# set_property -dict {PACKAGE_PIN K7 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN K8 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCINT
# set_property -dict {PACKAGE_PIN K9 IOSTANDARD LVCMOS33} [get_ports {}];  # VN_0
# set_property -dict {PACKAGE_PIN K10 IOSTANDARD LVCMOS33} [get_ports {}];  # VREFP_0
# set_property -dict {PACKAGE_PIN K11 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN K12 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCAUX
# set_property -dict {PACKAGE_PIN K14 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_15
# set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L1P_T0_34
# set_property -dict {PACKAGE_PIN L2 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN L3 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L2N_T0_34
# set_property -dict {PACKAGE_PIN L4 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L5N_T0_34
# set_property -dict {PACKAGE_PIN L5 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L6N_T0_VREF_34
# set_property -dict {PACKAGE_PIN L6 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L6P_T0_34
# set_property -dict {PACKAGE_PIN L7 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCINT
# set_property -dict {PACKAGE_PIN L8 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN L9 IOSTANDARD LVCMOS33} [get_ports {}];  # DXN_0
# set_property -dict {PACKAGE_PIN L10 IOSTANDARD LVCMOS33} [get_ports {}];  # DXP_0
# set_property -dict {PACKAGE_PIN L11 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCINT
# set_property -dict {PACKAGE_PIN L12 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN L15 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L3P_T0_DQS_PUDC_B_14
# set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_14
# set_property -dict {PACKAGE_PIN M1 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L1N_T0_34
# set_property -dict {PACKAGE_PIN M2 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L4N_T0_34
# set_property -dict {PACKAGE_PIN M3 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L4P_T0_34
# set_property -dict {PACKAGE_PIN M4 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L16P_T2_34
# set_property -dict {PACKAGE_PIN M5 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN M6 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L18P_T2_34
# set_property -dict {PACKAGE_PIN M7 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN M8 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCINT
# set_property -dict {PACKAGE_PIN M9 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN M10 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCINT
# set_property -dict {PACKAGE_PIN M11 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN M12 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCAUX
# set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN N1 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L3N_T0_DQS_34
# set_property -dict {PACKAGE_PIN N2 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L3P_T0_DQS_34
# set_property -dict {PACKAGE_PIN N3 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_34
# set_property -dict {PACKAGE_PIN N4 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L16N_T2_34
# set_property -dict {PACKAGE_PIN N5 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L13P_T2_MRCC_34
# set_property -dict {PACKAGE_PIN N6 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L18N_T2_34
# set_property -dict {PACKAGE_PIN N7 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCINT
# set_property -dict {PACKAGE_PIN N8 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN N9 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCINT
# set_property -dict {PACKAGE_PIN N10 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN N11 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCINT
# set_property -dict {PACKAGE_PIN N12 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN N13 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_14
# set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN P1 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN P2 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L15P_T2_DQS_34
# set_property -dict {PACKAGE_PIN P3 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L14N_T2_SRCC_34
# set_property -dict {PACKAGE_PIN P4 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L14P_T2_SRCC_34
# set_property -dict {PACKAGE_PIN P5 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L13N_T2_MRCC_34
# set_property -dict {PACKAGE_PIN P6 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_34
# set_property -dict {PACKAGE_PIN P7 IOSTANDARD LVCMOS33} [get_ports {}];  # INIT_B_0
# set_property -dict {PACKAGE_PIN P8 IOSTANDARD LVCMOS33} [get_ports {}];  # CFGBVS_0
# set_property -dict {PACKAGE_PIN P9 IOSTANDARD LVCMOS33} [get_ports {}];  # PROGRAM_B_0
# set_property -dict {PACKAGE_PIN P10 IOSTANDARD LVCMOS33} [get_ports {}];  # DONE_0
# set_property -dict {PACKAGE_PIN P11 IOSTANDARD LVCMOS33} [get_ports {}];  # M2_0
# set_property -dict {PACKAGE_PIN P12 IOSTANDARD LVCMOS33} [get_ports {}];  # M0_0
# set_property -dict {PACKAGE_PIN P13 IOSTANDARD LVCMOS33} [get_ports {}];  # M1_0
# set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_14
# set_property -dict {PACKAGE_PIN R1 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L17P_T2_34
# set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L15N_T2_DQS_34
# set_property -dict {PACKAGE_PIN R3 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L11P_T1_SRCC_34
# set_property -dict {PACKAGE_PIN R4 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN R5 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L19N_T3_VREF_34
# set_property -dict {PACKAGE_PIN R6 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L19P_T3_34
# set_property -dict {PACKAGE_PIN R7 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L23P_T3_34
# set_property -dict {PACKAGE_PIN R8 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L24P_T3_34
# set_property -dict {PACKAGE_PIN R9 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_0
# set_property -dict {PACKAGE_PIN R14 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L17N_T2_34
# set_property -dict {PACKAGE_PIN T2 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_34
# set_property -dict {PACKAGE_PIN T3 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L11N_T1_SRCC_34
# set_property -dict {PACKAGE_PIN T4 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L12N_T1_MRCC_34
# set_property -dict {PACKAGE_PIN T5 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L12P_T1_MRCC_34
# set_property -dict {PACKAGE_PIN T6 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L23N_T3_34
# set_property -dict {PACKAGE_PIN T7 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN T12 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_14
# set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN U1 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L7P_T1_34
# set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L9P_T1_DQS_34
# set_property -dict {PACKAGE_PIN U3 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L8N_T1_34
# set_property -dict {PACKAGE_PIN U4 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L8P_T1_34
# set_property -dict {PACKAGE_PIN U5 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_34
# set_property -dict {PACKAGE_PIN U6 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L22N_T3_34
# set_property -dict {PACKAGE_PIN U7 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L22P_T3_34
# set_property -dict {PACKAGE_PIN U9 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L21P_T3_DQS_34
# set_property -dict {PACKAGE_PIN U10 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN U15 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_14
# set_property -dict {PACKAGE_PIN V1 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L7N_T1_34
# set_property -dict {PACKAGE_PIN V2 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L9N_T1_DQS_34
# set_property -dict {PACKAGE_PIN V3 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN V4 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L10N_T1_34
# set_property -dict {PACKAGE_PIN V5 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L10P_T1_34
# set_property -dict {PACKAGE_PIN V6 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L20N_T3_34
# set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L20P_T3_34
# set_property -dict {PACKAGE_PIN V8 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_34
# set_property -dict {PACKAGE_PIN V9 IOSTANDARD LVCMOS33} [get_ports {}];  # IO_L21N_T3_DQS_34
# set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33} [get_ports {}];  # GND
# set_property -dict {PACKAGE_PIN V18 IOSTANDARD LVCMOS33} [get_ports {}];  # VCCO_14
