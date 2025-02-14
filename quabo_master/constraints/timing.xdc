create_clock -period 8.000 -name mgt_clk_0_clk_p -waveform {0.000 4.000} [get_ports mgt_clk_0_clk_p]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets base_mb_i/in_buf_ds_adcbitclk/inst/outp]
#White rabbit part
create_clock -period 8.000 -name TS_clk_125m_gtx_p_i_0 -waveform {0.000 4.000} [get_ports clk_125m_gtx_p_i_0]
create_clock -period 16.000 -name base_mb_i/wrc_board_quabo_Light_0/U0/cmp_xwrc_board_quabo/cmp_xwrc_platform/gen_phy_kintex7.cmp_gtx/U_GTX_INST/I -waveform {0.000 8.000} [get_pins base_mb_i/wrc_board_quabo_Light_0/U0/cmp_xwrc_board_quabo/cmp_xwrc_platform/gen_phy_kintex7.cmp_gtx/U_GTX_INST/gtxe2_i/TXOUTCLK]
create_clock -period 16.000 -name base_mb_i/wrc_board_quabo_Light_0/U0/cmp_xwrc_board_quabo/cmp_xwrc_platform/gen_phy_kintex7.cmp_gtx/U_GTX_INST/rx_rec_clk_bufin -waveform {0.000 8.000} [get_pins base_mb_i/wrc_board_quabo_Light_0/U0/cmp_xwrc_board_quabo/cmp_xwrc_platform/gen_phy_kintex7.cmp_gtx/U_GTX_INST/gtxe2_i/RXOUTCLK]
create_clock -period 50.000 -name clk_20m_vcxo_i_0 -waveform {0.000 25.000} [get_ports clk_20m_vcxo_i_0]

#the 62.5MHz clock from the buffer on Mobo
create_clock -period 16.000 -name sysclk_in [get_ports sysclkin_p]

#The PH ADC interface
create_clock -period 16.667 -name {BIT_CLK_P[0]} -waveform {0.000 8.334} [get_ports {BIT_CLK_P[0]}]
set_input_delay -clock [get_clocks {BIT_CLK_P[0]}] -clock_fall -min -add_delay 3.000 [get_ports {ADC_DIN_N[*]}]
set_input_delay -clock [get_clocks {BIT_CLK_P[0]}] -clock_fall -max -add_delay 5.333 [get_ports {ADC_DIN_N[*]}]
set_input_delay -clock [get_clocks {BIT_CLK_P[0]}] -min -add_delay 3.000 [get_ports {ADC_DIN_N[*]}]
set_input_delay -clock [get_clocks {BIT_CLK_P[0]}] -max -add_delay 5.333 [get_ports {ADC_DIN_N[*]}]
set_input_delay -clock [get_clocks {BIT_CLK_P[0]}] -clock_fall -min -add_delay 3.000 [get_ports {ADC_DIN_P[*]}]
set_input_delay -clock [get_clocks {BIT_CLK_P[0]}] -clock_fall -max -add_delay 5.333 [get_ports {ADC_DIN_P[*]}]
set_input_delay -clock [get_clocks {BIT_CLK_P[0]}] -min -add_delay 3.000 [get_ports {ADC_DIN_P[*]}]
set_input_delay -clock [get_clocks {BIT_CLK_P[0]}] -max -add_delay 5.333 [get_ports {ADC_DIN_P[*]}]
set_input_delay -clock [get_clocks {BIT_CLK_P[0]}] -clock_fall -min -add_delay 3.000 [get_ports FRM_CLK_N]
set_input_delay -clock [get_clocks {BIT_CLK_P[0]}] -clock_fall -max -add_delay 5.333 [get_ports FRM_CLK_N]
set_input_delay -clock [get_clocks {BIT_CLK_P[0]}] -min -add_delay 3.000 [get_ports FRM_CLK_N]
set_input_delay -clock [get_clocks {BIT_CLK_P[0]}] -max -add_delay 5.333 [get_ports FRM_CLK_N]
set_input_delay -clock [get_clocks {BIT_CLK_P[0]}] -clock_fall -min -add_delay 3.000 [get_ports FRM_CLK_P]
set_input_delay -clock [get_clocks {BIT_CLK_P[0]}] -clock_fall -max -add_delay 5.333 [get_ports FRM_CLK_P]
set_input_delay -clock [get_clocks {BIT_CLK_P[0]}] -min -add_delay 3.000 [get_ports FRM_CLK_P]
set_input_delay -clock [get_clocks {BIT_CLK_P[0]}] -max -add_delay 5.333 [get_ports FRM_CLK_P]

#This is from the 100MHz axi_clk to the 250MHz ET_clk.  All of these paths are covered
set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT0]]
set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT2]]
set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT3]]
set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT4]]
set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT5]]
#This is the return path.  The ET counters are held during the reading of the MUX; no need to time these
set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]]
set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT2]] -to [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]]
set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT3]] -to [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]]
set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT4]] -to [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]]
#set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT5]] -to [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]]

#This is the path from the image_mode_state_machine 8-bit select output to the MUX which selects one of 256 pixel counters.  The counter values are held while we exercise these
set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -to [get_pins {base_mb_i/maroc_dc_0/inst/USR_LOGIC/IM_MUX[*].MUX_L/dout_reg[*]/D}]
##These are from the WR core to the SPI_access module
set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/wrc_board_quabo_Light_0/U0/cmp_xwrc_board_quabo/cmp_xwrc_platform/gen_default_plls.gen_kintex7_default_plls.cmp_sys_clk_pll/CLKOUT0]] -to [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]]
#This is the ADC_frame signal; there is a synchronizer
set_false_path -from [get_pins base_mb_i/maroc_dc_0/inst/USR_LOGIC/QDATA_RX/IDDR_FRAME/C] -to [get_pins base_mb_i/maroc_dc_0/inst/USR_LOGIC/adc_frame_axi_sync_reg/D]
#This is from the 100MHz axi_clk to the 200MHz clock used for the IM counters.  These outputs are held during the reading of the values
#set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT1]]

