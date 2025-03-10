# TCL File Generated by Component Editor 18.1
# Fri Mar 01 19:37:40 GMT 2024
# DO NOT MODIFY


# 
# term "term" v2.0
#  2024.03.01.19:37:40
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module term
# 
set_module_property DESCRIPTION ""
set_module_property NAME term
set_module_property VERSION 2.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME term
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL top
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file fp_add.v VERILOG PATH custom/fp_add.v
add_fileset_file fp_mult.v VERILOG PATH custom/fp_mult.v
add_fileset_file fp_sub.v VERILOG PATH custom/fp_sub.v
add_fileset_file cosine.sv SYSTEM_VERILOG PATH custom/cordic/RTL/cosine.sv
add_fileset_file engine.sv SYSTEM_VERILOG PATH custom/cordic/RTL/engine.sv
add_fileset_file packer.sv SYSTEM_VERILOG PATH custom/cordic/RTL/packer.sv
add_fileset_file unpacker.sv SYSTEM_VERILOG PATH custom/cordic/RTL/unpacker.sv
add_fileset_file dspba_library.vhd VHDL PATH custom/fp_mult/dspba_library.vhd
add_fileset_file dspba_library_package.vhd VHDL PATH custom/fp_mult/dspba_library_package.vhd IS_CONFIGURATION_PACKAGE
add_fileset_file fp_add_0002.vhd VHDL PATH custom/fp_add/fp_add_0002.vhd
add_fileset_file fp_sub_0002.vhd VHDL PATH custom/fp_sub/fp_sub_0002.vhd
add_fileset_file fp_mult_0002.vhd VHDL PATH custom/fp_mult/fp_mult_0002.vhd
add_fileset_file term.sv SYSTEM_VERILOG PATH custom/term.sv TOP_LEVEL_FILE


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
set_interface_property nios_custom_instruction_slave clockCycle 8
set_interface_property nios_custom_instruction_slave operands 1
set_interface_property nios_custom_instruction_slave ENABLED true
set_interface_property nios_custom_instruction_slave EXPORT_OF ""
set_interface_property nios_custom_instruction_slave PORT_NAME_MAP ""
set_interface_property nios_custom_instruction_slave CMSIS_SVD_VARIABLES ""
set_interface_property nios_custom_instruction_slave SVD_ADDRESS_GROUP ""

add_interface_port nios_custom_instruction_slave clk_en clk_en Input 1
add_interface_port nios_custom_instruction_slave x dataa Input 32
add_interface_port nios_custom_instruction_slave result result Output 32
add_interface_port nios_custom_instruction_slave clk clk Input 1
add_interface_port nios_custom_instruction_slave reset reset Input 1

