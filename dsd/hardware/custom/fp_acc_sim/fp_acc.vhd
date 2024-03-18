-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 18.1 (Release Build #625)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2018 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from fp_acc
-- VHDL created on Mon Mar 18 17:41:56 2024


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.altera_syncram;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity fp_acc is
    port (
        x : in std_logic_vector(31 downto 0);  -- float32_m23
        n : in std_logic_vector(0 downto 0);  -- ufix1
        en : in std_logic_vector(0 downto 0);  -- ufix1
        r : out std_logic_vector(31 downto 0);  -- float32_m23
        xo : out std_logic_vector(0 downto 0);  -- ufix1
        xu : out std_logic_vector(0 downto 0);  -- ufix1
        ao : out std_logic_vector(0 downto 0);  -- ufix1
        clk : in std_logic;
        areset : in std_logic
    );
end fp_acc;

architecture normal of fp_acc is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expX_uid6_fpAccTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal fracX_uid7_fpAccTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal signX_uid8_fpAccTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal oFracX_uid10_fpAccTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal expGTMaxMSBX_uid13_fpAccTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_a : STD_LOGIC_VECTOR (9 downto 0);
    signal cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_b : STD_LOGIC_VECTOR (9 downto 0);
    signal cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_o : STD_LOGIC_VECTOR (9 downto 0);
    signal cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal rShiftConstant_uid15_fpAccTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal rightShiftValue_uid16_fpAccTest_a : STD_LOGIC_VECTOR (9 downto 0);
    signal rightShiftValue_uid16_fpAccTest_b : STD_LOGIC_VECTOR (9 downto 0);
    signal rightShiftValue_uid16_fpAccTest_o : STD_LOGIC_VECTOR (9 downto 0);
    signal rightShiftValue_uid16_fpAccTest_q : STD_LOGIC_VECTOR (9 downto 0);
    signal padConst_uid17_fpAccTest_q : STD_LOGIC_VECTOR (176 downto 0);
    signal rightPaddedIn_uid18_fpAccTest_q : STD_LOGIC_VECTOR (200 downto 0);
    signal shiftedFracUpper_uid20_fpAccTest_b : STD_LOGIC_VECTOR (176 downto 0);
    signal extendedAlignedShiftedFrac_uid21_fpAccTest_q : STD_LOGIC_VECTOR (177 downto 0);
    signal onesComplementExtendedFrac_uid22_fpAccTest_b : STD_LOGIC_VECTOR (177 downto 0);
    signal onesComplementExtendedFrac_uid22_fpAccTest_q : STD_LOGIC_VECTOR (177 downto 0);
    signal accumulator_uid24_fpAccTest_a : STD_LOGIC_VECTOR (181 downto 0);
    signal accumulator_uid24_fpAccTest_b : STD_LOGIC_VECTOR (181 downto 0);
    signal accumulator_uid24_fpAccTest_i : STD_LOGIC_VECTOR (181 downto 0);
    signal accumulator_uid24_fpAccTest_o : STD_LOGIC_VECTOR (181 downto 0);
    signal accumulator_uid24_fpAccTest_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal accumulator_uid24_fpAccTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal accumulator_uid24_fpAccTest_q : STD_LOGIC_VECTOR (179 downto 0);
    signal os_uid25_fpAccTest_q : STD_LOGIC_VECTOR (180 downto 0);
    signal osr_uid26_fpAccTest_in : STD_LOGIC_VECTOR (179 downto 0);
    signal osr_uid26_fpAccTest_b : STD_LOGIC_VECTOR (179 downto 0);
    signal sum_uid27_fpAccTest_in : STD_LOGIC_VECTOR (178 downto 0);
    signal sum_uid27_fpAccTest_b : STD_LOGIC_VECTOR (178 downto 0);
    signal accumulatorSign_uid29_fpAccTest_in : STD_LOGIC_VECTOR (177 downto 0);
    signal accumulatorSign_uid29_fpAccTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal accOverflowBitMSB_uid30_fpAccTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal accOverflow_uid32_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal accValidRange_uid33_fpAccTest_in : STD_LOGIC_VECTOR (177 downto 0);
    signal accValidRange_uid33_fpAccTest_b : STD_LOGIC_VECTOR (177 downto 0);
    signal accOnesComplement_uid34_fpAccTest_b : STD_LOGIC_VECTOR (177 downto 0);
    signal accOnesComplement_uid34_fpAccTest_q : STD_LOGIC_VECTOR (177 downto 0);
    signal accValuePositive_uid35_fpAccTest_a : STD_LOGIC_VECTOR (178 downto 0);
    signal accValuePositive_uid35_fpAccTest_b : STD_LOGIC_VECTOR (178 downto 0);
    signal accValuePositive_uid35_fpAccTest_o : STD_LOGIC_VECTOR (178 downto 0);
    signal accValuePositive_uid35_fpAccTest_q : STD_LOGIC_VECTOR (178 downto 0);
    signal posAccWoLeadingZeroBit_uid36_fpAccTest_in : STD_LOGIC_VECTOR (176 downto 0);
    signal posAccWoLeadingZeroBit_uid36_fpAccTest_b : STD_LOGIC_VECTOR (176 downto 0);
    signal accResOutOfExpRange_uid39_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal zeroExponent_uid42_fpAccTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal resExpSub_uid43_fpAccTest_a : STD_LOGIC_VECTOR (9 downto 0);
    signal resExpSub_uid43_fpAccTest_b : STD_LOGIC_VECTOR (9 downto 0);
    signal resExpSub_uid43_fpAccTest_o : STD_LOGIC_VECTOR (9 downto 0);
    signal resExpSub_uid43_fpAccTest_q : STD_LOGIC_VECTOR (9 downto 0);
    signal finalExponent_uid44_fpAccTest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal finalExponent_uid44_fpAccTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal finalExpUpdated_uid45_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal finalExpUpdated_uid45_fpAccTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal fracR_uid46_fpAccTest_in : STD_LOGIC_VECTOR (175 downto 0);
    signal fracR_uid46_fpAccTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal R_uid47_fpAccTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal muxXOverflowFeedbackSignal_uid51_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal muxXOverflowFeedbackSignal_uid51_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oRXOverflowFlagFeedback_uid52_fpAccTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal oRXOverflowFlagFeedback_uid52_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal muxXUnderflowFeedbackSignal_uid55_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal muxXUnderflowFeedbackSignal_uid55_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expNotZero_uid56_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal underflowCond_uid57_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oRXUnderflowFlagFeedback_uid58_fpAccTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal oRXUnderflowFlagFeedback_uid58_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal muxAccOverflowFeedbackSignal_uid61_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal muxAccOverflowFeedbackSignal_uid61_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oRAccOverflowFlagFeedback_uid62_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal zs_uid66_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (127 downto 0);
    signal vCount_uid68_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal mO_uid69_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (78 downto 0);
    signal cStage_uid71_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (127 downto 0);
    signal vStagei_uid73_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid73_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (127 downto 0);
    signal zs_uid74_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (63 downto 0);
    signal vCount_uid76_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid79_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid79_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (63 downto 0);
    signal zs_uid80_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal vCount_uid82_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid85_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid85_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal zs_uid86_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid88_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid91_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid91_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid94_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid97_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid97_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal zs_uid98_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vCount_uid100_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid103_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid103_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (3 downto 0);
    signal zs_uid104_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal vCount_uid106_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid109_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid109_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid111_zeroCounter_uid37_fpAccTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid112_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid113_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal wIntCst_uid117_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal shiftedOut_uid118_alignmentShifter_uid17_fpAccTest_a : STD_LOGIC_VECTOR (11 downto 0);
    signal shiftedOut_uid118_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal shiftedOut_uid118_alignmentShifter_uid17_fpAccTest_o : STD_LOGIC_VECTOR (11 downto 0);
    signal shiftedOut_uid118_alignmentShifter_uid17_fpAccTest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx1Rng64_uid119_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (136 downto 0);
    signal rightShiftStage0Idx1_uid121_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (200 downto 0);
    signal rightShiftStage0Idx2Rng128_uid122_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (72 downto 0);
    signal rightShiftStage0Idx2_uid124_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (200 downto 0);
    signal rightShiftStage0Idx3Rng192_uid125_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (8 downto 0);
    signal rightShiftStage0Idx3Pad192_uid126_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (191 downto 0);
    signal rightShiftStage0Idx3_uid127_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (200 downto 0);
    signal rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (200 downto 0);
    signal rightShiftStage1Idx1Rng16_uid130_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (184 downto 0);
    signal rightShiftStage1Idx1_uid132_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (200 downto 0);
    signal rightShiftStage1Idx2Rng32_uid133_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (168 downto 0);
    signal rightShiftStage1Idx2_uid135_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (200 downto 0);
    signal rightShiftStage1Idx3Rng48_uid136_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (152 downto 0);
    signal rightShiftStage1Idx3Pad48_uid137_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (47 downto 0);
    signal rightShiftStage1Idx3_uid138_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (200 downto 0);
    signal rightShiftStage1_uid140_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid140_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (200 downto 0);
    signal rightShiftStage2Idx1Rng4_uid141_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (196 downto 0);
    signal rightShiftStage2Idx1_uid143_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (200 downto 0);
    signal rightShiftStage2Idx2Rng8_uid144_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (192 downto 0);
    signal rightShiftStage2Idx2_uid146_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (200 downto 0);
    signal rightShiftStage2Idx3Rng12_uid147_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (188 downto 0);
    signal rightShiftStage2Idx3Pad12_uid148_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (11 downto 0);
    signal rightShiftStage2Idx3_uid149_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (200 downto 0);
    signal rightShiftStage2_uid151_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage2_uid151_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (200 downto 0);
    signal rightShiftStage3Idx1Rng1_uid152_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (199 downto 0);
    signal rightShiftStage3Idx1_uid154_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (200 downto 0);
    signal rightShiftStage3Idx2Rng2_uid155_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (198 downto 0);
    signal rightShiftStage3Idx2_uid157_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (200 downto 0);
    signal rightShiftStage3Idx3Rng3_uid158_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (197 downto 0);
    signal rightShiftStage3Idx3Pad3_uid159_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (2 downto 0);
    signal rightShiftStage3Idx3_uid160_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (200 downto 0);
    signal rightShiftStage3_uid162_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage3_uid162_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (200 downto 0);
    signal zeroOutCst_uid163_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (200 downto 0);
    signal r_uid164_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid164_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (200 downto 0);
    signal leftShiftStage0Idx1Rng64_uid169_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (114 downto 0);
    signal leftShiftStage0Idx1Rng64_uid169_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (114 downto 0);
    signal leftShiftStage0Idx1_uid170_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (178 downto 0);
    signal leftShiftStage0Idx2Rng128_uid172_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (50 downto 0);
    signal leftShiftStage0Idx2Rng128_uid172_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (50 downto 0);
    signal leftShiftStage0Idx2_uid173_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (178 downto 0);
    signal leftShiftStage0Idx3_uid174_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (178 downto 0);
    signal leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (178 downto 0);
    signal leftShiftStage1Idx1Rng16_uid178_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (162 downto 0);
    signal leftShiftStage1Idx1Rng16_uid178_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (162 downto 0);
    signal leftShiftStage1Idx1_uid179_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (178 downto 0);
    signal leftShiftStage1Idx2Rng32_uid181_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (146 downto 0);
    signal leftShiftStage1Idx2Rng32_uid181_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (146 downto 0);
    signal leftShiftStage1Idx2_uid182_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (178 downto 0);
    signal leftShiftStage1Idx3Rng48_uid184_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (130 downto 0);
    signal leftShiftStage1Idx3Rng48_uid184_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (130 downto 0);
    signal leftShiftStage1Idx3_uid185_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (178 downto 0);
    signal leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (178 downto 0);
    signal leftShiftStage2Idx1Rng4_uid189_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (174 downto 0);
    signal leftShiftStage2Idx1Rng4_uid189_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (174 downto 0);
    signal leftShiftStage2Idx1_uid190_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (178 downto 0);
    signal leftShiftStage2Idx2Rng8_uid192_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (170 downto 0);
    signal leftShiftStage2Idx2Rng8_uid192_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (170 downto 0);
    signal leftShiftStage2Idx2_uid193_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (178 downto 0);
    signal leftShiftStage2Idx3Rng12_uid195_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (166 downto 0);
    signal leftShiftStage2Idx3Rng12_uid195_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (166 downto 0);
    signal leftShiftStage2Idx3_uid196_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (178 downto 0);
    signal leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (178 downto 0);
    signal leftShiftStage3Idx1Rng1_uid200_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (177 downto 0);
    signal leftShiftStage3Idx1Rng1_uid200_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (177 downto 0);
    signal leftShiftStage3Idx1_uid201_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (178 downto 0);
    signal leftShiftStage3Idx2Rng2_uid203_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (176 downto 0);
    signal leftShiftStage3Idx2Rng2_uid203_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (176 downto 0);
    signal leftShiftStage3Idx2_uid204_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (178 downto 0);
    signal leftShiftStage3Idx3Rng3_uid206_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (175 downto 0);
    signal leftShiftStage3Idx3Rng3_uid206_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (175 downto 0);
    signal leftShiftStage3Idx3_uid207_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (178 downto 0);
    signal leftShiftStage3_uid209_normalizationShifter_uid40_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage3_uid209_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (178 downto 0);
    signal rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_in : STD_LOGIC_VECTOR (7 downto 0);
    signal rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_d : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_e : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (127 downto 0);
    signal rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (48 downto 0);
    signal rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (63 downto 0);
    signal rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (63 downto 0);
    signal rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (31 downto 0);
    signal rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (31 downto 0);
    signal rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel7Dto6_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel7Dto6_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel7Dto6_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_d : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel7Dto6_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_e : STD_LOGIC_VECTOR (1 downto 0);
    signal redist0_rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist1_rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist2_rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_d_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist3_rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_e_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist4_shiftedOut_uid118_alignmentShifter_uid17_fpAccTest_n_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_r_uid113_zeroCounter_uid37_fpAccTest_q_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist6_vCount_uid88_zeroCounter_uid37_fpAccTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_vCount_uid82_zeroCounter_uid37_fpAccTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_vCount_uid76_zeroCounter_uid37_fpAccTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_vCount_uid68_zeroCounter_uid37_fpAccTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_oRAccOverflowFlagFeedback_uid62_fpAccTest_q_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist11_oRXUnderflowFlagFeedback_uid58_fpAccTest_q_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_oRXOverflowFlagFeedback_uid52_fpAccTest_q_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_accValuePositive_uid35_fpAccTest_q_4_q : STD_LOGIC_VECTOR (178 downto 0);
    signal redist14_accumulatorSign_uid29_fpAccTest_b_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_signX_uid8_fpAccTest_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_fracX_uid7_fpAccTest_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist18_xIn_n_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_accValuePositive_uid35_fpAccTest_q_4_outputreg_q : STD_LOGIC_VECTOR (178 downto 0);

begin


    -- signX_uid8_fpAccTest(BITSELECT,7)@0
    signX_uid8_fpAccTest_b <= STD_LOGIC_VECTOR(x(31 downto 31));

    -- redist16_signX_uid8_fpAccTest_b_2(DELAY,235)
    redist16_signX_uid8_fpAccTest_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => signX_uid8_fpAccTest_b, xout => redist16_signX_uid8_fpAccTest_b_2_q, ena => en(0), clk => clk, aclr => areset );

    -- redist18_xIn_n_2(DELAY,237)
    redist18_xIn_n_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => n, xout => redist18_xIn_n_2_q, ena => en(0), clk => clk, aclr => areset );

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- zeroOutCst_uid163_alignmentShifter_uid17_fpAccTest(CONSTANT,162)
    zeroOutCst_uid163_alignmentShifter_uid17_fpAccTest_q <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- rightShiftStage3Idx3Pad3_uid159_alignmentShifter_uid17_fpAccTest(CONSTANT,158)
    rightShiftStage3Idx3Pad3_uid159_alignmentShifter_uid17_fpAccTest_q <= "000";

    -- rightShiftStage3Idx3Rng3_uid158_alignmentShifter_uid17_fpAccTest(BITSELECT,157)@1
    rightShiftStage3Idx3Rng3_uid158_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage2_uid151_alignmentShifter_uid17_fpAccTest_q(200 downto 3);

    -- rightShiftStage3Idx3_uid160_alignmentShifter_uid17_fpAccTest(BITJOIN,159)@1
    rightShiftStage3Idx3_uid160_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage3Idx3Pad3_uid159_alignmentShifter_uid17_fpAccTest_q & rightShiftStage3Idx3Rng3_uid158_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid104_zeroCounter_uid37_fpAccTest(CONSTANT,103)
    zs_uid104_zeroCounter_uid37_fpAccTest_q <= "00";

    -- rightShiftStage3Idx2Rng2_uid155_alignmentShifter_uid17_fpAccTest(BITSELECT,154)@1
    rightShiftStage3Idx2Rng2_uid155_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage2_uid151_alignmentShifter_uid17_fpAccTest_q(200 downto 2);

    -- rightShiftStage3Idx2_uid157_alignmentShifter_uid17_fpAccTest(BITJOIN,156)@1
    rightShiftStage3Idx2_uid157_alignmentShifter_uid17_fpAccTest_q <= zs_uid104_zeroCounter_uid37_fpAccTest_q & rightShiftStage3Idx2Rng2_uid155_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage3Idx1Rng1_uid152_alignmentShifter_uid17_fpAccTest(BITSELECT,151)@1
    rightShiftStage3Idx1Rng1_uid152_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage2_uid151_alignmentShifter_uid17_fpAccTest_q(200 downto 1);

    -- rightShiftStage3Idx1_uid154_alignmentShifter_uid17_fpAccTest(BITJOIN,153)@1
    rightShiftStage3Idx1_uid154_alignmentShifter_uid17_fpAccTest_q <= GND_q & rightShiftStage3Idx1Rng1_uid152_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage2Idx3Pad12_uid148_alignmentShifter_uid17_fpAccTest(CONSTANT,147)
    rightShiftStage2Idx3Pad12_uid148_alignmentShifter_uid17_fpAccTest_q <= "000000000000";

    -- rightShiftStage2Idx3Rng12_uid147_alignmentShifter_uid17_fpAccTest(BITSELECT,146)@1
    rightShiftStage2Idx3Rng12_uid147_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage1_uid140_alignmentShifter_uid17_fpAccTest_q(200 downto 12);

    -- rightShiftStage2Idx3_uid149_alignmentShifter_uid17_fpAccTest(BITJOIN,148)@1
    rightShiftStage2Idx3_uid149_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage2Idx3Pad12_uid148_alignmentShifter_uid17_fpAccTest_q & rightShiftStage2Idx3Rng12_uid147_alignmentShifter_uid17_fpAccTest_b;

    -- zeroExponent_uid42_fpAccTest(CONSTANT,41)
    zeroExponent_uid42_fpAccTest_q <= "00000000";

    -- rightShiftStage2Idx2Rng8_uid144_alignmentShifter_uid17_fpAccTest(BITSELECT,143)@1
    rightShiftStage2Idx2Rng8_uid144_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage1_uid140_alignmentShifter_uid17_fpAccTest_q(200 downto 8);

    -- rightShiftStage2Idx2_uid146_alignmentShifter_uid17_fpAccTest(BITJOIN,145)@1
    rightShiftStage2Idx2_uid146_alignmentShifter_uid17_fpAccTest_q <= zeroExponent_uid42_fpAccTest_q & rightShiftStage2Idx2Rng8_uid144_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid98_zeroCounter_uid37_fpAccTest(CONSTANT,97)
    zs_uid98_zeroCounter_uid37_fpAccTest_q <= "0000";

    -- rightShiftStage2Idx1Rng4_uid141_alignmentShifter_uid17_fpAccTest(BITSELECT,140)@1
    rightShiftStage2Idx1Rng4_uid141_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage1_uid140_alignmentShifter_uid17_fpAccTest_q(200 downto 4);

    -- rightShiftStage2Idx1_uid143_alignmentShifter_uid17_fpAccTest(BITJOIN,142)@1
    rightShiftStage2Idx1_uid143_alignmentShifter_uid17_fpAccTest_q <= zs_uid98_zeroCounter_uid37_fpAccTest_q & rightShiftStage2Idx1Rng4_uid141_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage1Idx3Pad48_uid137_alignmentShifter_uid17_fpAccTest(CONSTANT,136)
    rightShiftStage1Idx3Pad48_uid137_alignmentShifter_uid17_fpAccTest_q <= "000000000000000000000000000000000000000000000000";

    -- rightShiftStage1Idx3Rng48_uid136_alignmentShifter_uid17_fpAccTest(BITSELECT,135)@1
    rightShiftStage1Idx3Rng48_uid136_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_q(200 downto 48);

    -- rightShiftStage1Idx3_uid138_alignmentShifter_uid17_fpAccTest(BITJOIN,137)@1
    rightShiftStage1Idx3_uid138_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1Idx3Pad48_uid137_alignmentShifter_uid17_fpAccTest_q & rightShiftStage1Idx3Rng48_uid136_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid80_zeroCounter_uid37_fpAccTest(CONSTANT,79)
    zs_uid80_zeroCounter_uid37_fpAccTest_q <= "00000000000000000000000000000000";

    -- rightShiftStage1Idx2Rng32_uid133_alignmentShifter_uid17_fpAccTest(BITSELECT,132)@1
    rightShiftStage1Idx2Rng32_uid133_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_q(200 downto 32);

    -- rightShiftStage1Idx2_uid135_alignmentShifter_uid17_fpAccTest(BITJOIN,134)@1
    rightShiftStage1Idx2_uid135_alignmentShifter_uid17_fpAccTest_q <= zs_uid80_zeroCounter_uid37_fpAccTest_q & rightShiftStage1Idx2Rng32_uid133_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid86_zeroCounter_uid37_fpAccTest(CONSTANT,85)
    zs_uid86_zeroCounter_uid37_fpAccTest_q <= "0000000000000000";

    -- rightShiftStage1Idx1Rng16_uid130_alignmentShifter_uid17_fpAccTest(BITSELECT,129)@1
    rightShiftStage1Idx1Rng16_uid130_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_q(200 downto 16);

    -- rightShiftStage1Idx1_uid132_alignmentShifter_uid17_fpAccTest(BITJOIN,131)@1
    rightShiftStage1Idx1_uid132_alignmentShifter_uid17_fpAccTest_q <= zs_uid86_zeroCounter_uid37_fpAccTest_q & rightShiftStage1Idx1Rng16_uid130_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage0Idx3Pad192_uid126_alignmentShifter_uid17_fpAccTest(CONSTANT,125)
    rightShiftStage0Idx3Pad192_uid126_alignmentShifter_uid17_fpAccTest_q <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- rightShiftStage0Idx3Rng192_uid125_alignmentShifter_uid17_fpAccTest(BITSELECT,124)@1
    rightShiftStage0Idx3Rng192_uid125_alignmentShifter_uid17_fpAccTest_b <= rightPaddedIn_uid18_fpAccTest_q(200 downto 192);

    -- rightShiftStage0Idx3_uid127_alignmentShifter_uid17_fpAccTest(BITJOIN,126)@1
    rightShiftStage0Idx3_uid127_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0Idx3Pad192_uid126_alignmentShifter_uid17_fpAccTest_q & rightShiftStage0Idx3Rng192_uid125_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid66_zeroCounter_uid37_fpAccTest(CONSTANT,65)
    zs_uid66_zeroCounter_uid37_fpAccTest_q <= "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- rightShiftStage0Idx2Rng128_uid122_alignmentShifter_uid17_fpAccTest(BITSELECT,121)@1
    rightShiftStage0Idx2Rng128_uid122_alignmentShifter_uid17_fpAccTest_b <= rightPaddedIn_uid18_fpAccTest_q(200 downto 128);

    -- rightShiftStage0Idx2_uid124_alignmentShifter_uid17_fpAccTest(BITJOIN,123)@1
    rightShiftStage0Idx2_uid124_alignmentShifter_uid17_fpAccTest_q <= zs_uid66_zeroCounter_uid37_fpAccTest_q & rightShiftStage0Idx2Rng128_uid122_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid74_zeroCounter_uid37_fpAccTest(CONSTANT,73)
    zs_uid74_zeroCounter_uid37_fpAccTest_q <= "0000000000000000000000000000000000000000000000000000000000000000";

    -- rightShiftStage0Idx1Rng64_uid119_alignmentShifter_uid17_fpAccTest(BITSELECT,118)@1
    rightShiftStage0Idx1Rng64_uid119_alignmentShifter_uid17_fpAccTest_b <= rightPaddedIn_uid18_fpAccTest_q(200 downto 64);

    -- rightShiftStage0Idx1_uid121_alignmentShifter_uid17_fpAccTest(BITJOIN,120)@1
    rightShiftStage0Idx1_uid121_alignmentShifter_uid17_fpAccTest_q <= zs_uid74_zeroCounter_uid37_fpAccTest_q & rightShiftStage0Idx1Rng64_uid119_alignmentShifter_uid17_fpAccTest_b;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- fracX_uid7_fpAccTest(BITSELECT,6)@0
    fracX_uid7_fpAccTest_b <= x(22 downto 0);

    -- redist17_fracX_uid7_fpAccTest_b_1(DELAY,236)
    redist17_fracX_uid7_fpAccTest_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => fracX_uid7_fpAccTest_b, xout => redist17_fracX_uid7_fpAccTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- oFracX_uid10_fpAccTest(BITJOIN,9)@1
    oFracX_uid10_fpAccTest_q <= VCC_q & redist17_fracX_uid7_fpAccTest_b_1_q;

    -- padConst_uid17_fpAccTest(CONSTANT,16)
    padConst_uid17_fpAccTest_q <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- rightPaddedIn_uid18_fpAccTest(BITJOIN,17)@1
    rightPaddedIn_uid18_fpAccTest_q <= oFracX_uid10_fpAccTest_q & padConst_uid17_fpAccTest_q;

    -- expX_uid6_fpAccTest(BITSELECT,5)@0
    expX_uid6_fpAccTest_b <= x(30 downto 23);

    -- rShiftConstant_uid15_fpAccTest(CONSTANT,14)
    rShiftConstant_uid15_fpAccTest_q <= "010110001";

    -- rightShiftValue_uid16_fpAccTest(SUB,15)@0
    rightShiftValue_uid16_fpAccTest_a <= STD_LOGIC_VECTOR("0" & rShiftConstant_uid15_fpAccTest_q);
    rightShiftValue_uid16_fpAccTest_b <= STD_LOGIC_VECTOR("00" & expX_uid6_fpAccTest_b);
    rightShiftValue_uid16_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(rightShiftValue_uid16_fpAccTest_a) - UNSIGNED(rightShiftValue_uid16_fpAccTest_b));
    rightShiftValue_uid16_fpAccTest_q <= rightShiftValue_uid16_fpAccTest_o(9 downto 0);

    -- rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select(BITSELECT,210)@0
    rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_in <= rightShiftValue_uid16_fpAccTest_q(7 downto 0);
    rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_b <= rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_in(7 downto 6);
    rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_c <= rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_in(5 downto 4);
    rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_d <= rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_in(3 downto 2);
    rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_e <= rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_in(1 downto 0);

    -- redist0_rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_b_1(DELAY,219)
    redist0_rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_b, xout => redist0_rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest(MUX,128)@1
    rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_s <= redist0_rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_b_1_q;
    rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_s, en, rightPaddedIn_uid18_fpAccTest_q, rightShiftStage0Idx1_uid121_alignmentShifter_uid17_fpAccTest_q, rightShiftStage0Idx2_uid124_alignmentShifter_uid17_fpAccTest_q, rightShiftStage0Idx3_uid127_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "00" => rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_q <= rightPaddedIn_uid18_fpAccTest_q;
            WHEN "01" => rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0Idx1_uid121_alignmentShifter_uid17_fpAccTest_q;
            WHEN "10" => rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0Idx2_uid124_alignmentShifter_uid17_fpAccTest_q;
            WHEN "11" => rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0Idx3_uid127_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist1_rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_c_1(DELAY,220)
    redist1_rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_c, xout => redist1_rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => areset );

    -- rightShiftStage1_uid140_alignmentShifter_uid17_fpAccTest(MUX,139)@1
    rightShiftStage1_uid140_alignmentShifter_uid17_fpAccTest_s <= redist1_rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_c_1_q;
    rightShiftStage1_uid140_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (rightShiftStage1_uid140_alignmentShifter_uid17_fpAccTest_s, en, rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_q, rightShiftStage1Idx1_uid132_alignmentShifter_uid17_fpAccTest_q, rightShiftStage1Idx2_uid135_alignmentShifter_uid17_fpAccTest_q, rightShiftStage1Idx3_uid138_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (rightShiftStage1_uid140_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "00" => rightShiftStage1_uid140_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0_uid129_alignmentShifter_uid17_fpAccTest_q;
            WHEN "01" => rightShiftStage1_uid140_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1Idx1_uid132_alignmentShifter_uid17_fpAccTest_q;
            WHEN "10" => rightShiftStage1_uid140_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1Idx2_uid135_alignmentShifter_uid17_fpAccTest_q;
            WHEN "11" => rightShiftStage1_uid140_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1Idx3_uid138_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => rightShiftStage1_uid140_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist2_rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_d_1(DELAY,221)
    redist2_rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_d_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_d, xout => redist2_rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_d_1_q, ena => en(0), clk => clk, aclr => areset );

    -- rightShiftStage2_uid151_alignmentShifter_uid17_fpAccTest(MUX,150)@1
    rightShiftStage2_uid151_alignmentShifter_uid17_fpAccTest_s <= redist2_rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_d_1_q;
    rightShiftStage2_uid151_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (rightShiftStage2_uid151_alignmentShifter_uid17_fpAccTest_s, en, rightShiftStage1_uid140_alignmentShifter_uid17_fpAccTest_q, rightShiftStage2Idx1_uid143_alignmentShifter_uid17_fpAccTest_q, rightShiftStage2Idx2_uid146_alignmentShifter_uid17_fpAccTest_q, rightShiftStage2Idx3_uid149_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (rightShiftStage2_uid151_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "00" => rightShiftStage2_uid151_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1_uid140_alignmentShifter_uid17_fpAccTest_q;
            WHEN "01" => rightShiftStage2_uid151_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage2Idx1_uid143_alignmentShifter_uid17_fpAccTest_q;
            WHEN "10" => rightShiftStage2_uid151_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage2Idx2_uid146_alignmentShifter_uid17_fpAccTest_q;
            WHEN "11" => rightShiftStage2_uid151_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage2Idx3_uid149_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => rightShiftStage2_uid151_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist3_rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_e_1(DELAY,222)
    redist3_rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_e_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_e, xout => redist3_rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_e_1_q, ena => en(0), clk => clk, aclr => areset );

    -- rightShiftStage3_uid162_alignmentShifter_uid17_fpAccTest(MUX,161)@1 + 1
    rightShiftStage3_uid162_alignmentShifter_uid17_fpAccTest_s <= redist3_rightShiftStageSel7Dto6_uid128_alignmentShifter_uid17_fpAccTest_merged_bit_select_e_1_q;
    rightShiftStage3_uid162_alignmentShifter_uid17_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            rightShiftStage3_uid162_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (rightShiftStage3_uid162_alignmentShifter_uid17_fpAccTest_s) IS
                    WHEN "00" => rightShiftStage3_uid162_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage2_uid151_alignmentShifter_uid17_fpAccTest_q;
                    WHEN "01" => rightShiftStage3_uid162_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage3Idx1_uid154_alignmentShifter_uid17_fpAccTest_q;
                    WHEN "10" => rightShiftStage3_uid162_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage3Idx2_uid157_alignmentShifter_uid17_fpAccTest_q;
                    WHEN "11" => rightShiftStage3_uid162_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage3Idx3_uid160_alignmentShifter_uid17_fpAccTest_q;
                    WHEN OTHERS => rightShiftStage3_uid162_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- wIntCst_uid117_alignmentShifter_uid17_fpAccTest(CONSTANT,116)
    wIntCst_uid117_alignmentShifter_uid17_fpAccTest_q <= "11001001";

    -- shiftedOut_uid118_alignmentShifter_uid17_fpAccTest(COMPARE,117)@0 + 1
    shiftedOut_uid118_alignmentShifter_uid17_fpAccTest_a <= STD_LOGIC_VECTOR("00" & rightShiftValue_uid16_fpAccTest_q);
    shiftedOut_uid118_alignmentShifter_uid17_fpAccTest_b <= STD_LOGIC_VECTOR("0000" & wIntCst_uid117_alignmentShifter_uid17_fpAccTest_q);
    shiftedOut_uid118_alignmentShifter_uid17_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            shiftedOut_uid118_alignmentShifter_uid17_fpAccTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                shiftedOut_uid118_alignmentShifter_uid17_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid118_alignmentShifter_uid17_fpAccTest_a) - UNSIGNED(shiftedOut_uid118_alignmentShifter_uid17_fpAccTest_b));
            END IF;
        END IF;
    END PROCESS;
    shiftedOut_uid118_alignmentShifter_uid17_fpAccTest_n(0) <= not (shiftedOut_uid118_alignmentShifter_uid17_fpAccTest_o(11));

    -- redist4_shiftedOut_uid118_alignmentShifter_uid17_fpAccTest_n_2(DELAY,223)
    redist4_shiftedOut_uid118_alignmentShifter_uid17_fpAccTest_n_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => shiftedOut_uid118_alignmentShifter_uid17_fpAccTest_n, xout => redist4_shiftedOut_uid118_alignmentShifter_uid17_fpAccTest_n_2_q, ena => en(0), clk => clk, aclr => areset );

    -- r_uid164_alignmentShifter_uid17_fpAccTest(MUX,163)@2
    r_uid164_alignmentShifter_uid17_fpAccTest_s <= redist4_shiftedOut_uid118_alignmentShifter_uid17_fpAccTest_n_2_q;
    r_uid164_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (r_uid164_alignmentShifter_uid17_fpAccTest_s, en, rightShiftStage3_uid162_alignmentShifter_uid17_fpAccTest_q, zeroOutCst_uid163_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (r_uid164_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "0" => r_uid164_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage3_uid162_alignmentShifter_uid17_fpAccTest_q;
            WHEN "1" => r_uid164_alignmentShifter_uid17_fpAccTest_q <= zeroOutCst_uid163_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => r_uid164_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- shiftedFracUpper_uid20_fpAccTest(BITSELECT,19)@2
    shiftedFracUpper_uid20_fpAccTest_b <= r_uid164_alignmentShifter_uid17_fpAccTest_q(200 downto 24);

    -- extendedAlignedShiftedFrac_uid21_fpAccTest(BITJOIN,20)@2
    extendedAlignedShiftedFrac_uid21_fpAccTest_q <= GND_q & shiftedFracUpper_uid20_fpAccTest_b;

    -- onesComplementExtendedFrac_uid22_fpAccTest(LOGICAL,21)@2
    onesComplementExtendedFrac_uid22_fpAccTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((177 downto 1 => redist16_signX_uid8_fpAccTest_b_2_q(0)) & redist16_signX_uid8_fpAccTest_b_2_q));
    onesComplementExtendedFrac_uid22_fpAccTest_q <= extendedAlignedShiftedFrac_uid21_fpAccTest_q xor onesComplementExtendedFrac_uid22_fpAccTest_b;

    -- accumulator_uid24_fpAccTest(ADD,23)@2 + 1
    accumulator_uid24_fpAccTest_cin <= redist16_signX_uid8_fpAccTest_b_2_q;
    accumulator_uid24_fpAccTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((180 downto 179 => sum_uid27_fpAccTest_b(178)) & sum_uid27_fpAccTest_b) & '1');
    accumulator_uid24_fpAccTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((180 downto 178 => onesComplementExtendedFrac_uid22_fpAccTest_q(177)) & onesComplementExtendedFrac_uid22_fpAccTest_q) & accumulator_uid24_fpAccTest_cin(0));
    accumulator_uid24_fpAccTest_i <= accumulator_uid24_fpAccTest_b;
    accumulator_uid24_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            accumulator_uid24_fpAccTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                IF (redist18_xIn_n_2_q = "1") THEN
                    accumulator_uid24_fpAccTest_o <= accumulator_uid24_fpAccTest_i;
                ELSE
                    accumulator_uid24_fpAccTest_o <= STD_LOGIC_VECTOR(SIGNED(accumulator_uid24_fpAccTest_a) + SIGNED(accumulator_uid24_fpAccTest_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    accumulator_uid24_fpAccTest_c(0) <= accumulator_uid24_fpAccTest_o(181);
    accumulator_uid24_fpAccTest_q <= accumulator_uid24_fpAccTest_o(180 downto 1);

    -- os_uid25_fpAccTest(BITJOIN,24)@3
    os_uid25_fpAccTest_q <= accumulator_uid24_fpAccTest_c & accumulator_uid24_fpAccTest_q;

    -- osr_uid26_fpAccTest(BITSELECT,25)@3
    osr_uid26_fpAccTest_in <= STD_LOGIC_VECTOR(os_uid25_fpAccTest_q(179 downto 0));
    osr_uid26_fpAccTest_b <= STD_LOGIC_VECTOR(osr_uid26_fpAccTest_in(179 downto 0));

    -- sum_uid27_fpAccTest(BITSELECT,26)@3
    sum_uid27_fpAccTest_in <= STD_LOGIC_VECTOR(osr_uid26_fpAccTest_b(178 downto 0));
    sum_uid27_fpAccTest_b <= STD_LOGIC_VECTOR(sum_uid27_fpAccTest_in(178 downto 0));

    -- accumulatorSign_uid29_fpAccTest(BITSELECT,28)@3
    accumulatorSign_uid29_fpAccTest_in <= sum_uid27_fpAccTest_b(177 downto 0);
    accumulatorSign_uid29_fpAccTest_b <= accumulatorSign_uid29_fpAccTest_in(177 downto 177);

    -- accOverflowBitMSB_uid30_fpAccTest(BITSELECT,29)@3
    accOverflowBitMSB_uid30_fpAccTest_b <= sum_uid27_fpAccTest_b(178 downto 178);

    -- accOverflow_uid32_fpAccTest(LOGICAL,31)@3
    accOverflow_uid32_fpAccTest_q <= accOverflowBitMSB_uid30_fpAccTest_b xor accumulatorSign_uid29_fpAccTest_b;

    -- muxAccOverflowFeedbackSignal_uid61_fpAccTest(MUX,60)@2 + 1
    muxAccOverflowFeedbackSignal_uid61_fpAccTest_s <= redist18_xIn_n_2_q;
    muxAccOverflowFeedbackSignal_uid61_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            muxAccOverflowFeedbackSignal_uid61_fpAccTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (muxAccOverflowFeedbackSignal_uid61_fpAccTest_s) IS
                    WHEN "0" => muxAccOverflowFeedbackSignal_uid61_fpAccTest_q <= oRAccOverflowFlagFeedback_uid62_fpAccTest_q;
                    WHEN "1" => muxAccOverflowFeedbackSignal_uid61_fpAccTest_q <= GND_q;
                    WHEN OTHERS => muxAccOverflowFeedbackSignal_uid61_fpAccTest_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- oRAccOverflowFlagFeedback_uid62_fpAccTest(LOGICAL,61)@3
    oRAccOverflowFlagFeedback_uid62_fpAccTest_q <= muxAccOverflowFeedbackSignal_uid61_fpAccTest_q or accOverflow_uid32_fpAccTest_q;

    -- redist10_oRAccOverflowFlagFeedback_uid62_fpAccTest_q_4(DELAY,229)
    redist10_oRAccOverflowFlagFeedback_uid62_fpAccTest_q_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 4, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRAccOverflowFlagFeedback_uid62_fpAccTest_q, xout => redist10_oRAccOverflowFlagFeedback_uid62_fpAccTest_q_4_q, ena => en(0), clk => clk, aclr => areset );

    -- expNotZero_uid56_fpAccTest(LOGICAL,55)@0
    expNotZero_uid56_fpAccTest_q <= "1" WHEN expX_uid6_fpAccTest_b /= "00000000" ELSE "0";

    -- underflowCond_uid57_fpAccTest(LOGICAL,56)@0
    underflowCond_uid57_fpAccTest_q <= GND_q and expNotZero_uid56_fpAccTest_q;

    -- muxXUnderflowFeedbackSignal_uid55_fpAccTest(MUX,54)@0
    muxXUnderflowFeedbackSignal_uid55_fpAccTest_s <= n;
    muxXUnderflowFeedbackSignal_uid55_fpAccTest_combproc: PROCESS (muxXUnderflowFeedbackSignal_uid55_fpAccTest_s, en, oRXUnderflowFlagFeedback_uid58_fpAccTest_q, GND_q)
    BEGIN
        CASE (muxXUnderflowFeedbackSignal_uid55_fpAccTest_s) IS
            WHEN "0" => muxXUnderflowFeedbackSignal_uid55_fpAccTest_q <= oRXUnderflowFlagFeedback_uid58_fpAccTest_q;
            WHEN "1" => muxXUnderflowFeedbackSignal_uid55_fpAccTest_q <= GND_q;
            WHEN OTHERS => muxXUnderflowFeedbackSignal_uid55_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oRXUnderflowFlagFeedback_uid58_fpAccTest(LOGICAL,57)@0 + 1
    oRXUnderflowFlagFeedback_uid58_fpAccTest_qi <= muxXUnderflowFeedbackSignal_uid55_fpAccTest_q or underflowCond_uid57_fpAccTest_q;
    oRXUnderflowFlagFeedback_uid58_fpAccTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRXUnderflowFlagFeedback_uid58_fpAccTest_qi, xout => oRXUnderflowFlagFeedback_uid58_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist11_oRXUnderflowFlagFeedback_uid58_fpAccTest_q_7(DELAY,230)
    redist11_oRXUnderflowFlagFeedback_uid58_fpAccTest_q_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRXUnderflowFlagFeedback_uid58_fpAccTest_q, xout => redist11_oRXUnderflowFlagFeedback_uid58_fpAccTest_q_7_q, ena => en(0), clk => clk, aclr => areset );

    -- expGTMaxMSBX_uid13_fpAccTest(CONSTANT,12)
    expGTMaxMSBX_uid13_fpAccTest_q <= "10110001";

    -- cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest(COMPARE,13)@0 + 1
    cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_a <= STD_LOGIC_VECTOR("00" & expGTMaxMSBX_uid13_fpAccTest_q);
    cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_b <= STD_LOGIC_VECTOR("00" & expX_uid6_fpAccTest_b);
    cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_a) - UNSIGNED(cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_b));
            END IF;
        END IF;
    END PROCESS;
    cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c(0) <= cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_o(9);

    -- redist15_cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c_2(DELAY,234)
    redist15_cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c, xout => redist15_cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c_2_q, ena => en(0), clk => clk, aclr => areset );

    -- muxXOverflowFeedbackSignal_uid51_fpAccTest(MUX,50)@2
    muxXOverflowFeedbackSignal_uid51_fpAccTest_s <= redist18_xIn_n_2_q;
    muxXOverflowFeedbackSignal_uid51_fpAccTest_combproc: PROCESS (muxXOverflowFeedbackSignal_uid51_fpAccTest_s, en, oRXOverflowFlagFeedback_uid52_fpAccTest_q, GND_q)
    BEGIN
        CASE (muxXOverflowFeedbackSignal_uid51_fpAccTest_s) IS
            WHEN "0" => muxXOverflowFeedbackSignal_uid51_fpAccTest_q <= oRXOverflowFlagFeedback_uid52_fpAccTest_q;
            WHEN "1" => muxXOverflowFeedbackSignal_uid51_fpAccTest_q <= GND_q;
            WHEN OTHERS => muxXOverflowFeedbackSignal_uid51_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oRXOverflowFlagFeedback_uid52_fpAccTest(LOGICAL,51)@2 + 1
    oRXOverflowFlagFeedback_uid52_fpAccTest_qi <= muxXOverflowFeedbackSignal_uid51_fpAccTest_q or redist15_cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c_2_q;
    oRXOverflowFlagFeedback_uid52_fpAccTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRXOverflowFlagFeedback_uid52_fpAccTest_qi, xout => oRXOverflowFlagFeedback_uid52_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist12_oRXOverflowFlagFeedback_uid52_fpAccTest_q_5(DELAY,231)
    redist12_oRXOverflowFlagFeedback_uid52_fpAccTest_q_5 : dspba_delay
    GENERIC MAP ( width => 1, depth => 4, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRXOverflowFlagFeedback_uid52_fpAccTest_q, xout => redist12_oRXOverflowFlagFeedback_uid52_fpAccTest_q_5_q, ena => en(0), clk => clk, aclr => areset );

    -- redist14_accumulatorSign_uid29_fpAccTest_b_4(DELAY,233)
    redist14_accumulatorSign_uid29_fpAccTest_b_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 4, reset_kind => "ASYNC" )
    PORT MAP ( xin => accumulatorSign_uid29_fpAccTest_b, xout => redist14_accumulatorSign_uid29_fpAccTest_b_4_q, ena => en(0), clk => clk, aclr => areset );

    -- accValidRange_uid33_fpAccTest(BITSELECT,32)@3
    accValidRange_uid33_fpAccTest_in <= sum_uid27_fpAccTest_b(177 downto 0);
    accValidRange_uid33_fpAccTest_b <= accValidRange_uid33_fpAccTest_in(177 downto 0);

    -- accOnesComplement_uid34_fpAccTest(LOGICAL,33)@3
    accOnesComplement_uid34_fpAccTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((177 downto 1 => accumulatorSign_uid29_fpAccTest_b(0)) & accumulatorSign_uid29_fpAccTest_b));
    accOnesComplement_uid34_fpAccTest_q <= accValidRange_uid33_fpAccTest_b xor accOnesComplement_uid34_fpAccTest_b;

    -- accValuePositive_uid35_fpAccTest(ADD,34)@3 + 1
    accValuePositive_uid35_fpAccTest_a <= STD_LOGIC_VECTOR("0" & accOnesComplement_uid34_fpAccTest_q);
    accValuePositive_uid35_fpAccTest_b <= STD_LOGIC_VECTOR("0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & accumulatorSign_uid29_fpAccTest_b);
    accValuePositive_uid35_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            accValuePositive_uid35_fpAccTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                accValuePositive_uid35_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(accValuePositive_uid35_fpAccTest_a) + UNSIGNED(accValuePositive_uid35_fpAccTest_b));
            END IF;
        END IF;
    END PROCESS;
    accValuePositive_uid35_fpAccTest_q <= accValuePositive_uid35_fpAccTest_o(178 downto 0);

    -- posAccWoLeadingZeroBit_uid36_fpAccTest(BITSELECT,35)@4
    posAccWoLeadingZeroBit_uid36_fpAccTest_in <= accValuePositive_uid35_fpAccTest_q(176 downto 0);
    posAccWoLeadingZeroBit_uid36_fpAccTest_b <= posAccWoLeadingZeroBit_uid36_fpAccTest_in(176 downto 0);

    -- rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,211)@4
    rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= posAccWoLeadingZeroBit_uid36_fpAccTest_b(176 downto 49);
    rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= posAccWoLeadingZeroBit_uid36_fpAccTest_b(48 downto 0);

    -- vCount_uid68_zeroCounter_uid37_fpAccTest(LOGICAL,67)@4
    vCount_uid68_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid66_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- redist9_vCount_uid68_zeroCounter_uid37_fpAccTest_q_2(DELAY,228)
    redist9_vCount_uid68_zeroCounter_uid37_fpAccTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid68_zeroCounter_uid37_fpAccTest_q, xout => redist9_vCount_uid68_zeroCounter_uid37_fpAccTest_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- mO_uid69_zeroCounter_uid37_fpAccTest(CONSTANT,68)
    mO_uid69_zeroCounter_uid37_fpAccTest_q <= "1111111111111111111111111111111111111111111111111111111111111111111111111111111";

    -- cStage_uid71_zeroCounter_uid37_fpAccTest(BITJOIN,70)@4
    cStage_uid71_zeroCounter_uid37_fpAccTest_q <= rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_c & mO_uid69_zeroCounter_uid37_fpAccTest_q;

    -- vStagei_uid73_zeroCounter_uid37_fpAccTest(MUX,72)@4
    vStagei_uid73_zeroCounter_uid37_fpAccTest_s <= vCount_uid68_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid73_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid73_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b, cStage_uid71_zeroCounter_uid37_fpAccTest_q)
    BEGIN
        CASE (vStagei_uid73_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid73_zeroCounter_uid37_fpAccTest_q <= rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid73_zeroCounter_uid37_fpAccTest_q <= cStage_uid71_zeroCounter_uid37_fpAccTest_q;
            WHEN OTHERS => vStagei_uid73_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,212)@4
    rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid73_zeroCounter_uid37_fpAccTest_q(127 downto 64);
    rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid73_zeroCounter_uid37_fpAccTest_q(63 downto 0);

    -- vCount_uid76_zeroCounter_uid37_fpAccTest(LOGICAL,75)@4
    vCount_uid76_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid74_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- redist8_vCount_uid76_zeroCounter_uid37_fpAccTest_q_2(DELAY,227)
    redist8_vCount_uid76_zeroCounter_uid37_fpAccTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid76_zeroCounter_uid37_fpAccTest_q, xout => redist8_vCount_uid76_zeroCounter_uid37_fpAccTest_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid79_zeroCounter_uid37_fpAccTest(MUX,78)@4 + 1
    vStagei_uid79_zeroCounter_uid37_fpAccTest_s <= vCount_uid76_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid79_zeroCounter_uid37_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            vStagei_uid79_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (vStagei_uid79_zeroCounter_uid37_fpAccTest_s) IS
                    WHEN "0" => vStagei_uid79_zeroCounter_uid37_fpAccTest_q <= rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
                    WHEN "1" => vStagei_uid79_zeroCounter_uid37_fpAccTest_q <= rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
                    WHEN OTHERS => vStagei_uid79_zeroCounter_uid37_fpAccTest_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,213)@5
    rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid79_zeroCounter_uid37_fpAccTest_q(63 downto 32);
    rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid79_zeroCounter_uid37_fpAccTest_q(31 downto 0);

    -- vCount_uid82_zeroCounter_uid37_fpAccTest(LOGICAL,81)@5
    vCount_uid82_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid80_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- redist7_vCount_uid82_zeroCounter_uid37_fpAccTest_q_1(DELAY,226)
    redist7_vCount_uid82_zeroCounter_uid37_fpAccTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid82_zeroCounter_uid37_fpAccTest_q, xout => redist7_vCount_uid82_zeroCounter_uid37_fpAccTest_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid85_zeroCounter_uid37_fpAccTest(MUX,84)@5
    vStagei_uid85_zeroCounter_uid37_fpAccTest_s <= vCount_uid82_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid85_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid85_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid85_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid85_zeroCounter_uid37_fpAccTest_q <= rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid85_zeroCounter_uid37_fpAccTest_q <= rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid85_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,214)@5
    rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid85_zeroCounter_uid37_fpAccTest_q(31 downto 16);
    rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid85_zeroCounter_uid37_fpAccTest_q(15 downto 0);

    -- vCount_uid88_zeroCounter_uid37_fpAccTest(LOGICAL,87)@5
    vCount_uid88_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid86_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- redist6_vCount_uid88_zeroCounter_uid37_fpAccTest_q_1(DELAY,225)
    redist6_vCount_uid88_zeroCounter_uid37_fpAccTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid88_zeroCounter_uid37_fpAccTest_q, xout => redist6_vCount_uid88_zeroCounter_uid37_fpAccTest_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid91_zeroCounter_uid37_fpAccTest(MUX,90)@5 + 1
    vStagei_uid91_zeroCounter_uid37_fpAccTest_s <= vCount_uid88_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid91_zeroCounter_uid37_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            vStagei_uid91_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (vStagei_uid91_zeroCounter_uid37_fpAccTest_s) IS
                    WHEN "0" => vStagei_uid91_zeroCounter_uid37_fpAccTest_q <= rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
                    WHEN "1" => vStagei_uid91_zeroCounter_uid37_fpAccTest_q <= rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
                    WHEN OTHERS => vStagei_uid91_zeroCounter_uid37_fpAccTest_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,215)@6
    rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid91_zeroCounter_uid37_fpAccTest_q(15 downto 8);
    rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid91_zeroCounter_uid37_fpAccTest_q(7 downto 0);

    -- vCount_uid94_zeroCounter_uid37_fpAccTest(LOGICAL,93)@6
    vCount_uid94_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zeroExponent_uid42_fpAccTest_q ELSE "0";

    -- vStagei_uid97_zeroCounter_uid37_fpAccTest(MUX,96)@6
    vStagei_uid97_zeroCounter_uid37_fpAccTest_s <= vCount_uid94_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid97_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid97_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid97_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid97_zeroCounter_uid37_fpAccTest_q <= rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid97_zeroCounter_uid37_fpAccTest_q <= rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid97_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,216)@6
    rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid97_zeroCounter_uid37_fpAccTest_q(7 downto 4);
    rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid97_zeroCounter_uid37_fpAccTest_q(3 downto 0);

    -- vCount_uid100_zeroCounter_uid37_fpAccTest(LOGICAL,99)@6
    vCount_uid100_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid98_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- vStagei_uid103_zeroCounter_uid37_fpAccTest(MUX,102)@6
    vStagei_uid103_zeroCounter_uid37_fpAccTest_s <= vCount_uid100_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid103_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid103_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid103_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid103_zeroCounter_uid37_fpAccTest_q <= rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid103_zeroCounter_uid37_fpAccTest_q <= rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid103_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,217)@6
    rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid103_zeroCounter_uid37_fpAccTest_q(3 downto 2);
    rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid103_zeroCounter_uid37_fpAccTest_q(1 downto 0);

    -- vCount_uid106_zeroCounter_uid37_fpAccTest(LOGICAL,105)@6
    vCount_uid106_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid104_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- vStagei_uid109_zeroCounter_uid37_fpAccTest(MUX,108)@6
    vStagei_uid109_zeroCounter_uid37_fpAccTest_s <= vCount_uid106_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid109_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid109_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid109_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid109_zeroCounter_uid37_fpAccTest_q <= rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid109_zeroCounter_uid37_fpAccTest_q <= rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid109_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid111_zeroCounter_uid37_fpAccTest(BITSELECT,110)@6
    rVStage_uid111_zeroCounter_uid37_fpAccTest_b <= vStagei_uid109_zeroCounter_uid37_fpAccTest_q(1 downto 1);

    -- vCount_uid112_zeroCounter_uid37_fpAccTest(LOGICAL,111)@6
    vCount_uid112_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid111_zeroCounter_uid37_fpAccTest_b = GND_q ELSE "0";

    -- r_uid113_zeroCounter_uid37_fpAccTest(BITJOIN,112)@6
    r_uid113_zeroCounter_uid37_fpAccTest_q <= redist9_vCount_uid68_zeroCounter_uid37_fpAccTest_q_2_q & redist8_vCount_uid76_zeroCounter_uid37_fpAccTest_q_2_q & redist7_vCount_uid82_zeroCounter_uid37_fpAccTest_q_1_q & redist6_vCount_uid88_zeroCounter_uid37_fpAccTest_q_1_q & vCount_uid94_zeroCounter_uid37_fpAccTest_q & vCount_uid100_zeroCounter_uid37_fpAccTest_q & vCount_uid106_zeroCounter_uid37_fpAccTest_q & vCount_uid112_zeroCounter_uid37_fpAccTest_q;

    -- redist5_r_uid113_zeroCounter_uid37_fpAccTest_q_1(DELAY,224)
    redist5_r_uid113_zeroCounter_uid37_fpAccTest_q_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => r_uid113_zeroCounter_uid37_fpAccTest_q, xout => redist5_r_uid113_zeroCounter_uid37_fpAccTest_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- resExpSub_uid43_fpAccTest(SUB,42)@7
    resExpSub_uid43_fpAccTest_a <= STD_LOGIC_VECTOR("0" & rShiftConstant_uid15_fpAccTest_q);
    resExpSub_uid43_fpAccTest_b <= STD_LOGIC_VECTOR("00" & redist5_r_uid113_zeroCounter_uid37_fpAccTest_q_1_q);
    resExpSub_uid43_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(resExpSub_uid43_fpAccTest_a) - UNSIGNED(resExpSub_uid43_fpAccTest_b));
    resExpSub_uid43_fpAccTest_q <= resExpSub_uid43_fpAccTest_o(9 downto 0);

    -- finalExponent_uid44_fpAccTest(BITSELECT,43)@7
    finalExponent_uid44_fpAccTest_in <= resExpSub_uid43_fpAccTest_q(7 downto 0);
    finalExponent_uid44_fpAccTest_b <= finalExponent_uid44_fpAccTest_in(7 downto 0);

    -- accResOutOfExpRange_uid39_fpAccTest(LOGICAL,38)@7
    accResOutOfExpRange_uid39_fpAccTest_q <= "1" WHEN expGTMaxMSBX_uid13_fpAccTest_q = redist5_r_uid113_zeroCounter_uid37_fpAccTest_q_1_q ELSE "0";

    -- finalExpUpdated_uid45_fpAccTest(MUX,44)@7
    finalExpUpdated_uid45_fpAccTest_s <= accResOutOfExpRange_uid39_fpAccTest_q;
    finalExpUpdated_uid45_fpAccTest_combproc: PROCESS (finalExpUpdated_uid45_fpAccTest_s, en, finalExponent_uid44_fpAccTest_b, zeroExponent_uid42_fpAccTest_q)
    BEGIN
        CASE (finalExpUpdated_uid45_fpAccTest_s) IS
            WHEN "0" => finalExpUpdated_uid45_fpAccTest_q <= finalExponent_uid44_fpAccTest_b;
            WHEN "1" => finalExpUpdated_uid45_fpAccTest_q <= zeroExponent_uid42_fpAccTest_q;
            WHEN OTHERS => finalExpUpdated_uid45_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage3Idx3Rng3_uid206_normalizationShifter_uid40_fpAccTest(BITSELECT,205)@7
    leftShiftStage3Idx3Rng3_uid206_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_q(175 downto 0);
    leftShiftStage3Idx3Rng3_uid206_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage3Idx3Rng3_uid206_normalizationShifter_uid40_fpAccTest_in(175 downto 0);

    -- leftShiftStage3Idx3_uid207_normalizationShifter_uid40_fpAccTest(BITJOIN,206)@7
    leftShiftStage3Idx3_uid207_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage3Idx3Rng3_uid206_normalizationShifter_uid40_fpAccTest_b & rightShiftStage3Idx3Pad3_uid159_alignmentShifter_uid17_fpAccTest_q;

    -- leftShiftStage3Idx2Rng2_uid203_normalizationShifter_uid40_fpAccTest(BITSELECT,202)@7
    leftShiftStage3Idx2Rng2_uid203_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_q(176 downto 0);
    leftShiftStage3Idx2Rng2_uid203_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage3Idx2Rng2_uid203_normalizationShifter_uid40_fpAccTest_in(176 downto 0);

    -- leftShiftStage3Idx2_uid204_normalizationShifter_uid40_fpAccTest(BITJOIN,203)@7
    leftShiftStage3Idx2_uid204_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage3Idx2Rng2_uid203_normalizationShifter_uid40_fpAccTest_b & zs_uid104_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage3Idx1Rng1_uid200_normalizationShifter_uid40_fpAccTest(BITSELECT,199)@7
    leftShiftStage3Idx1Rng1_uid200_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_q(177 downto 0);
    leftShiftStage3Idx1Rng1_uid200_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage3Idx1Rng1_uid200_normalizationShifter_uid40_fpAccTest_in(177 downto 0);

    -- leftShiftStage3Idx1_uid201_normalizationShifter_uid40_fpAccTest(BITJOIN,200)@7
    leftShiftStage3Idx1_uid201_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage3Idx1Rng1_uid200_normalizationShifter_uid40_fpAccTest_b & GND_q;

    -- leftShiftStage2Idx3Rng12_uid195_normalizationShifter_uid40_fpAccTest(BITSELECT,194)@7
    leftShiftStage2Idx3Rng12_uid195_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_q(166 downto 0);
    leftShiftStage2Idx3Rng12_uid195_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage2Idx3Rng12_uid195_normalizationShifter_uid40_fpAccTest_in(166 downto 0);

    -- leftShiftStage2Idx3_uid196_normalizationShifter_uid40_fpAccTest(BITJOIN,195)@7
    leftShiftStage2Idx3_uid196_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx3Rng12_uid195_normalizationShifter_uid40_fpAccTest_b & rightShiftStage2Idx3Pad12_uid148_alignmentShifter_uid17_fpAccTest_q;

    -- leftShiftStage2Idx2Rng8_uid192_normalizationShifter_uid40_fpAccTest(BITSELECT,191)@7
    leftShiftStage2Idx2Rng8_uid192_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_q(170 downto 0);
    leftShiftStage2Idx2Rng8_uid192_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage2Idx2Rng8_uid192_normalizationShifter_uid40_fpAccTest_in(170 downto 0);

    -- leftShiftStage2Idx2_uid193_normalizationShifter_uid40_fpAccTest(BITJOIN,192)@7
    leftShiftStage2Idx2_uid193_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx2Rng8_uid192_normalizationShifter_uid40_fpAccTest_b & zeroExponent_uid42_fpAccTest_q;

    -- leftShiftStage2Idx1Rng4_uid189_normalizationShifter_uid40_fpAccTest(BITSELECT,188)@7
    leftShiftStage2Idx1Rng4_uid189_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_q(174 downto 0);
    leftShiftStage2Idx1Rng4_uid189_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage2Idx1Rng4_uid189_normalizationShifter_uid40_fpAccTest_in(174 downto 0);

    -- leftShiftStage2Idx1_uid190_normalizationShifter_uid40_fpAccTest(BITJOIN,189)@7
    leftShiftStage2Idx1_uid190_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx1Rng4_uid189_normalizationShifter_uid40_fpAccTest_b & zs_uid98_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage1Idx3Rng48_uid184_normalizationShifter_uid40_fpAccTest(BITSELECT,183)@7
    leftShiftStage1Idx3Rng48_uid184_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_q(130 downto 0);
    leftShiftStage1Idx3Rng48_uid184_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage1Idx3Rng48_uid184_normalizationShifter_uid40_fpAccTest_in(130 downto 0);

    -- leftShiftStage1Idx3_uid185_normalizationShifter_uid40_fpAccTest(BITJOIN,184)@7
    leftShiftStage1Idx3_uid185_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx3Rng48_uid184_normalizationShifter_uid40_fpAccTest_b & rightShiftStage1Idx3Pad48_uid137_alignmentShifter_uid17_fpAccTest_q;

    -- leftShiftStage1Idx2Rng32_uid181_normalizationShifter_uid40_fpAccTest(BITSELECT,180)@7
    leftShiftStage1Idx2Rng32_uid181_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_q(146 downto 0);
    leftShiftStage1Idx2Rng32_uid181_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage1Idx2Rng32_uid181_normalizationShifter_uid40_fpAccTest_in(146 downto 0);

    -- leftShiftStage1Idx2_uid182_normalizationShifter_uid40_fpAccTest(BITJOIN,181)@7
    leftShiftStage1Idx2_uid182_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx2Rng32_uid181_normalizationShifter_uid40_fpAccTest_b & zs_uid80_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage1Idx1Rng16_uid178_normalizationShifter_uid40_fpAccTest(BITSELECT,177)@7
    leftShiftStage1Idx1Rng16_uid178_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_q(162 downto 0);
    leftShiftStage1Idx1Rng16_uid178_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage1Idx1Rng16_uid178_normalizationShifter_uid40_fpAccTest_in(162 downto 0);

    -- leftShiftStage1Idx1_uid179_normalizationShifter_uid40_fpAccTest(BITJOIN,178)@7
    leftShiftStage1Idx1_uid179_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx1Rng16_uid178_normalizationShifter_uid40_fpAccTest_b & zs_uid86_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage0Idx3_uid174_normalizationShifter_uid40_fpAccTest(CONSTANT,173)
    leftShiftStage0Idx3_uid174_normalizationShifter_uid40_fpAccTest_q <= "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- leftShiftStage0Idx2Rng128_uid172_normalizationShifter_uid40_fpAccTest(BITSELECT,171)@7
    leftShiftStage0Idx2Rng128_uid172_normalizationShifter_uid40_fpAccTest_in <= redist13_accValuePositive_uid35_fpAccTest_q_4_outputreg_q(50 downto 0);
    leftShiftStage0Idx2Rng128_uid172_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage0Idx2Rng128_uid172_normalizationShifter_uid40_fpAccTest_in(50 downto 0);

    -- leftShiftStage0Idx2_uid173_normalizationShifter_uid40_fpAccTest(BITJOIN,172)@7
    leftShiftStage0Idx2_uid173_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx2Rng128_uid172_normalizationShifter_uid40_fpAccTest_b & zs_uid66_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage0Idx1Rng64_uid169_normalizationShifter_uid40_fpAccTest(BITSELECT,168)@7
    leftShiftStage0Idx1Rng64_uid169_normalizationShifter_uid40_fpAccTest_in <= redist13_accValuePositive_uid35_fpAccTest_q_4_outputreg_q(114 downto 0);
    leftShiftStage0Idx1Rng64_uid169_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage0Idx1Rng64_uid169_normalizationShifter_uid40_fpAccTest_in(114 downto 0);

    -- leftShiftStage0Idx1_uid170_normalizationShifter_uid40_fpAccTest(BITJOIN,169)@7
    leftShiftStage0Idx1_uid170_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx1Rng64_uid169_normalizationShifter_uid40_fpAccTest_b & zs_uid74_zeroCounter_uid37_fpAccTest_q;

    -- redist13_accValuePositive_uid35_fpAccTest_q_4(DELAY,232)
    redist13_accValuePositive_uid35_fpAccTest_q_4 : dspba_delay
    GENERIC MAP ( width => 179, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => accValuePositive_uid35_fpAccTest_q, xout => redist13_accValuePositive_uid35_fpAccTest_q_4_q, ena => en(0), clk => clk, aclr => areset );

    -- redist13_accValuePositive_uid35_fpAccTest_q_4_outputreg(DELAY,238)
    redist13_accValuePositive_uid35_fpAccTest_q_4_outputreg : dspba_delay
    GENERIC MAP ( width => 179, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist13_accValuePositive_uid35_fpAccTest_q_4_q, xout => redist13_accValuePositive_uid35_fpAccTest_q_4_outputreg_q, ena => en(0), clk => clk, aclr => areset );

    -- leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest(MUX,175)@7
    leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_s <= leftShiftStageSel7Dto6_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_b;
    leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_combproc: PROCESS (leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_s, en, redist13_accValuePositive_uid35_fpAccTest_q_4_outputreg_q, leftShiftStage0Idx1_uid170_normalizationShifter_uid40_fpAccTest_q, leftShiftStage0Idx2_uid173_normalizationShifter_uid40_fpAccTest_q, leftShiftStage0Idx3_uid174_normalizationShifter_uid40_fpAccTest_q)
    BEGIN
        CASE (leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_s) IS
            WHEN "00" => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_q <= redist13_accValuePositive_uid35_fpAccTest_q_4_outputreg_q;
            WHEN "01" => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx1_uid170_normalizationShifter_uid40_fpAccTest_q;
            WHEN "10" => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx2_uid173_normalizationShifter_uid40_fpAccTest_q;
            WHEN "11" => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx3_uid174_normalizationShifter_uid40_fpAccTest_q;
            WHEN OTHERS => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest(MUX,186)@7
    leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_s <= leftShiftStageSel7Dto6_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_c;
    leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_combproc: PROCESS (leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_s, en, leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_q, leftShiftStage1Idx1_uid179_normalizationShifter_uid40_fpAccTest_q, leftShiftStage1Idx2_uid182_normalizationShifter_uid40_fpAccTest_q, leftShiftStage1Idx3_uid185_normalizationShifter_uid40_fpAccTest_q)
    BEGIN
        CASE (leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_s) IS
            WHEN "00" => leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_q;
            WHEN "01" => leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx1_uid179_normalizationShifter_uid40_fpAccTest_q;
            WHEN "10" => leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx2_uid182_normalizationShifter_uid40_fpAccTest_q;
            WHEN "11" => leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx3_uid185_normalizationShifter_uid40_fpAccTest_q;
            WHEN OTHERS => leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest(MUX,197)@7
    leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_s <= leftShiftStageSel7Dto6_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_d;
    leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_combproc: PROCESS (leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_s, en, leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_q, leftShiftStage2Idx1_uid190_normalizationShifter_uid40_fpAccTest_q, leftShiftStage2Idx2_uid193_normalizationShifter_uid40_fpAccTest_q, leftShiftStage2Idx3_uid196_normalizationShifter_uid40_fpAccTest_q)
    BEGIN
        CASE (leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_s) IS
            WHEN "00" => leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_q;
            WHEN "01" => leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx1_uid190_normalizationShifter_uid40_fpAccTest_q;
            WHEN "10" => leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx2_uid193_normalizationShifter_uid40_fpAccTest_q;
            WHEN "11" => leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx3_uid196_normalizationShifter_uid40_fpAccTest_q;
            WHEN OTHERS => leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStageSel7Dto6_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select(BITSELECT,218)@7
    leftShiftStageSel7Dto6_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_b <= redist5_r_uid113_zeroCounter_uid37_fpAccTest_q_1_q(7 downto 6);
    leftShiftStageSel7Dto6_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_c <= redist5_r_uid113_zeroCounter_uid37_fpAccTest_q_1_q(5 downto 4);
    leftShiftStageSel7Dto6_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_d <= redist5_r_uid113_zeroCounter_uid37_fpAccTest_q_1_q(3 downto 2);
    leftShiftStageSel7Dto6_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_e <= redist5_r_uid113_zeroCounter_uid37_fpAccTest_q_1_q(1 downto 0);

    -- leftShiftStage3_uid209_normalizationShifter_uid40_fpAccTest(MUX,208)@7
    leftShiftStage3_uid209_normalizationShifter_uid40_fpAccTest_s <= leftShiftStageSel7Dto6_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_e;
    leftShiftStage3_uid209_normalizationShifter_uid40_fpAccTest_combproc: PROCESS (leftShiftStage3_uid209_normalizationShifter_uid40_fpAccTest_s, en, leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_q, leftShiftStage3Idx1_uid201_normalizationShifter_uid40_fpAccTest_q, leftShiftStage3Idx2_uid204_normalizationShifter_uid40_fpAccTest_q, leftShiftStage3Idx3_uid207_normalizationShifter_uid40_fpAccTest_q)
    BEGIN
        CASE (leftShiftStage3_uid209_normalizationShifter_uid40_fpAccTest_s) IS
            WHEN "00" => leftShiftStage3_uid209_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_q;
            WHEN "01" => leftShiftStage3_uid209_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage3Idx1_uid201_normalizationShifter_uid40_fpAccTest_q;
            WHEN "10" => leftShiftStage3_uid209_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage3Idx2_uid204_normalizationShifter_uid40_fpAccTest_q;
            WHEN "11" => leftShiftStage3_uid209_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage3Idx3_uid207_normalizationShifter_uid40_fpAccTest_q;
            WHEN OTHERS => leftShiftStage3_uid209_normalizationShifter_uid40_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fracR_uid46_fpAccTest(BITSELECT,45)@7
    fracR_uid46_fpAccTest_in <= leftShiftStage3_uid209_normalizationShifter_uid40_fpAccTest_q(175 downto 0);
    fracR_uid46_fpAccTest_b <= fracR_uid46_fpAccTest_in(175 downto 153);

    -- R_uid47_fpAccTest(BITJOIN,46)@7
    R_uid47_fpAccTest_q <= redist14_accumulatorSign_uid29_fpAccTest_b_4_q & finalExpUpdated_uid45_fpAccTest_q & fracR_uid46_fpAccTest_b;

    -- xOut(GPOUT,4)@7
    r <= R_uid47_fpAccTest_q;
    xo <= redist12_oRXOverflowFlagFeedback_uid52_fpAccTest_q_5_q;
    xu <= redist11_oRXUnderflowFlagFeedback_uid58_fpAccTest_q_7_q;
    ao <= redist10_oRAccOverflowFlagFeedback_uid62_fpAccTest_q_4_q;

END normal;
