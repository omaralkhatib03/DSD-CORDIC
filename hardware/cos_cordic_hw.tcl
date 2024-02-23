# TCL File Generated by Component Editor 18.1
# Thu Feb 22 22:31:08 GMT 2024
# DO NOT MODIFY


# 
# cos_cordic "cos_cordic" v1.0
#  2024.02.22.22:31:08
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module cos_cordic
# 
set_module_property DESCRIPTION ""
set_module_property NAME cos_cordic
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME cos_cordic
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL cosine
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file cosine.sv SYSTEM_VERILOG PATH ../cordic/RTL/cosine.sv TOP_LEVEL_FILE
add_fileset_file engine.sv SYSTEM_VERILOG PATH ../cordic/RTL/engine.sv
add_fileset_file packer.sv SYSTEM_VERILOG PATH ../cordic/RTL/packer.sv
add_fileset_file unpacker.sv SYSTEM_VERILOG PATH ../cordic/RTL/unpacker.sv


# 
# parameters
# 
add_parameter WIDTH INTEGER 22
set_parameter_property WIDTH DEFAULT_VALUE 22
set_parameter_property WIDTH DISPLAY_NAME WIDTH
set_parameter_property WIDTH TYPE INTEGER
set_parameter_property WIDTH UNITS None
set_parameter_property WIDTH ALLOWED_RANGES -2147483648:2147483647
set_parameter_property WIDTH HDL_PARAMETER true
add_parameter LIMIT STD_LOGIC_VECTOR 2547003
set_parameter_property LIMIT DEFAULT_VALUE 2547003
set_parameter_property LIMIT DISPLAY_NAME LIMIT
set_parameter_property LIMIT TYPE STD_LOGIC_VECTOR
set_parameter_property LIMIT UNITS None
set_parameter_property LIMIT ALLOWED_RANGES 0:67108863
set_parameter_property LIMIT HDL_PARAMETER true


# 
# display items
# 


# 
# connection point nios_custom_instruction_slave
# 
add_interface nios_custom_instruction_slave nios_custom_instruction end
set_interface_property nios_custom_instruction_slave clockCycle 3
set_interface_property nios_custom_instruction_slave operands 1
set_interface_property nios_custom_instruction_slave ENABLED true
set_interface_property nios_custom_instruction_slave EXPORT_OF ""
set_interface_property nios_custom_instruction_slave PORT_NAME_MAP ""
set_interface_property nios_custom_instruction_slave CMSIS_SVD_VARIABLES ""
set_interface_property nios_custom_instruction_slave SVD_ADDRESS_GROUP ""

add_interface_port nios_custom_instruction_slave clk_en clk_en Input 1
add_interface_port nios_custom_instruction_slave angle dataa Input 32
add_interface_port nios_custom_instruction_slave result result Output 32
add_interface_port nios_custom_instruction_slave clk clk Input 1
add_interface_port nios_custom_instruction_slave reset reset Input 1

