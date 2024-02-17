# TCL File Generated by Component Editor 18.1
# Fri Feb 16 14:59:53 GMT 2024
# DO NOT MODIFY


# 
# fp_sub "fp_sub" v1.0
#  2024.02.16.14:59:53
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module fp_sub
# 
set_module_property DESCRIPTION ""
set_module_property NAME fp_sub
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME fp_sub
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL fp_sub
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file fp_sub.v VERILOG PATH fp_sub.v TOP_LEVEL_FILE
add_fileset_file dspba_library.vhd VHDL PATH fp_sub/dspba_library.vhd IS_CONFIGURATION_PACKAGE
add_fileset_file dspba_library_package.vhd VHDL PATH fp_sub/dspba_library_package.vhd IS_CONFIGURATION_PACKAGE
add_fileset_file fp_sub_0002.vhd VHDL PATH fp_sub/fp_sub_0002.vhd


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
set_interface_property nios_custom_instruction_slave clockCycle 3
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
add_interface_port nios_custom_instruction_slave clk clk Input 1

