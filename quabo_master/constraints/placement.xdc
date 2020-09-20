create_pblock pblock_ctr_reset
add_cells_to_pblock [get_pblocks pblock_ctr_reset] [get_cells -quiet [list base_mb_i/elapsed_time_gen_0/inst/counter_reset_1_reg base_mb_i/elapsed_time_gen_0/inst/counter_reset_2_reg base_mb_i/elapsed_time_gen_0/inst/counter_reset_3_reg]]
resize_pblock [get_pblocks pblock_ctr_reset] -add {SLICE_X30Y39:SLICE_X31Y40}