#These are deep within the WR core
set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/wrc_board_quabo_Light_0/U0/cmp_xwrc_board_quabo/cmp_xwrc_platform/gen_default_plls.gen_kintex7_default_plls.cmp_dmtd_clk_pll/CLKOUT0]] -to [get_clocks -of_objects [get_pins base_mb_i/wrc_board_quabo_Light_0/U0/cmp_xwrc_board_quabo/cmp_xwrc_platform/gen_default_plls.gen_kintex7_default_plls.cmp_sys_clk_pll/CLKOUT0]]
set_false_path -from [get_clocks clk_20m_vcxo_i_0] -to [get_clocks -of_objects [get_pins base_mb_i/wrc_board_quabo_Light_0/U0/cmp_xwrc_board_quabo/cmp_xwrc_platform/gen_default_plls.gen_kintex7_default_plls.cmp_sys_clk_pll/CLKOUT0]]
set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/wrc_board_quabo_Light_0/U0/cmp_xwrc_board_quabo/cmp_xwrc_platform/gen_default_plls.gen_kintex7_default_plls.cmp_sys_clk_pll/CLKOUT0]] -to [get_clocks clk_20m_vcxo_i_0]
set_property ASYNC_REG true [get_cells {base_mb_i/wrc_board_quabo_Light_0/U0/cmp_xwrc_board_quabo/cmp_board_common/cmp_xwr_core/WRPC/U_SOFTPLL/U_Wrapped_Softpll/gen_feedback_dmtds[0].DMTD_FB/gen_straight.clk_i_d0_reg}]
set_property ASYNC_REG true [get_cells {base_mb_i/wrc_board_quabo_Light_0/U0/cmp_xwrc_board_quabo/cmp_board_common/cmp_xwr_core/WRPC/U_SOFTPLL/U_Wrapped_Softpll/gen_feedback_dmtds[0].DMTD_FB/gen_straight.clk_i_d3_reg}]
set_property ASYNC_REG true [get_cells {base_mb_i/wrc_board_quabo_Light_0/U0/cmp_xwrc_board_quabo/cmp_board_common/cmp_xwr_core/WRPC/U_SOFTPLL/U_Wrapped_Softpll/gen_ref_dmtds[0].DMTD_REF/gen_straight.clk_i_d0_reg}]
set_property ASYNC_REG true [get_cells {base_mb_i/wrc_board_quabo_Light_0/U0/cmp_xwrc_board_quabo/cmp_board_common/cmp_xwr_core/WRPC/U_SOFTPLL/U_Wrapped_Softpll/gen_ref_dmtds[0].DMTD_REF/gen_straight.clk_i_d3_reg}]
set_clock_groups -asynchronous -group [get_clocks base_mb_i/wrc_board_quabo_Light_0/U0/cmp_xwrc_board_quabo/cmp_xwrc_platform/gen_phy_kintex7.cmp_gtx/U_GTX_INST/I] -group [get_clocks clk_dmtd]
set_clock_groups -asynchronous -group [get_clocks base_mb_i/wrc_board_quabo_Light_0/U0/cmp_xwrc_board_quabo/cmp_xwrc_platform/gen_phy_kintex7.cmp_gtx/U_GTX_INST/rx_rec_clk_bufin] -group [get_clocks clk_dmtd]

set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT2]]
set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT3]]
set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT4]]
set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT2]] -to [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]]
set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT3]] -to [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]]
set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT4]] -to [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]]

#delay from the sysclk_in from Mobo through the output driver and the Mobo PCB to another Quabo
set_input_delay -clock [get_clocks sysclk_in] -min -add_delay 7.000 [get_ports pps_inout_0]
set_input_delay -clock [get_clocks sysclk_in] -max -add_delay 9.500 [get_ports pps_inout_0]


set_clock_latency -source -early 3.000 [get_clocks sysclk_in]
set_clock_latency -source -late 4.500 [get_clocks sysclk_in]



#This is not really a false path.  I'm suppressing a hold violation between the WR clock (mgt_clk_0_clk_p) domain and the sysclk one.
#The data is captured correctly with the first sysclk edge following the WR clock edge (since sysclk occurs at least 3ns later).
#But the timer thinks this is a problem.
set_false_path -from [get_pins base_mb_i/wrc_board_quabo_Light_0/U0/cmp_xwrc_board_quabo/cmp_board_common/cmp_xwr_core/WRPC/PPS_GEN/WRAPPED_PPSGEN/pps_out_o_reg/C] -to [get_pins base_mb_i/delay_1/inst/FDRE_inst/D]


set_false_path -from [get_clocks base_mb_i/wrc_board_quabo_Light_0/U0/cmp_xwrc_board_quabo/cmp_xwrc_platform/gen_phy_kintex7.cmp_gtx/U_GTX_INST/I] -to [get_clocks clk_100_base_mb_clk_wiz_1_0]



















create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list base_mb_i/clk_wiz_1/inst/clk_100]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 32 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[0]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[1]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[2]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[3]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[4]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[5]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[6]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[7]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[8]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[9]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[10]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[11]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[12]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[13]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[14]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[15]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[16]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[17]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[18]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[19]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[20]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[21]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[22]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[23]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[24]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[25]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[26]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[27]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[28]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[29]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[30]} {base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tdata[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 1 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tlast]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 1 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list base_mb_i/PH_BL_FIFO_0/axi_str_rxd_tvalid]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets u_ila_0_clk_100]
