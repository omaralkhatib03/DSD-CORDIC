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

-- VHDL created from fp_acc_0002
-- VHDL created on Sun Mar  3 21:56:38 2024


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

entity fp_acc_0002 is
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
end fp_acc_0002;

architecture normal of fp_acc_0002 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expX_uid6_fpAccTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal fracX_uid7_fpAccTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal signX_uid8_fpAccTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal oFracX_uid10_fpAccTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal expLTLSBA_uid11_fpAccTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cmpLT_expX_expLTLSBA_uid12_fpAccTest_a : STD_LOGIC_VECTOR (9 downto 0);
    signal cmpLT_expX_expLTLSBA_uid12_fpAccTest_b : STD_LOGIC_VECTOR (9 downto 0);
    signal cmpLT_expX_expLTLSBA_uid12_fpAccTest_o : STD_LOGIC_VECTOR (9 downto 0);
    signal cmpLT_expX_expLTLSBA_uid12_fpAccTest_c : STD_LOGIC_VECTOR (0 downto 0);
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
    signal padConst_uid17_fpAccTest_q : STD_LOGIC_VECTOR (44 downto 0);
    signal rightPaddedIn_uid18_fpAccTest_q : STD_LOGIC_VECTOR (68 downto 0);
    signal shiftedFracUpper_uid20_fpAccTest_b : STD_LOGIC_VECTOR (44 downto 0);
    signal extendedAlignedShiftedFrac_uid21_fpAccTest_q : STD_LOGIC_VECTOR (45 downto 0);
    signal onesComplementExtendedFrac_uid22_fpAccTest_b : STD_LOGIC_VECTOR (45 downto 0);
    signal onesComplementExtendedFrac_uid22_fpAccTest_q : STD_LOGIC_VECTOR (45 downto 0);
    signal accumulator_uid24_fpAccTest_a : STD_LOGIC_VECTOR (404 downto 0);
    signal accumulator_uid24_fpAccTest_b : STD_LOGIC_VECTOR (404 downto 0);
    signal accumulator_uid24_fpAccTest_i : STD_LOGIC_VECTOR (404 downto 0);
    signal accumulator_uid24_fpAccTest_o : STD_LOGIC_VECTOR (404 downto 0);
    signal accumulator_uid24_fpAccTest_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal accumulator_uid24_fpAccTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal accumulator_uid24_fpAccTest_q : STD_LOGIC_VECTOR (402 downto 0);
    signal os_uid25_fpAccTest_q : STD_LOGIC_VECTOR (403 downto 0);
    signal osr_uid26_fpAccTest_in : STD_LOGIC_VECTOR (402 downto 0);
    signal osr_uid26_fpAccTest_b : STD_LOGIC_VECTOR (402 downto 0);
    signal sum_uid27_fpAccTest_in : STD_LOGIC_VECTOR (401 downto 0);
    signal sum_uid27_fpAccTest_b : STD_LOGIC_VECTOR (401 downto 0);
    signal accumulatorSign_uid29_fpAccTest_in : STD_LOGIC_VECTOR (400 downto 0);
    signal accumulatorSign_uid29_fpAccTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal accOverflowBitMSB_uid30_fpAccTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal accOverflow_uid32_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal accValidRange_uid33_fpAccTest_in : STD_LOGIC_VECTOR (400 downto 0);
    signal accValidRange_uid33_fpAccTest_b : STD_LOGIC_VECTOR (400 downto 0);
    signal accOnesComplement_uid34_fpAccTest_b : STD_LOGIC_VECTOR (400 downto 0);
    signal accOnesComplement_uid34_fpAccTest_q : STD_LOGIC_VECTOR (400 downto 0);
    signal accValuePositive_uid35_fpAccTest_a : STD_LOGIC_VECTOR (401 downto 0);
    signal accValuePositive_uid35_fpAccTest_b : STD_LOGIC_VECTOR (401 downto 0);
    signal accValuePositive_uid35_fpAccTest_o : STD_LOGIC_VECTOR (401 downto 0);
    signal accValuePositive_uid35_fpAccTest_q : STD_LOGIC_VECTOR (401 downto 0);
    signal posAccWoLeadingZeroBit_uid36_fpAccTest_in : STD_LOGIC_VECTOR (399 downto 0);
    signal posAccWoLeadingZeroBit_uid36_fpAccTest_b : STD_LOGIC_VECTOR (399 downto 0);
    signal ShiftedOutComparator_uid38_fpAccTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal accResOutOfExpRange_uid39_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expRBias_uid41_fpAccTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal zeroExponent_uid42_fpAccTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal resExpSub_uid43_fpAccTest_a : STD_LOGIC_VECTOR (9 downto 0);
    signal resExpSub_uid43_fpAccTest_b : STD_LOGIC_VECTOR (9 downto 0);
    signal resExpSub_uid43_fpAccTest_o : STD_LOGIC_VECTOR (9 downto 0);
    signal resExpSub_uid43_fpAccTest_q : STD_LOGIC_VECTOR (9 downto 0);
    signal finalExponent_uid44_fpAccTest_in : STD_LOGIC_VECTOR (7 downto 0);
    signal finalExponent_uid44_fpAccTest_b : STD_LOGIC_VECTOR (7 downto 0);
    signal finalExpUpdated_uid45_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal finalExpUpdated_uid45_fpAccTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal fracR_uid46_fpAccTest_in : STD_LOGIC_VECTOR (398 downto 0);
    signal fracR_uid46_fpAccTest_b : STD_LOGIC_VECTOR (22 downto 0);
    signal R_uid47_fpAccTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal delayedXOverflowFeedbackSignal_uid50_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
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
    signal delayedAccOverflowFeedbackSignal_uid60_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal muxAccOverflowFeedbackSignal_uid61_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal muxAccOverflowFeedbackSignal_uid61_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oRAccOverflowFlagFeedback_uid62_fpAccTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal oRAccOverflowFlagFeedback_uid62_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal zs_uid66_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (255 downto 0);
    signal vCount_uid68_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal mO_uid69_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (111 downto 0);
    signal cStage_uid71_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (255 downto 0);
    signal vStagei_uid73_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid73_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (255 downto 0);
    signal zs_uid74_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (127 downto 0);
    signal vCount_uid76_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid79_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid79_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (127 downto 0);
    signal zs_uid80_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (63 downto 0);
    signal vCount_uid82_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid85_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid85_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (63 downto 0);
    signal zs_uid86_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal vCount_uid88_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid91_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid91_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (31 downto 0);
    signal zs_uid92_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid94_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid97_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid97_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid100_zeroCounter_uid37_fpAccTest_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid100_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid103_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid103_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (7 downto 0);
    signal zs_uid104_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vCount_uid106_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid109_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid109_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (3 downto 0);
    signal zs_uid110_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal vCount_uid112_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid115_zeroCounter_uid37_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid115_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid117_zeroCounter_uid37_fpAccTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid118_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid119_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal wIntCst_uid123_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (6 downto 0);
    signal shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_a : STD_LOGIC_VECTOR (11 downto 0);
    signal shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_o : STD_LOGIC_VECTOR (11 downto 0);
    signal shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx1Rng32_uid125_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (36 downto 0);
    signal rightShiftStage0Idx1_uid127_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (68 downto 0);
    signal rightShiftStage0Idx2Rng64_uid128_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (4 downto 0);
    signal rightShiftStage0Idx2_uid130_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (68 downto 0);
    signal rightShiftStage0Idx3_uid131_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (68 downto 0);
    signal rightShiftStage0_uid133_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid133_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (68 downto 0);
    signal rightShiftStage1Idx1Rng8_uid134_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (60 downto 0);
    signal rightShiftStage1Idx1_uid136_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (68 downto 0);
    signal rightShiftStage1Idx2Rng16_uid137_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (52 downto 0);
    signal rightShiftStage1Idx2_uid139_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (68 downto 0);
    signal rightShiftStage1Idx3Rng24_uid140_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (44 downto 0);
    signal rightShiftStage1Idx3Pad24_uid141_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal rightShiftStage1Idx3_uid142_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (68 downto 0);
    signal rightShiftStage1_uid144_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid144_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (68 downto 0);
    signal rightShiftStage2Idx1Rng2_uid145_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (66 downto 0);
    signal rightShiftStage2Idx1_uid147_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (68 downto 0);
    signal rightShiftStage2Idx2Rng4_uid148_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (64 downto 0);
    signal rightShiftStage2Idx2_uid150_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (68 downto 0);
    signal rightShiftStage2Idx3Rng6_uid151_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (62 downto 0);
    signal rightShiftStage2Idx3Pad6_uid152_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (5 downto 0);
    signal rightShiftStage2Idx3_uid153_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (68 downto 0);
    signal rightShiftStage2_uid155_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage2_uid155_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (68 downto 0);
    signal rightShiftStage3Idx1Rng1_uid156_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (67 downto 0);
    signal rightShiftStage3Idx1_uid158_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (68 downto 0);
    signal rightShiftStage3_uid160_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage3_uid160_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (68 downto 0);
    signal r_uid162_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid162_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (68 downto 0);
    signal leftShiftStage0Idx1Rng128_uid167_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (273 downto 0);
    signal leftShiftStage0Idx1Rng128_uid167_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (273 downto 0);
    signal leftShiftStage0Idx1_uid168_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (401 downto 0);
    signal leftShiftStage0Idx2Rng256_uid170_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (145 downto 0);
    signal leftShiftStage0Idx2Rng256_uid170_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (145 downto 0);
    signal leftShiftStage0Idx2_uid171_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (401 downto 0);
    signal leftShiftStage0Idx3Pad384_uid172_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (383 downto 0);
    signal leftShiftStage0Idx3Rng384_uid173_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (17 downto 0);
    signal leftShiftStage0Idx3Rng384_uid173_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (17 downto 0);
    signal leftShiftStage0Idx3_uid174_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (401 downto 0);
    signal leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (401 downto 0);
    signal leftShiftStage1Idx1Rng32_uid178_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (369 downto 0);
    signal leftShiftStage1Idx1Rng32_uid178_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (369 downto 0);
    signal leftShiftStage1Idx1_uid179_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (401 downto 0);
    signal leftShiftStage1Idx2Rng64_uid181_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (337 downto 0);
    signal leftShiftStage1Idx2Rng64_uid181_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (337 downto 0);
    signal leftShiftStage1Idx2_uid182_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (401 downto 0);
    signal leftShiftStage1Idx3Pad96_uid183_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (95 downto 0);
    signal leftShiftStage1Idx3Rng96_uid184_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (305 downto 0);
    signal leftShiftStage1Idx3Rng96_uid184_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (305 downto 0);
    signal leftShiftStage1Idx3_uid185_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (401 downto 0);
    signal leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (401 downto 0);
    signal leftShiftStage2Idx1Rng8_uid189_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (393 downto 0);
    signal leftShiftStage2Idx1Rng8_uid189_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (393 downto 0);
    signal leftShiftStage2Idx1_uid190_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (401 downto 0);
    signal leftShiftStage2Idx2Rng16_uid192_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (385 downto 0);
    signal leftShiftStage2Idx2Rng16_uid192_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (385 downto 0);
    signal leftShiftStage2Idx2_uid193_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (401 downto 0);
    signal leftShiftStage2Idx3Rng24_uid195_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (377 downto 0);
    signal leftShiftStage2Idx3Rng24_uid195_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (377 downto 0);
    signal leftShiftStage2Idx3_uid196_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (401 downto 0);
    signal leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (401 downto 0);
    signal leftShiftStage3Idx1Rng2_uid200_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (399 downto 0);
    signal leftShiftStage3Idx1Rng2_uid200_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (399 downto 0);
    signal leftShiftStage3Idx1_uid201_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (401 downto 0);
    signal leftShiftStage3Idx2Rng4_uid203_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (397 downto 0);
    signal leftShiftStage3Idx2Rng4_uid203_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (397 downto 0);
    signal leftShiftStage3Idx2_uid204_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (401 downto 0);
    signal leftShiftStage3Idx3Rng6_uid206_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (395 downto 0);
    signal leftShiftStage3Idx3Rng6_uid206_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (395 downto 0);
    signal leftShiftStage3Idx3_uid207_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (401 downto 0);
    signal leftShiftStage3_uid209_normalizationShifter_uid40_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage3_uid209_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (401 downto 0);
    signal leftShiftStage4Idx1Rng1_uid211_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (400 downto 0);
    signal leftShiftStage4Idx1Rng1_uid211_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (400 downto 0);
    signal leftShiftStage4Idx1_uid212_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (401 downto 0);
    signal leftShiftStage4_uid214_normalizationShifter_uid40_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage4_uid214_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (401 downto 0);
    signal rightShiftStageSel6Dto5_uid132_alignmentShifter_uid17_fpAccTest_merged_bit_select_in : STD_LOGIC_VECTOR (6 downto 0);
    signal rightShiftStageSel6Dto5_uid132_alignmentShifter_uid17_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel6Dto5_uid132_alignmentShifter_uid17_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel6Dto5_uid132_alignmentShifter_uid17_fpAccTest_merged_bit_select_d : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel6Dto5_uid132_alignmentShifter_uid17_fpAccTest_merged_bit_select_e : STD_LOGIC_VECTOR (0 downto 0);
    signal rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (255 downto 0);
    signal rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (143 downto 0);
    signal rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (127 downto 0);
    signal rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (127 downto 0);
    signal rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (63 downto 0);
    signal rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (63 downto 0);
    signal rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (31 downto 0);
    signal rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (31 downto 0);
    signal rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid111_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid111_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel8Dto7_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel8Dto7_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel8Dto7_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_d : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel8Dto7_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_e : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel8Dto7_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_f : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist1_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist2_vCount_uid94_zeroCounter_uid37_fpAccTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_vCount_uid88_zeroCounter_uid37_fpAccTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_vCount_uid82_zeroCounter_uid37_fpAccTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_vCount_uid76_zeroCounter_uid37_fpAccTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_vCount_uid68_zeroCounter_uid37_fpAccTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_oRXUnderflowFlagFeedback_uid58_fpAccTest_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_accValuePositive_uid35_fpAccTest_q_2_q : STD_LOGIC_VECTOR (401 downto 0);
    signal redist11_accumulatorSign_uid29_fpAccTest_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_xIn_n_1_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- signX_uid8_fpAccTest(BITSELECT,7)@0
    signX_uid8_fpAccTest_b <= STD_LOGIC_VECTOR(x(31 downto 31));

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- rightShiftStage0Idx3_uid131_alignmentShifter_uid17_fpAccTest(CONSTANT,130)
    rightShiftStage0Idx3_uid131_alignmentShifter_uid17_fpAccTest_q <= "000000000000000000000000000000000000000000000000000000000000000000000";

    -- rightShiftStage3Idx1Rng1_uid156_alignmentShifter_uid17_fpAccTest(BITSELECT,155)@0
    rightShiftStage3Idx1Rng1_uid156_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage2_uid155_alignmentShifter_uid17_fpAccTest_q(68 downto 1);

    -- rightShiftStage3Idx1_uid158_alignmentShifter_uid17_fpAccTest(BITJOIN,157)@0
    rightShiftStage3Idx1_uid158_alignmentShifter_uid17_fpAccTest_q <= GND_q & rightShiftStage3Idx1Rng1_uid156_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage2Idx3Pad6_uid152_alignmentShifter_uid17_fpAccTest(CONSTANT,151)
    rightShiftStage2Idx3Pad6_uid152_alignmentShifter_uid17_fpAccTest_q <= "000000";

    -- rightShiftStage2Idx3Rng6_uid151_alignmentShifter_uid17_fpAccTest(BITSELECT,150)@0
    rightShiftStage2Idx3Rng6_uid151_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage1_uid144_alignmentShifter_uid17_fpAccTest_q(68 downto 6);

    -- rightShiftStage2Idx3_uid153_alignmentShifter_uid17_fpAccTest(BITJOIN,152)@0
    rightShiftStage2Idx3_uid153_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage2Idx3Pad6_uid152_alignmentShifter_uid17_fpAccTest_q & rightShiftStage2Idx3Rng6_uid151_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid104_zeroCounter_uid37_fpAccTest(CONSTANT,103)
    zs_uid104_zeroCounter_uid37_fpAccTest_q <= "0000";

    -- rightShiftStage2Idx2Rng4_uid148_alignmentShifter_uid17_fpAccTest(BITSELECT,147)@0
    rightShiftStage2Idx2Rng4_uid148_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage1_uid144_alignmentShifter_uid17_fpAccTest_q(68 downto 4);

    -- rightShiftStage2Idx2_uid150_alignmentShifter_uid17_fpAccTest(BITJOIN,149)@0
    rightShiftStage2Idx2_uid150_alignmentShifter_uid17_fpAccTest_q <= zs_uid104_zeroCounter_uid37_fpAccTest_q & rightShiftStage2Idx2Rng4_uid148_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid110_zeroCounter_uid37_fpAccTest(CONSTANT,109)
    zs_uid110_zeroCounter_uid37_fpAccTest_q <= "00";

    -- rightShiftStage2Idx1Rng2_uid145_alignmentShifter_uid17_fpAccTest(BITSELECT,144)@0
    rightShiftStage2Idx1Rng2_uid145_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage1_uid144_alignmentShifter_uid17_fpAccTest_q(68 downto 2);

    -- rightShiftStage2Idx1_uid147_alignmentShifter_uid17_fpAccTest(BITJOIN,146)@0
    rightShiftStage2Idx1_uid147_alignmentShifter_uid17_fpAccTest_q <= zs_uid110_zeroCounter_uid37_fpAccTest_q & rightShiftStage2Idx1Rng2_uid145_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage1Idx3Pad24_uid141_alignmentShifter_uid17_fpAccTest(CONSTANT,140)
    rightShiftStage1Idx3Pad24_uid141_alignmentShifter_uid17_fpAccTest_q <= "000000000000000000000000";

    -- rightShiftStage1Idx3Rng24_uid140_alignmentShifter_uid17_fpAccTest(BITSELECT,139)@0
    rightShiftStage1Idx3Rng24_uid140_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage0_uid133_alignmentShifter_uid17_fpAccTest_q(68 downto 24);

    -- rightShiftStage1Idx3_uid142_alignmentShifter_uid17_fpAccTest(BITJOIN,141)@0
    rightShiftStage1Idx3_uid142_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1Idx3Pad24_uid141_alignmentShifter_uid17_fpAccTest_q & rightShiftStage1Idx3Rng24_uid140_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid92_zeroCounter_uid37_fpAccTest(CONSTANT,91)
    zs_uid92_zeroCounter_uid37_fpAccTest_q <= "0000000000000000";

    -- rightShiftStage1Idx2Rng16_uid137_alignmentShifter_uid17_fpAccTest(BITSELECT,136)@0
    rightShiftStage1Idx2Rng16_uid137_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage0_uid133_alignmentShifter_uid17_fpAccTest_q(68 downto 16);

    -- rightShiftStage1Idx2_uid139_alignmentShifter_uid17_fpAccTest(BITJOIN,138)@0
    rightShiftStage1Idx2_uid139_alignmentShifter_uid17_fpAccTest_q <= zs_uid92_zeroCounter_uid37_fpAccTest_q & rightShiftStage1Idx2Rng16_uid137_alignmentShifter_uid17_fpAccTest_b;

    -- zeroExponent_uid42_fpAccTest(CONSTANT,41)
    zeroExponent_uid42_fpAccTest_q <= "00000000";

    -- rightShiftStage1Idx1Rng8_uid134_alignmentShifter_uid17_fpAccTest(BITSELECT,133)@0
    rightShiftStage1Idx1Rng8_uid134_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage0_uid133_alignmentShifter_uid17_fpAccTest_q(68 downto 8);

    -- rightShiftStage1Idx1_uid136_alignmentShifter_uid17_fpAccTest(BITJOIN,135)@0
    rightShiftStage1Idx1_uid136_alignmentShifter_uid17_fpAccTest_q <= zeroExponent_uid42_fpAccTest_q & rightShiftStage1Idx1Rng8_uid134_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid80_zeroCounter_uid37_fpAccTest(CONSTANT,79)
    zs_uid80_zeroCounter_uid37_fpAccTest_q <= "0000000000000000000000000000000000000000000000000000000000000000";

    -- rightShiftStage0Idx2Rng64_uid128_alignmentShifter_uid17_fpAccTest(BITSELECT,127)@0
    rightShiftStage0Idx2Rng64_uid128_alignmentShifter_uid17_fpAccTest_b <= rightPaddedIn_uid18_fpAccTest_q(68 downto 64);

    -- rightShiftStage0Idx2_uid130_alignmentShifter_uid17_fpAccTest(BITJOIN,129)@0
    rightShiftStage0Idx2_uid130_alignmentShifter_uid17_fpAccTest_q <= zs_uid80_zeroCounter_uid37_fpAccTest_q & rightShiftStage0Idx2Rng64_uid128_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid86_zeroCounter_uid37_fpAccTest(CONSTANT,85)
    zs_uid86_zeroCounter_uid37_fpAccTest_q <= "00000000000000000000000000000000";

    -- rightShiftStage0Idx1Rng32_uid125_alignmentShifter_uid17_fpAccTest(BITSELECT,124)@0
    rightShiftStage0Idx1Rng32_uid125_alignmentShifter_uid17_fpAccTest_b <= rightPaddedIn_uid18_fpAccTest_q(68 downto 32);

    -- rightShiftStage0Idx1_uid127_alignmentShifter_uid17_fpAccTest(BITJOIN,126)@0
    rightShiftStage0Idx1_uid127_alignmentShifter_uid17_fpAccTest_q <= zs_uid86_zeroCounter_uid37_fpAccTest_q & rightShiftStage0Idx1Rng32_uid125_alignmentShifter_uid17_fpAccTest_b;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- fracX_uid7_fpAccTest(BITSELECT,6)@0
    fracX_uid7_fpAccTest_b <= x(22 downto 0);

    -- oFracX_uid10_fpAccTest(BITJOIN,9)@0
    oFracX_uid10_fpAccTest_q <= VCC_q & fracX_uid7_fpAccTest_b;

    -- padConst_uid17_fpAccTest(CONSTANT,16)
    padConst_uid17_fpAccTest_q <= "000000000000000000000000000000000000000000000";

    -- rightPaddedIn_uid18_fpAccTest(BITJOIN,17)@0
    rightPaddedIn_uid18_fpAccTest_q <= oFracX_uid10_fpAccTest_q & padConst_uid17_fpAccTest_q;

    -- rightShiftStage0_uid133_alignmentShifter_uid17_fpAccTest(MUX,132)@0
    rightShiftStage0_uid133_alignmentShifter_uid17_fpAccTest_s <= rightShiftStageSel6Dto5_uid132_alignmentShifter_uid17_fpAccTest_merged_bit_select_b;
    rightShiftStage0_uid133_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (rightShiftStage0_uid133_alignmentShifter_uid17_fpAccTest_s, en, rightPaddedIn_uid18_fpAccTest_q, rightShiftStage0Idx1_uid127_alignmentShifter_uid17_fpAccTest_q, rightShiftStage0Idx2_uid130_alignmentShifter_uid17_fpAccTest_q, rightShiftStage0Idx3_uid131_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (rightShiftStage0_uid133_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "00" => rightShiftStage0_uid133_alignmentShifter_uid17_fpAccTest_q <= rightPaddedIn_uid18_fpAccTest_q;
            WHEN "01" => rightShiftStage0_uid133_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0Idx1_uid127_alignmentShifter_uid17_fpAccTest_q;
            WHEN "10" => rightShiftStage0_uid133_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0Idx2_uid130_alignmentShifter_uid17_fpAccTest_q;
            WHEN "11" => rightShiftStage0_uid133_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0Idx3_uid131_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => rightShiftStage0_uid133_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStage1_uid144_alignmentShifter_uid17_fpAccTest(MUX,143)@0
    rightShiftStage1_uid144_alignmentShifter_uid17_fpAccTest_s <= rightShiftStageSel6Dto5_uid132_alignmentShifter_uid17_fpAccTest_merged_bit_select_c;
    rightShiftStage1_uid144_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (rightShiftStage1_uid144_alignmentShifter_uid17_fpAccTest_s, en, rightShiftStage0_uid133_alignmentShifter_uid17_fpAccTest_q, rightShiftStage1Idx1_uid136_alignmentShifter_uid17_fpAccTest_q, rightShiftStage1Idx2_uid139_alignmentShifter_uid17_fpAccTest_q, rightShiftStage1Idx3_uid142_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (rightShiftStage1_uid144_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "00" => rightShiftStage1_uid144_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0_uid133_alignmentShifter_uid17_fpAccTest_q;
            WHEN "01" => rightShiftStage1_uid144_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1Idx1_uid136_alignmentShifter_uid17_fpAccTest_q;
            WHEN "10" => rightShiftStage1_uid144_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1Idx2_uid139_alignmentShifter_uid17_fpAccTest_q;
            WHEN "11" => rightShiftStage1_uid144_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1Idx3_uid142_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => rightShiftStage1_uid144_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStage2_uid155_alignmentShifter_uid17_fpAccTest(MUX,154)@0
    rightShiftStage2_uid155_alignmentShifter_uid17_fpAccTest_s <= rightShiftStageSel6Dto5_uid132_alignmentShifter_uid17_fpAccTest_merged_bit_select_d;
    rightShiftStage2_uid155_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (rightShiftStage2_uid155_alignmentShifter_uid17_fpAccTest_s, en, rightShiftStage1_uid144_alignmentShifter_uid17_fpAccTest_q, rightShiftStage2Idx1_uid147_alignmentShifter_uid17_fpAccTest_q, rightShiftStage2Idx2_uid150_alignmentShifter_uid17_fpAccTest_q, rightShiftStage2Idx3_uid153_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (rightShiftStage2_uid155_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "00" => rightShiftStage2_uid155_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1_uid144_alignmentShifter_uid17_fpAccTest_q;
            WHEN "01" => rightShiftStage2_uid155_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage2Idx1_uid147_alignmentShifter_uid17_fpAccTest_q;
            WHEN "10" => rightShiftStage2_uid155_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage2Idx2_uid150_alignmentShifter_uid17_fpAccTest_q;
            WHEN "11" => rightShiftStage2_uid155_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage2Idx3_uid153_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => rightShiftStage2_uid155_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- expX_uid6_fpAccTest(BITSELECT,5)@0
    expX_uid6_fpAccTest_b <= x(30 downto 23);

    -- rShiftConstant_uid15_fpAccTest(CONSTANT,14)
    rShiftConstant_uid15_fpAccTest_q <= "010001110";

    -- rightShiftValue_uid16_fpAccTest(SUB,15)@0
    rightShiftValue_uid16_fpAccTest_a <= STD_LOGIC_VECTOR("0" & rShiftConstant_uid15_fpAccTest_q);
    rightShiftValue_uid16_fpAccTest_b <= STD_LOGIC_VECTOR("00" & expX_uid6_fpAccTest_b);
    rightShiftValue_uid16_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(rightShiftValue_uid16_fpAccTest_a) - UNSIGNED(rightShiftValue_uid16_fpAccTest_b));
    rightShiftValue_uid16_fpAccTest_q <= rightShiftValue_uid16_fpAccTest_o(9 downto 0);

    -- rightShiftStageSel6Dto5_uid132_alignmentShifter_uid17_fpAccTest_merged_bit_select(BITSELECT,215)@0
    rightShiftStageSel6Dto5_uid132_alignmentShifter_uid17_fpAccTest_merged_bit_select_in <= rightShiftValue_uid16_fpAccTest_q(6 downto 0);
    rightShiftStageSel6Dto5_uid132_alignmentShifter_uid17_fpAccTest_merged_bit_select_b <= rightShiftStageSel6Dto5_uid132_alignmentShifter_uid17_fpAccTest_merged_bit_select_in(6 downto 5);
    rightShiftStageSel6Dto5_uid132_alignmentShifter_uid17_fpAccTest_merged_bit_select_c <= rightShiftStageSel6Dto5_uid132_alignmentShifter_uid17_fpAccTest_merged_bit_select_in(4 downto 3);
    rightShiftStageSel6Dto5_uid132_alignmentShifter_uid17_fpAccTest_merged_bit_select_d <= rightShiftStageSel6Dto5_uid132_alignmentShifter_uid17_fpAccTest_merged_bit_select_in(2 downto 1);
    rightShiftStageSel6Dto5_uid132_alignmentShifter_uid17_fpAccTest_merged_bit_select_e <= rightShiftStageSel6Dto5_uid132_alignmentShifter_uid17_fpAccTest_merged_bit_select_in(0 downto 0);

    -- rightShiftStage3_uid160_alignmentShifter_uid17_fpAccTest(MUX,159)@0
    rightShiftStage3_uid160_alignmentShifter_uid17_fpAccTest_s <= rightShiftStageSel6Dto5_uid132_alignmentShifter_uid17_fpAccTest_merged_bit_select_e;
    rightShiftStage3_uid160_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (rightShiftStage3_uid160_alignmentShifter_uid17_fpAccTest_s, en, rightShiftStage2_uid155_alignmentShifter_uid17_fpAccTest_q, rightShiftStage3Idx1_uid158_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (rightShiftStage3_uid160_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "0" => rightShiftStage3_uid160_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage2_uid155_alignmentShifter_uid17_fpAccTest_q;
            WHEN "1" => rightShiftStage3_uid160_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage3Idx1_uid158_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => rightShiftStage3_uid160_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- wIntCst_uid123_alignmentShifter_uid17_fpAccTest(CONSTANT,122)
    wIntCst_uid123_alignmentShifter_uid17_fpAccTest_q <= "1000101";

    -- shiftedOut_uid124_alignmentShifter_uid17_fpAccTest(COMPARE,123)@0
    shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_a <= STD_LOGIC_VECTOR("00" & rightShiftValue_uid16_fpAccTest_q);
    shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_b <= STD_LOGIC_VECTOR("00000" & wIntCst_uid123_alignmentShifter_uid17_fpAccTest_q);
    shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_a) - UNSIGNED(shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_b));
    shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_n(0) <= not (shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_o(11));

    -- r_uid162_alignmentShifter_uid17_fpAccTest(MUX,161)@0
    r_uid162_alignmentShifter_uid17_fpAccTest_s <= shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_n;
    r_uid162_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (r_uid162_alignmentShifter_uid17_fpAccTest_s, en, rightShiftStage3_uid160_alignmentShifter_uid17_fpAccTest_q, rightShiftStage0Idx3_uid131_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (r_uid162_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "0" => r_uid162_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage3_uid160_alignmentShifter_uid17_fpAccTest_q;
            WHEN "1" => r_uid162_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0Idx3_uid131_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => r_uid162_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- shiftedFracUpper_uid20_fpAccTest(BITSELECT,19)@0
    shiftedFracUpper_uid20_fpAccTest_b <= r_uid162_alignmentShifter_uid17_fpAccTest_q(68 downto 24);

    -- extendedAlignedShiftedFrac_uid21_fpAccTest(BITJOIN,20)@0
    extendedAlignedShiftedFrac_uid21_fpAccTest_q <= GND_q & shiftedFracUpper_uid20_fpAccTest_b;

    -- onesComplementExtendedFrac_uid22_fpAccTest(LOGICAL,21)@0
    onesComplementExtendedFrac_uid22_fpAccTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((45 downto 1 => signX_uid8_fpAccTest_b(0)) & signX_uid8_fpAccTest_b));
    onesComplementExtendedFrac_uid22_fpAccTest_q <= extendedAlignedShiftedFrac_uid21_fpAccTest_q xor onesComplementExtendedFrac_uid22_fpAccTest_b;

    -- accumulator_uid24_fpAccTest(ADD,23)@0 + 1
    accumulator_uid24_fpAccTest_cin <= signX_uid8_fpAccTest_b;
    accumulator_uid24_fpAccTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((403 downto 402 => sum_uid27_fpAccTest_b(401)) & sum_uid27_fpAccTest_b) & '1');
    accumulator_uid24_fpAccTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((403 downto 46 => onesComplementExtendedFrac_uid22_fpAccTest_q(45)) & onesComplementExtendedFrac_uid22_fpAccTest_q) & accumulator_uid24_fpAccTest_cin(0));
    accumulator_uid24_fpAccTest_i <= accumulator_uid24_fpAccTest_b;
    accumulator_uid24_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            accumulator_uid24_fpAccTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                IF (n = "1") THEN
                    accumulator_uid24_fpAccTest_o <= accumulator_uid24_fpAccTest_i;
                ELSE
                    accumulator_uid24_fpAccTest_o <= STD_LOGIC_VECTOR(SIGNED(accumulator_uid24_fpAccTest_a) + SIGNED(accumulator_uid24_fpAccTest_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    accumulator_uid24_fpAccTest_c(0) <= accumulator_uid24_fpAccTest_o(404);
    accumulator_uid24_fpAccTest_q <= accumulator_uid24_fpAccTest_o(403 downto 1);

    -- os_uid25_fpAccTest(BITJOIN,24)@1
    os_uid25_fpAccTest_q <= accumulator_uid24_fpAccTest_c & accumulator_uid24_fpAccTest_q;

    -- osr_uid26_fpAccTest(BITSELECT,25)@1
    osr_uid26_fpAccTest_in <= STD_LOGIC_VECTOR(os_uid25_fpAccTest_q(402 downto 0));
    osr_uid26_fpAccTest_b <= STD_LOGIC_VECTOR(osr_uid26_fpAccTest_in(402 downto 0));

    -- sum_uid27_fpAccTest(BITSELECT,26)@1
    sum_uid27_fpAccTest_in <= STD_LOGIC_VECTOR(osr_uid26_fpAccTest_b(401 downto 0));
    sum_uid27_fpAccTest_b <= STD_LOGIC_VECTOR(sum_uid27_fpAccTest_in(401 downto 0));

    -- accumulatorSign_uid29_fpAccTest(BITSELECT,28)@1
    accumulatorSign_uid29_fpAccTest_in <= sum_uid27_fpAccTest_b(400 downto 0);
    accumulatorSign_uid29_fpAccTest_b <= accumulatorSign_uid29_fpAccTest_in(400 downto 400);

    -- accOverflowBitMSB_uid30_fpAccTest(BITSELECT,29)@1
    accOverflowBitMSB_uid30_fpAccTest_b <= sum_uid27_fpAccTest_b(401 downto 401);

    -- accOverflow_uid32_fpAccTest(LOGICAL,31)@1
    accOverflow_uid32_fpAccTest_q <= accOverflowBitMSB_uid30_fpAccTest_b xor accumulatorSign_uid29_fpAccTest_b;

    -- redist12_xIn_n_1(DELAY,237)
    redist12_xIn_n_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => n, xout => redist12_xIn_n_1_q, ena => en(0), clk => clk, aclr => areset );

    -- muxAccOverflowFeedbackSignal_uid61_fpAccTest(MUX,60)@1
    muxAccOverflowFeedbackSignal_uid61_fpAccTest_s <= redist12_xIn_n_1_q;
    muxAccOverflowFeedbackSignal_uid61_fpAccTest_combproc: PROCESS (muxAccOverflowFeedbackSignal_uid61_fpAccTest_s, en, oRAccOverflowFlagFeedback_uid62_fpAccTest_q, GND_q)
    BEGIN
        CASE (muxAccOverflowFeedbackSignal_uid61_fpAccTest_s) IS
            WHEN "0" => muxAccOverflowFeedbackSignal_uid61_fpAccTest_q <= oRAccOverflowFlagFeedback_uid62_fpAccTest_q;
            WHEN "1" => muxAccOverflowFeedbackSignal_uid61_fpAccTest_q <= GND_q;
            WHEN OTHERS => muxAccOverflowFeedbackSignal_uid61_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oRAccOverflowFlagFeedback_uid62_fpAccTest(LOGICAL,61)@1 + 1
    oRAccOverflowFlagFeedback_uid62_fpAccTest_qi <= muxAccOverflowFeedbackSignal_uid61_fpAccTest_q or accOverflow_uid32_fpAccTest_q;
    oRAccOverflowFlagFeedback_uid62_fpAccTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRAccOverflowFlagFeedback_uid62_fpAccTest_qi, xout => oRAccOverflowFlagFeedback_uid62_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- delayedAccOverflowFeedbackSignal_uid60_fpAccTest(DELAY,59)
    delayedAccOverflowFeedbackSignal_uid60_fpAccTest : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRAccOverflowFlagFeedback_uid62_fpAccTest_q, xout => delayedAccOverflowFeedbackSignal_uid60_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- expNotZero_uid56_fpAccTest(LOGICAL,55)@0
    expNotZero_uid56_fpAccTest_q <= "1" WHEN expX_uid6_fpAccTest_b /= "00000000" ELSE "0";

    -- expLTLSBA_uid11_fpAccTest(CONSTANT,10)
    expLTLSBA_uid11_fpAccTest_q <= "01100001";

    -- cmpLT_expX_expLTLSBA_uid12_fpAccTest(COMPARE,11)@0
    cmpLT_expX_expLTLSBA_uid12_fpAccTest_a <= STD_LOGIC_VECTOR("00" & expX_uid6_fpAccTest_b);
    cmpLT_expX_expLTLSBA_uid12_fpAccTest_b <= STD_LOGIC_VECTOR("00" & expLTLSBA_uid11_fpAccTest_q);
    cmpLT_expX_expLTLSBA_uid12_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(cmpLT_expX_expLTLSBA_uid12_fpAccTest_a) - UNSIGNED(cmpLT_expX_expLTLSBA_uid12_fpAccTest_b));
    cmpLT_expX_expLTLSBA_uid12_fpAccTest_c(0) <= cmpLT_expX_expLTLSBA_uid12_fpAccTest_o(9);

    -- underflowCond_uid57_fpAccTest(LOGICAL,56)@0
    underflowCond_uid57_fpAccTest_q <= cmpLT_expX_expLTLSBA_uid12_fpAccTest_c and expNotZero_uid56_fpAccTest_q;

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

    -- redist8_oRXUnderflowFlagFeedback_uid58_fpAccTest_q_3(DELAY,233)
    redist8_oRXUnderflowFlagFeedback_uid58_fpAccTest_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRXUnderflowFlagFeedback_uid58_fpAccTest_q, xout => redist8_oRXUnderflowFlagFeedback_uid58_fpAccTest_q_3_q, ena => en(0), clk => clk, aclr => areset );

    -- expGTMaxMSBX_uid13_fpAccTest(CONSTANT,12)
    expGTMaxMSBX_uid13_fpAccTest_q <= "10001110";

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

    -- muxXOverflowFeedbackSignal_uid51_fpAccTest(MUX,50)@1
    muxXOverflowFeedbackSignal_uid51_fpAccTest_s <= redist12_xIn_n_1_q;
    muxXOverflowFeedbackSignal_uid51_fpAccTest_combproc: PROCESS (muxXOverflowFeedbackSignal_uid51_fpAccTest_s, en, oRXOverflowFlagFeedback_uid52_fpAccTest_q, GND_q)
    BEGIN
        CASE (muxXOverflowFeedbackSignal_uid51_fpAccTest_s) IS
            WHEN "0" => muxXOverflowFeedbackSignal_uid51_fpAccTest_q <= oRXOverflowFlagFeedback_uid52_fpAccTest_q;
            WHEN "1" => muxXOverflowFeedbackSignal_uid51_fpAccTest_q <= GND_q;
            WHEN OTHERS => muxXOverflowFeedbackSignal_uid51_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oRXOverflowFlagFeedback_uid52_fpAccTest(LOGICAL,51)@1 + 1
    oRXOverflowFlagFeedback_uid52_fpAccTest_qi <= muxXOverflowFeedbackSignal_uid51_fpAccTest_q or cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c;
    oRXOverflowFlagFeedback_uid52_fpAccTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRXOverflowFlagFeedback_uid52_fpAccTest_qi, xout => oRXOverflowFlagFeedback_uid52_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- delayedXOverflowFeedbackSignal_uid50_fpAccTest(DELAY,49)
    delayedXOverflowFeedbackSignal_uid50_fpAccTest : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRXOverflowFlagFeedback_uid52_fpAccTest_q, xout => delayedXOverflowFeedbackSignal_uid50_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist11_accumulatorSign_uid29_fpAccTest_b_2(DELAY,236)
    redist11_accumulatorSign_uid29_fpAccTest_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => accumulatorSign_uid29_fpAccTest_b, xout => redist11_accumulatorSign_uid29_fpAccTest_b_2_q, ena => en(0), clk => clk, aclr => areset );

    -- zs_uid66_zeroCounter_uid37_fpAccTest(CONSTANT,65)
    zs_uid66_zeroCounter_uid37_fpAccTest_q <= "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- accValidRange_uid33_fpAccTest(BITSELECT,32)@1
    accValidRange_uid33_fpAccTest_in <= sum_uid27_fpAccTest_b(400 downto 0);
    accValidRange_uid33_fpAccTest_b <= accValidRange_uid33_fpAccTest_in(400 downto 0);

    -- accOnesComplement_uid34_fpAccTest(LOGICAL,33)@1
    accOnesComplement_uid34_fpAccTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((400 downto 1 => accumulatorSign_uid29_fpAccTest_b(0)) & accumulatorSign_uid29_fpAccTest_b));
    accOnesComplement_uid34_fpAccTest_q <= accValidRange_uid33_fpAccTest_b xor accOnesComplement_uid34_fpAccTest_b;

    -- accValuePositive_uid35_fpAccTest(ADD,34)@1
    accValuePositive_uid35_fpAccTest_a <= STD_LOGIC_VECTOR("0" & accOnesComplement_uid34_fpAccTest_q);
    accValuePositive_uid35_fpAccTest_b <= STD_LOGIC_VECTOR("00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & accumulatorSign_uid29_fpAccTest_b);
    accValuePositive_uid35_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(accValuePositive_uid35_fpAccTest_a) + UNSIGNED(accValuePositive_uid35_fpAccTest_b));
    accValuePositive_uid35_fpAccTest_q <= accValuePositive_uid35_fpAccTest_o(401 downto 0);

    -- posAccWoLeadingZeroBit_uid36_fpAccTest(BITSELECT,35)@1
    posAccWoLeadingZeroBit_uid36_fpAccTest_in <= accValuePositive_uid35_fpAccTest_q(399 downto 0);
    posAccWoLeadingZeroBit_uid36_fpAccTest_b <= posAccWoLeadingZeroBit_uid36_fpAccTest_in(399 downto 0);

    -- rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,216)@1
    rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= posAccWoLeadingZeroBit_uid36_fpAccTest_b(399 downto 144);
    rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= posAccWoLeadingZeroBit_uid36_fpAccTest_b(143 downto 0);

    -- vCount_uid68_zeroCounter_uid37_fpAccTest(LOGICAL,67)@1
    vCount_uid68_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid66_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- redist6_vCount_uid68_zeroCounter_uid37_fpAccTest_q_2(DELAY,231)
    redist6_vCount_uid68_zeroCounter_uid37_fpAccTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid68_zeroCounter_uid37_fpAccTest_q, xout => redist6_vCount_uid68_zeroCounter_uid37_fpAccTest_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- zs_uid74_zeroCounter_uid37_fpAccTest(CONSTANT,73)
    zs_uid74_zeroCounter_uid37_fpAccTest_q <= "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- mO_uid69_zeroCounter_uid37_fpAccTest(CONSTANT,68)
    mO_uid69_zeroCounter_uid37_fpAccTest_q <= "1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111";

    -- cStage_uid71_zeroCounter_uid37_fpAccTest(BITJOIN,70)@1
    cStage_uid71_zeroCounter_uid37_fpAccTest_q <= rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_c & mO_uid69_zeroCounter_uid37_fpAccTest_q;

    -- vStagei_uid73_zeroCounter_uid37_fpAccTest(MUX,72)@1 + 1
    vStagei_uid73_zeroCounter_uid37_fpAccTest_s <= vCount_uid68_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid73_zeroCounter_uid37_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            vStagei_uid73_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                CASE (vStagei_uid73_zeroCounter_uid37_fpAccTest_s) IS
                    WHEN "0" => vStagei_uid73_zeroCounter_uid37_fpAccTest_q <= rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
                    WHEN "1" => vStagei_uid73_zeroCounter_uid37_fpAccTest_q <= cStage_uid71_zeroCounter_uid37_fpAccTest_q;
                    WHEN OTHERS => vStagei_uid73_zeroCounter_uid37_fpAccTest_q <= (others => '0');
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    -- rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,217)@2
    rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid73_zeroCounter_uid37_fpAccTest_q(255 downto 128);
    rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid73_zeroCounter_uid37_fpAccTest_q(127 downto 0);

    -- vCount_uid76_zeroCounter_uid37_fpAccTest(LOGICAL,75)@2
    vCount_uid76_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid74_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- redist5_vCount_uid76_zeroCounter_uid37_fpAccTest_q_1(DELAY,230)
    redist5_vCount_uid76_zeroCounter_uid37_fpAccTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid76_zeroCounter_uid37_fpAccTest_q, xout => redist5_vCount_uid76_zeroCounter_uid37_fpAccTest_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid79_zeroCounter_uid37_fpAccTest(MUX,78)@2
    vStagei_uid79_zeroCounter_uid37_fpAccTest_s <= vCount_uid76_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid79_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid79_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid79_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid79_zeroCounter_uid37_fpAccTest_q <= rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid79_zeroCounter_uid37_fpAccTest_q <= rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid79_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,218)@2
    rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid79_zeroCounter_uid37_fpAccTest_q(127 downto 64);
    rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid79_zeroCounter_uid37_fpAccTest_q(63 downto 0);

    -- vCount_uid82_zeroCounter_uid37_fpAccTest(LOGICAL,81)@2
    vCount_uid82_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid80_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- redist4_vCount_uid82_zeroCounter_uid37_fpAccTest_q_1(DELAY,229)
    redist4_vCount_uid82_zeroCounter_uid37_fpAccTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid82_zeroCounter_uid37_fpAccTest_q, xout => redist4_vCount_uid82_zeroCounter_uid37_fpAccTest_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid85_zeroCounter_uid37_fpAccTest(MUX,84)@2
    vStagei_uid85_zeroCounter_uid37_fpAccTest_s <= vCount_uid82_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid85_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid85_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid85_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid85_zeroCounter_uid37_fpAccTest_q <= rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid85_zeroCounter_uid37_fpAccTest_q <= rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid85_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,219)@2
    rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid85_zeroCounter_uid37_fpAccTest_q(63 downto 32);
    rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid85_zeroCounter_uid37_fpAccTest_q(31 downto 0);

    -- vCount_uid88_zeroCounter_uid37_fpAccTest(LOGICAL,87)@2
    vCount_uid88_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid86_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- redist3_vCount_uid88_zeroCounter_uid37_fpAccTest_q_1(DELAY,228)
    redist3_vCount_uid88_zeroCounter_uid37_fpAccTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid88_zeroCounter_uid37_fpAccTest_q, xout => redist3_vCount_uid88_zeroCounter_uid37_fpAccTest_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid91_zeroCounter_uid37_fpAccTest(MUX,90)@2
    vStagei_uid91_zeroCounter_uid37_fpAccTest_s <= vCount_uid88_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid91_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid91_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid91_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid91_zeroCounter_uid37_fpAccTest_q <= rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid91_zeroCounter_uid37_fpAccTest_q <= rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid91_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,220)@2
    rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid91_zeroCounter_uid37_fpAccTest_q(31 downto 16);
    rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid91_zeroCounter_uid37_fpAccTest_q(15 downto 0);

    -- vCount_uid94_zeroCounter_uid37_fpAccTest(LOGICAL,93)@2
    vCount_uid94_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid92_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- redist2_vCount_uid94_zeroCounter_uid37_fpAccTest_q_1(DELAY,227)
    redist2_vCount_uid94_zeroCounter_uid37_fpAccTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid94_zeroCounter_uid37_fpAccTest_q, xout => redist2_vCount_uid94_zeroCounter_uid37_fpAccTest_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid97_zeroCounter_uid37_fpAccTest(MUX,96)@2
    vStagei_uid97_zeroCounter_uid37_fpAccTest_s <= vCount_uid94_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid97_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid97_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid97_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid97_zeroCounter_uid37_fpAccTest_q <= rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid97_zeroCounter_uid37_fpAccTest_q <= rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid97_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,221)@2
    rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid97_zeroCounter_uid37_fpAccTest_q(15 downto 8);
    rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid97_zeroCounter_uid37_fpAccTest_q(7 downto 0);

    -- vCount_uid100_zeroCounter_uid37_fpAccTest(LOGICAL,99)@2 + 1
    vCount_uid100_zeroCounter_uid37_fpAccTest_qi <= "1" WHEN rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zeroExponent_uid42_fpAccTest_q ELSE "0";
    vCount_uid100_zeroCounter_uid37_fpAccTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid100_zeroCounter_uid37_fpAccTest_qi, xout => vCount_uid100_zeroCounter_uid37_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist1_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c_1(DELAY,226)
    redist1_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c, xout => redist1_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => areset );

    -- redist0_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b_1(DELAY,225)
    redist0_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b, xout => redist0_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid103_zeroCounter_uid37_fpAccTest(MUX,102)@3
    vStagei_uid103_zeroCounter_uid37_fpAccTest_s <= vCount_uid100_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid103_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid103_zeroCounter_uid37_fpAccTest_s, en, redist0_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b_1_q, redist1_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c_1_q)
    BEGIN
        CASE (vStagei_uid103_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid103_zeroCounter_uid37_fpAccTest_q <= redist0_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b_1_q;
            WHEN "1" => vStagei_uid103_zeroCounter_uid37_fpAccTest_q <= redist1_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c_1_q;
            WHEN OTHERS => vStagei_uid103_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,222)@3
    rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid103_zeroCounter_uid37_fpAccTest_q(7 downto 4);
    rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid103_zeroCounter_uid37_fpAccTest_q(3 downto 0);

    -- vCount_uid106_zeroCounter_uid37_fpAccTest(LOGICAL,105)@3
    vCount_uid106_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid104_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- vStagei_uid109_zeroCounter_uid37_fpAccTest(MUX,108)@3
    vStagei_uid109_zeroCounter_uid37_fpAccTest_s <= vCount_uid106_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid109_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid109_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid109_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid109_zeroCounter_uid37_fpAccTest_q <= rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid109_zeroCounter_uid37_fpAccTest_q <= rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid109_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid111_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,223)@3
    rVStage_uid111_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid109_zeroCounter_uid37_fpAccTest_q(3 downto 2);
    rVStage_uid111_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid109_zeroCounter_uid37_fpAccTest_q(1 downto 0);

    -- vCount_uid112_zeroCounter_uid37_fpAccTest(LOGICAL,111)@3
    vCount_uid112_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid111_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid110_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- vStagei_uid115_zeroCounter_uid37_fpAccTest(MUX,114)@3
    vStagei_uid115_zeroCounter_uid37_fpAccTest_s <= vCount_uid112_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid115_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid115_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid111_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid111_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid115_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid115_zeroCounter_uid37_fpAccTest_q <= rVStage_uid111_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid115_zeroCounter_uid37_fpAccTest_q <= rVStage_uid111_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid115_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid117_zeroCounter_uid37_fpAccTest(BITSELECT,116)@3
    rVStage_uid117_zeroCounter_uid37_fpAccTest_b <= vStagei_uid115_zeroCounter_uid37_fpAccTest_q(1 downto 1);

    -- vCount_uid118_zeroCounter_uid37_fpAccTest(LOGICAL,117)@3
    vCount_uid118_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid117_zeroCounter_uid37_fpAccTest_b = GND_q ELSE "0";

    -- r_uid119_zeroCounter_uid37_fpAccTest(BITJOIN,118)@3
    r_uid119_zeroCounter_uid37_fpAccTest_q <= redist6_vCount_uid68_zeroCounter_uid37_fpAccTest_q_2_q & redist5_vCount_uid76_zeroCounter_uid37_fpAccTest_q_1_q & redist4_vCount_uid82_zeroCounter_uid37_fpAccTest_q_1_q & redist3_vCount_uid88_zeroCounter_uid37_fpAccTest_q_1_q & redist2_vCount_uid94_zeroCounter_uid37_fpAccTest_q_1_q & vCount_uid100_zeroCounter_uid37_fpAccTest_q & vCount_uid106_zeroCounter_uid37_fpAccTest_q & vCount_uid112_zeroCounter_uid37_fpAccTest_q & vCount_uid118_zeroCounter_uid37_fpAccTest_q;

    -- expRBias_uid41_fpAccTest(CONSTANT,40)
    expRBias_uid41_fpAccTest_q <= "111110001";

    -- resExpSub_uid43_fpAccTest(SUB,42)@3
    resExpSub_uid43_fpAccTest_a <= STD_LOGIC_VECTOR("0" & expRBias_uid41_fpAccTest_q);
    resExpSub_uid43_fpAccTest_b <= STD_LOGIC_VECTOR("0" & r_uid119_zeroCounter_uid37_fpAccTest_q);
    resExpSub_uid43_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(resExpSub_uid43_fpAccTest_a) - UNSIGNED(resExpSub_uid43_fpAccTest_b));
    resExpSub_uid43_fpAccTest_q <= resExpSub_uid43_fpAccTest_o(9 downto 0);

    -- finalExponent_uid44_fpAccTest(BITSELECT,43)@3
    finalExponent_uid44_fpAccTest_in <= resExpSub_uid43_fpAccTest_q(7 downto 0);
    finalExponent_uid44_fpAccTest_b <= finalExponent_uid44_fpAccTest_in(7 downto 0);

    -- ShiftedOutComparator_uid38_fpAccTest(CONSTANT,37)
    ShiftedOutComparator_uid38_fpAccTest_q <= "110010000";

    -- accResOutOfExpRange_uid39_fpAccTest(LOGICAL,38)@3
    accResOutOfExpRange_uid39_fpAccTest_q <= "1" WHEN ShiftedOutComparator_uid38_fpAccTest_q = r_uid119_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- finalExpUpdated_uid45_fpAccTest(MUX,44)@3
    finalExpUpdated_uid45_fpAccTest_s <= accResOutOfExpRange_uid39_fpAccTest_q;
    finalExpUpdated_uid45_fpAccTest_combproc: PROCESS (finalExpUpdated_uid45_fpAccTest_s, en, finalExponent_uid44_fpAccTest_b, zeroExponent_uid42_fpAccTest_q)
    BEGIN
        CASE (finalExpUpdated_uid45_fpAccTest_s) IS
            WHEN "0" => finalExpUpdated_uid45_fpAccTest_q <= finalExponent_uid44_fpAccTest_b;
            WHEN "1" => finalExpUpdated_uid45_fpAccTest_q <= zeroExponent_uid42_fpAccTest_q;
            WHEN OTHERS => finalExpUpdated_uid45_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage4Idx1Rng1_uid211_normalizationShifter_uid40_fpAccTest(BITSELECT,210)@3
    leftShiftStage4Idx1Rng1_uid211_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage3_uid209_normalizationShifter_uid40_fpAccTest_q(400 downto 0);
    leftShiftStage4Idx1Rng1_uid211_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage4Idx1Rng1_uid211_normalizationShifter_uid40_fpAccTest_in(400 downto 0);

    -- leftShiftStage4Idx1_uid212_normalizationShifter_uid40_fpAccTest(BITJOIN,211)@3
    leftShiftStage4Idx1_uid212_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage4Idx1Rng1_uid211_normalizationShifter_uid40_fpAccTest_b & GND_q;

    -- leftShiftStage3Idx3Rng6_uid206_normalizationShifter_uid40_fpAccTest(BITSELECT,205)@3
    leftShiftStage3Idx3Rng6_uid206_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_q(395 downto 0);
    leftShiftStage3Idx3Rng6_uid206_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage3Idx3Rng6_uid206_normalizationShifter_uid40_fpAccTest_in(395 downto 0);

    -- leftShiftStage3Idx3_uid207_normalizationShifter_uid40_fpAccTest(BITJOIN,206)@3
    leftShiftStage3Idx3_uid207_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage3Idx3Rng6_uid206_normalizationShifter_uid40_fpAccTest_b & rightShiftStage2Idx3Pad6_uid152_alignmentShifter_uid17_fpAccTest_q;

    -- leftShiftStage3Idx2Rng4_uid203_normalizationShifter_uid40_fpAccTest(BITSELECT,202)@3
    leftShiftStage3Idx2Rng4_uid203_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_q(397 downto 0);
    leftShiftStage3Idx2Rng4_uid203_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage3Idx2Rng4_uid203_normalizationShifter_uid40_fpAccTest_in(397 downto 0);

    -- leftShiftStage3Idx2_uid204_normalizationShifter_uid40_fpAccTest(BITJOIN,203)@3
    leftShiftStage3Idx2_uid204_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage3Idx2Rng4_uid203_normalizationShifter_uid40_fpAccTest_b & zs_uid104_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage3Idx1Rng2_uid200_normalizationShifter_uid40_fpAccTest(BITSELECT,199)@3
    leftShiftStage3Idx1Rng2_uid200_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_q(399 downto 0);
    leftShiftStage3Idx1Rng2_uid200_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage3Idx1Rng2_uid200_normalizationShifter_uid40_fpAccTest_in(399 downto 0);

    -- leftShiftStage3Idx1_uid201_normalizationShifter_uid40_fpAccTest(BITJOIN,200)@3
    leftShiftStage3Idx1_uid201_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage3Idx1Rng2_uid200_normalizationShifter_uid40_fpAccTest_b & zs_uid110_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage2Idx3Rng24_uid195_normalizationShifter_uid40_fpAccTest(BITSELECT,194)@3
    leftShiftStage2Idx3Rng24_uid195_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_q(377 downto 0);
    leftShiftStage2Idx3Rng24_uid195_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage2Idx3Rng24_uid195_normalizationShifter_uid40_fpAccTest_in(377 downto 0);

    -- leftShiftStage2Idx3_uid196_normalizationShifter_uid40_fpAccTest(BITJOIN,195)@3
    leftShiftStage2Idx3_uid196_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx3Rng24_uid195_normalizationShifter_uid40_fpAccTest_b & rightShiftStage1Idx3Pad24_uid141_alignmentShifter_uid17_fpAccTest_q;

    -- leftShiftStage2Idx2Rng16_uid192_normalizationShifter_uid40_fpAccTest(BITSELECT,191)@3
    leftShiftStage2Idx2Rng16_uid192_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_q(385 downto 0);
    leftShiftStage2Idx2Rng16_uid192_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage2Idx2Rng16_uid192_normalizationShifter_uid40_fpAccTest_in(385 downto 0);

    -- leftShiftStage2Idx2_uid193_normalizationShifter_uid40_fpAccTest(BITJOIN,192)@3
    leftShiftStage2Idx2_uid193_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx2Rng16_uid192_normalizationShifter_uid40_fpAccTest_b & zs_uid92_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage2Idx1Rng8_uid189_normalizationShifter_uid40_fpAccTest(BITSELECT,188)@3
    leftShiftStage2Idx1Rng8_uid189_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_q(393 downto 0);
    leftShiftStage2Idx1Rng8_uid189_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage2Idx1Rng8_uid189_normalizationShifter_uid40_fpAccTest_in(393 downto 0);

    -- leftShiftStage2Idx1_uid190_normalizationShifter_uid40_fpAccTest(BITJOIN,189)@3
    leftShiftStage2Idx1_uid190_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx1Rng8_uid189_normalizationShifter_uid40_fpAccTest_b & zeroExponent_uid42_fpAccTest_q;

    -- leftShiftStage1Idx3Rng96_uid184_normalizationShifter_uid40_fpAccTest(BITSELECT,183)@3
    leftShiftStage1Idx3Rng96_uid184_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_q(305 downto 0);
    leftShiftStage1Idx3Rng96_uid184_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage1Idx3Rng96_uid184_normalizationShifter_uid40_fpAccTest_in(305 downto 0);

    -- leftShiftStage1Idx3Pad96_uid183_normalizationShifter_uid40_fpAccTest(CONSTANT,182)
    leftShiftStage1Idx3Pad96_uid183_normalizationShifter_uid40_fpAccTest_q <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- leftShiftStage1Idx3_uid185_normalizationShifter_uid40_fpAccTest(BITJOIN,184)@3
    leftShiftStage1Idx3_uid185_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx3Rng96_uid184_normalizationShifter_uid40_fpAccTest_b & leftShiftStage1Idx3Pad96_uid183_normalizationShifter_uid40_fpAccTest_q;

    -- leftShiftStage1Idx2Rng64_uid181_normalizationShifter_uid40_fpAccTest(BITSELECT,180)@3
    leftShiftStage1Idx2Rng64_uid181_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_q(337 downto 0);
    leftShiftStage1Idx2Rng64_uid181_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage1Idx2Rng64_uid181_normalizationShifter_uid40_fpAccTest_in(337 downto 0);

    -- leftShiftStage1Idx2_uid182_normalizationShifter_uid40_fpAccTest(BITJOIN,181)@3
    leftShiftStage1Idx2_uid182_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx2Rng64_uid181_normalizationShifter_uid40_fpAccTest_b & zs_uid80_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage1Idx1Rng32_uid178_normalizationShifter_uid40_fpAccTest(BITSELECT,177)@3
    leftShiftStage1Idx1Rng32_uid178_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_q(369 downto 0);
    leftShiftStage1Idx1Rng32_uid178_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage1Idx1Rng32_uid178_normalizationShifter_uid40_fpAccTest_in(369 downto 0);

    -- leftShiftStage1Idx1_uid179_normalizationShifter_uid40_fpAccTest(BITJOIN,178)@3
    leftShiftStage1Idx1_uid179_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx1Rng32_uid178_normalizationShifter_uid40_fpAccTest_b & zs_uid86_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage0Idx3Rng384_uid173_normalizationShifter_uid40_fpAccTest(BITSELECT,172)@3
    leftShiftStage0Idx3Rng384_uid173_normalizationShifter_uid40_fpAccTest_in <= redist10_accValuePositive_uid35_fpAccTest_q_2_q(17 downto 0);
    leftShiftStage0Idx3Rng384_uid173_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage0Idx3Rng384_uid173_normalizationShifter_uid40_fpAccTest_in(17 downto 0);

    -- leftShiftStage0Idx3Pad384_uid172_normalizationShifter_uid40_fpAccTest(CONSTANT,171)
    leftShiftStage0Idx3Pad384_uid172_normalizationShifter_uid40_fpAccTest_q <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- leftShiftStage0Idx3_uid174_normalizationShifter_uid40_fpAccTest(BITJOIN,173)@3
    leftShiftStage0Idx3_uid174_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx3Rng384_uid173_normalizationShifter_uid40_fpAccTest_b & leftShiftStage0Idx3Pad384_uid172_normalizationShifter_uid40_fpAccTest_q;

    -- leftShiftStage0Idx2Rng256_uid170_normalizationShifter_uid40_fpAccTest(BITSELECT,169)@3
    leftShiftStage0Idx2Rng256_uid170_normalizationShifter_uid40_fpAccTest_in <= redist10_accValuePositive_uid35_fpAccTest_q_2_q(145 downto 0);
    leftShiftStage0Idx2Rng256_uid170_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage0Idx2Rng256_uid170_normalizationShifter_uid40_fpAccTest_in(145 downto 0);

    -- leftShiftStage0Idx2_uid171_normalizationShifter_uid40_fpAccTest(BITJOIN,170)@3
    leftShiftStage0Idx2_uid171_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx2Rng256_uid170_normalizationShifter_uid40_fpAccTest_b & zs_uid66_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage0Idx1Rng128_uid167_normalizationShifter_uid40_fpAccTest(BITSELECT,166)@3
    leftShiftStage0Idx1Rng128_uid167_normalizationShifter_uid40_fpAccTest_in <= redist10_accValuePositive_uid35_fpAccTest_q_2_q(273 downto 0);
    leftShiftStage0Idx1Rng128_uid167_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage0Idx1Rng128_uid167_normalizationShifter_uid40_fpAccTest_in(273 downto 0);

    -- leftShiftStage0Idx1_uid168_normalizationShifter_uid40_fpAccTest(BITJOIN,167)@3
    leftShiftStage0Idx1_uid168_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx1Rng128_uid167_normalizationShifter_uid40_fpAccTest_b & zs_uid74_zeroCounter_uid37_fpAccTest_q;

    -- redist10_accValuePositive_uid35_fpAccTest_q_2(DELAY,235)
    redist10_accValuePositive_uid35_fpAccTest_q_2 : dspba_delay
    GENERIC MAP ( width => 402, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => accValuePositive_uid35_fpAccTest_q, xout => redist10_accValuePositive_uid35_fpAccTest_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest(MUX,175)@3
    leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_s <= leftShiftStageSel8Dto7_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_b;
    leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_combproc: PROCESS (leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_s, en, redist10_accValuePositive_uid35_fpAccTest_q_2_q, leftShiftStage0Idx1_uid168_normalizationShifter_uid40_fpAccTest_q, leftShiftStage0Idx2_uid171_normalizationShifter_uid40_fpAccTest_q, leftShiftStage0Idx3_uid174_normalizationShifter_uid40_fpAccTest_q)
    BEGIN
        CASE (leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_s) IS
            WHEN "00" => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_q <= redist10_accValuePositive_uid35_fpAccTest_q_2_q;
            WHEN "01" => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx1_uid168_normalizationShifter_uid40_fpAccTest_q;
            WHEN "10" => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx2_uid171_normalizationShifter_uid40_fpAccTest_q;
            WHEN "11" => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx3_uid174_normalizationShifter_uid40_fpAccTest_q;
            WHEN OTHERS => leftShiftStage0_uid176_normalizationShifter_uid40_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest(MUX,186)@3
    leftShiftStage1_uid187_normalizationShifter_uid40_fpAccTest_s <= leftShiftStageSel8Dto7_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_c;
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

    -- leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest(MUX,197)@3
    leftShiftStage2_uid198_normalizationShifter_uid40_fpAccTest_s <= leftShiftStageSel8Dto7_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_d;
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

    -- leftShiftStage3_uid209_normalizationShifter_uid40_fpAccTest(MUX,208)@3
    leftShiftStage3_uid209_normalizationShifter_uid40_fpAccTest_s <= leftShiftStageSel8Dto7_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_e;
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

    -- leftShiftStageSel8Dto7_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select(BITSELECT,224)@3
    leftShiftStageSel8Dto7_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_b <= r_uid119_zeroCounter_uid37_fpAccTest_q(8 downto 7);
    leftShiftStageSel8Dto7_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_c <= r_uid119_zeroCounter_uid37_fpAccTest_q(6 downto 5);
    leftShiftStageSel8Dto7_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_d <= r_uid119_zeroCounter_uid37_fpAccTest_q(4 downto 3);
    leftShiftStageSel8Dto7_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_e <= r_uid119_zeroCounter_uid37_fpAccTest_q(2 downto 1);
    leftShiftStageSel8Dto7_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_f <= r_uid119_zeroCounter_uid37_fpAccTest_q(0 downto 0);

    -- leftShiftStage4_uid214_normalizationShifter_uid40_fpAccTest(MUX,213)@3
    leftShiftStage4_uid214_normalizationShifter_uid40_fpAccTest_s <= leftShiftStageSel8Dto7_uid175_normalizationShifter_uid40_fpAccTest_merged_bit_select_f;
    leftShiftStage4_uid214_normalizationShifter_uid40_fpAccTest_combproc: PROCESS (leftShiftStage4_uid214_normalizationShifter_uid40_fpAccTest_s, en, leftShiftStage3_uid209_normalizationShifter_uid40_fpAccTest_q, leftShiftStage4Idx1_uid212_normalizationShifter_uid40_fpAccTest_q)
    BEGIN
        CASE (leftShiftStage4_uid214_normalizationShifter_uid40_fpAccTest_s) IS
            WHEN "0" => leftShiftStage4_uid214_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage3_uid209_normalizationShifter_uid40_fpAccTest_q;
            WHEN "1" => leftShiftStage4_uid214_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage4Idx1_uid212_normalizationShifter_uid40_fpAccTest_q;
            WHEN OTHERS => leftShiftStage4_uid214_normalizationShifter_uid40_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fracR_uid46_fpAccTest(BITSELECT,45)@3
    fracR_uid46_fpAccTest_in <= leftShiftStage4_uid214_normalizationShifter_uid40_fpAccTest_q(398 downto 0);
    fracR_uid46_fpAccTest_b <= fracR_uid46_fpAccTest_in(398 downto 376);

    -- R_uid47_fpAccTest(BITJOIN,46)@3
    R_uid47_fpAccTest_q <= redist11_accumulatorSign_uid29_fpAccTest_b_2_q & finalExpUpdated_uid45_fpAccTest_q & fracR_uid46_fpAccTest_b;

    -- xOut(GPOUT,4)@3
    r <= R_uid47_fpAccTest_q;
    xo <= delayedXOverflowFeedbackSignal_uid50_fpAccTest_q;
    xu <= redist8_oRXUnderflowFlagFeedback_uid58_fpAccTest_q_3_q;
    ao <= delayedAccOverflowFeedbackSignal_uid60_fpAccTest_q;

END normal;
