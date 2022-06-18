# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  ipgui::add_page $IPINST -name "Page 0"

  ipgui::add_param $IPINST -name "g_dmdt_mult_factor"
  ipgui::add_param $IPINST -name "g_dmdt_div_factor"
  ipgui::add_param $IPINST -name "g_dmdt_period_ns"
  ipgui::add_param $IPINST -name "g_dpram_initf"
  ipgui::add_param $IPINST -name "g_simulation"

}

proc update_PARAM_VALUE.g_dmdt_div_factor { PARAM_VALUE.g_dmdt_div_factor } {
	# Procedure called to update g_dmdt_div_factor when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.g_dmdt_div_factor { PARAM_VALUE.g_dmdt_div_factor } {
	# Procedure called to validate g_dmdt_div_factor
	return true
}

proc update_PARAM_VALUE.g_dmdt_mult_factor { PARAM_VALUE.g_dmdt_mult_factor } {
	# Procedure called to update g_dmdt_mult_factor when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.g_dmdt_mult_factor { PARAM_VALUE.g_dmdt_mult_factor } {
	# Procedure called to validate g_dmdt_mult_factor
	return true
}

proc update_PARAM_VALUE.g_dmdt_period_ns { PARAM_VALUE.g_dmdt_period_ns } {
	# Procedure called to update g_dmdt_period_ns when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.g_dmdt_period_ns { PARAM_VALUE.g_dmdt_period_ns } {
	# Procedure called to validate g_dmdt_period_ns
	return true
}

proc update_PARAM_VALUE.g_dpram_initf { PARAM_VALUE.g_dpram_initf } {
	# Procedure called to update g_dpram_initf when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.g_dpram_initf { PARAM_VALUE.g_dpram_initf } {
	# Procedure called to validate g_dpram_initf
	return true
}

proc update_PARAM_VALUE.g_simulation { PARAM_VALUE.g_simulation } {
	# Procedure called to update g_simulation when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.g_simulation { PARAM_VALUE.g_simulation } {
	# Procedure called to validate g_simulation
	return true
}


proc update_MODELPARAM_VALUE.g_dpram_initf { MODELPARAM_VALUE.g_dpram_initf PARAM_VALUE.g_dpram_initf } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.g_dpram_initf}] ${MODELPARAM_VALUE.g_dpram_initf}
}

proc update_MODELPARAM_VALUE.g_simulation { MODELPARAM_VALUE.g_simulation PARAM_VALUE.g_simulation } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.g_simulation}] ${MODELPARAM_VALUE.g_simulation}
}

proc update_MODELPARAM_VALUE.g_dmdt_mult_factor { MODELPARAM_VALUE.g_dmdt_mult_factor PARAM_VALUE.g_dmdt_mult_factor } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.g_dmdt_mult_factor}] ${MODELPARAM_VALUE.g_dmdt_mult_factor}
}

proc update_MODELPARAM_VALUE.g_dmdt_div_factor { MODELPARAM_VALUE.g_dmdt_div_factor PARAM_VALUE.g_dmdt_div_factor } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.g_dmdt_div_factor}] ${MODELPARAM_VALUE.g_dmdt_div_factor}
}

proc update_MODELPARAM_VALUE.g_dmdt_period_ns { MODELPARAM_VALUE.g_dmdt_period_ns PARAM_VALUE.g_dmdt_period_ns } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.g_dmdt_period_ns}] ${MODELPARAM_VALUE.g_dmdt_period_ns}
}

