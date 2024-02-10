# TCL File Generated by Component Editor 18.1
# Sat Feb 10 12:58:45 GMT 2024
# DO NOT MODIFY


# 
# fp_add_sub "fp_add_sub" v2.0
#  2024.02.10.12:58:45
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module fp_add_sub
# 
set_module_property DESCRIPTION ""
set_module_property NAME fp_add_sub
set_module_property VERSION 2.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME fp_add_sub
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL fp_add_sub
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file fp_add_sub.v VERILOG PATH custom/fp_add_sub.v TOP_LEVEL_FILE
add_fileset_file dspba_library.vhd VHDL PATH custom/fp_add_sub/dspba_library.vhd
add_fileset_file dspba_library_package.vhd VHDL PATH custom/fp_add_sub/dspba_library_package.vhd IS_CONFIGURATION_PACKAGE
add_fileset_file fp_add_sub_0002.vhd VHDL PATH custom/fp_add_sub/fp_add_sub_0002.vhd


# 
# parameters
# 


# 
# display items
# 


# 
# connection point nios_custom_instruction_slave
# 
add_interface nios_custom_instruction_slave nios_custom_instruction end
set_interface_property nios_custom_instruction_slave clockCycle 4
set_interface_property nios_custom_instruction_slave operands 2
set_interface_property nios_custom_instruction_slave ENABLED true
set_interface_property nios_custom_instruction_slave EXPORT_OF ""
set_interface_property nios_custom_instruction_slave PORT_NAME_MAP ""
set_interface_property nios_custom_instruction_slave CMSIS_SVD_VARIABLES ""
set_interface_property nios_custom_instruction_slave SVD_ADDRESS_GROUP ""

add_interface_port nios_custom_instruction_slave areset reset Input 1
add_interface_port nios_custom_instruction_slave en clk_en Input 1
add_interface_port nios_custom_instruction_slave a dataa Input 32
add_interface_port nios_custom_instruction_slave b datab Input 32
add_interface_port nios_custom_instruction_slave q result Output 32
add_interface_port nios_custom_instruction_slave opSel n Input 1
add_interface_port nios_custom_instruction_slave clk clk Input 1

