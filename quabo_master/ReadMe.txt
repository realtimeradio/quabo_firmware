v10.5E:
(1) change the reset design of bin_counter.
	The reset will start before im_mode_state_machine sending data
	
v10.5D:
(1) fix ip checksum bug

v10.5C:
(1) constraints added in placement.xdc;
create_pblock pblock_ctr_reset
add_cells_to_pblock [get_pblocks pblock_ctr_reset] [get_cells -quiet [list base_mb_i/elapsed_time_gen_0/inst/counter_reset_1_reg base_mb_i/elapsed_time_gen_0/inst/counter_reset_2_reg base_mb_i/elapsed_time_gen_0/inst/counter_reset_3_reg]]
resize_pblock [get_pblocks pblock_ctr_reset] -add {SLICE_X30Y39:SLICE_X31Y40}
(2) constraints changed in timing.xdc;
     a) remove--#set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_0/inst/mmcm_adv_inst/CLKOUT5]] -to [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]]
     b) remove--#set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -to [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT1]]
     c) add--set_false_path -from [get_clocks -of_objects [get_pins base_mb_i/clk_wiz_1/inst/mmcm_adv_inst/CLKOUT0]] -to [get_pins {base_mb_i/maroc_dc_0/inst/USR_LOGIC/IM_MUX[*].MUX_L/dout_reg[*]/D}]
(3) change some code in bin_counter for removing the deadtime;
(4) the reset of im state machine is changed to ".frame_reset((!mode_enable[1])),".

v10.5B:
Remove all debugging signals, and add placement constraints in placement.xdc

v10.5A:
(1) We get IM packets(ACQ_MODE=2) from hardware instead of software, so we can get high speed packets;
(2) We can set ACQ_MODE to 0, so that no packets will be sent out except HK packets.

v10.5:
(1) finish high speed IM mode(ACQ_MODE = 3).
	We can get PH packets and IM packets at the same time:
	when it's PH packet, its ACQ_MODE = 1;
	when it's IM packet, its ACQ_MODE = 3;
(2) I just finished function test,including UDP packets checksum, timing difference,
	but I'm not sure whether the scientific data is correct;
	We need more tests on it;

v10.4:
(1) replace set_focus function with rick's new code to solve issue of stage stops when it reacges tge upper optical switch;
(2) fix the system crashed issue(a fifo in eth_core_ctrl core was full...);
(3) fix the issue of losing connection to the last quabo on mobo;
    The second eth port on the last quabo is open, so it can't finish the auto-negotiation. I configure the second eth port to fixed 1000Mbps, not auto-negotiation;
(4) fix mac address issue;
    some mac addresses are illegal, and it's related to the first byte;
    I set the first byte of mac address to 0x00 to solve the issue;
(5) fix the issue about stage didn't work with more than 2 quabo on mobo;
    focus_limits_on(output) port is connected to bus, so I change is to three state, if it's quabo1/2/3; 
	

