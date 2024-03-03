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
-- VHDL created on Sun Mar  3 21:29:56 2024


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
    signal padConst_uid17_fpAccTest_q : STD_LOGIC_VECTOR (380 downto 0);
    signal rightPaddedIn_uid18_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal shiftedFracUpper_uid20_fpAccTest_b : STD_LOGIC_VECTOR (380 downto 0);
    signal extendedAlignedShiftedFrac_uid21_fpAccTest_q : STD_LOGIC_VECTOR (381 downto 0);
    signal onesComplementExtendedFrac_uid22_fpAccTest_b : STD_LOGIC_VECTOR (381 downto 0);
    signal onesComplementExtendedFrac_uid22_fpAccTest_q : STD_LOGIC_VECTOR (381 downto 0);
    signal accumulator_uid24_fpAccTest_a : STD_LOGIC_VECTOR (385 downto 0);
    signal accumulator_uid24_fpAccTest_b : STD_LOGIC_VECTOR (385 downto 0);
    signal accumulator_uid24_fpAccTest_i : STD_LOGIC_VECTOR (385 downto 0);
    signal accumulator_uid24_fpAccTest_o : STD_LOGIC_VECTOR (385 downto 0);
    signal accumulator_uid24_fpAccTest_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal accumulator_uid24_fpAccTest_c : STD_LOGIC_VECTOR (0 downto 0);
    signal accumulator_uid24_fpAccTest_q : STD_LOGIC_VECTOR (383 downto 0);
    signal os_uid25_fpAccTest_q : STD_LOGIC_VECTOR (384 downto 0);
    signal osr_uid26_fpAccTest_in : STD_LOGIC_VECTOR (383 downto 0);
    signal osr_uid26_fpAccTest_b : STD_LOGIC_VECTOR (383 downto 0);
    signal sum_uid27_fpAccTest_in : STD_LOGIC_VECTOR (382 downto 0);
    signal sum_uid27_fpAccTest_b : STD_LOGIC_VECTOR (382 downto 0);
    signal accumulatorSign_uid29_fpAccTest_in : STD_LOGIC_VECTOR (381 downto 0);
    signal accumulatorSign_uid29_fpAccTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal accOverflowBitMSB_uid30_fpAccTest_b : STD_LOGIC_VECTOR (0 downto 0);
    signal accOverflow_uid32_fpAccTest_q : STD_LOGIC_VECTOR (0 downto 0);
    signal accValidRange_uid33_fpAccTest_in : STD_LOGIC_VECTOR (381 downto 0);
    signal accValidRange_uid33_fpAccTest_b : STD_LOGIC_VECTOR (381 downto 0);
    signal accOnesComplement_uid34_fpAccTest_b : STD_LOGIC_VECTOR (381 downto 0);
    signal accOnesComplement_uid34_fpAccTest_q : STD_LOGIC_VECTOR (381 downto 0);
    signal accValuePositive_uid35_fpAccTest_a : STD_LOGIC_VECTOR (382 downto 0);
    signal accValuePositive_uid35_fpAccTest_b : STD_LOGIC_VECTOR (382 downto 0);
    signal accValuePositive_uid35_fpAccTest_o : STD_LOGIC_VECTOR (382 downto 0);
    signal accValuePositive_uid35_fpAccTest_q : STD_LOGIC_VECTOR (382 downto 0);
    signal posAccWoLeadingZeroBit_uid36_fpAccTest_in : STD_LOGIC_VECTOR (380 downto 0);
    signal posAccWoLeadingZeroBit_uid36_fpAccTest_b : STD_LOGIC_VECTOR (380 downto 0);
    signal ShiftedOutComparator_uid38_fpAccTest_q : STD_LOGIC_VECTOR (8 downto 0);
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
    signal fracR_uid46_fpAccTest_in : STD_LOGIC_VECTOR (379 downto 0);
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
    signal mO_uid69_zeroCounter_uid37_fpAccTest_q : STD_LOGIC_VECTOR (130 downto 0);
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
    signal wIntCst_uid123_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (8 downto 0);
    signal shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_a : STD_LOGIC_VECTOR (11 downto 0);
    signal shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (11 downto 0);
    signal shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_o : STD_LOGIC_VECTOR (11 downto 0);
    signal shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_n : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx1Rng128_uid125_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (276 downto 0);
    signal rightShiftStage0Idx1_uid127_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal rightShiftStage0Idx2Rng256_uid128_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (148 downto 0);
    signal rightShiftStage0Idx2_uid130_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal rightShiftStage0Idx3Rng384_uid131_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (20 downto 0);
    signal rightShiftStage0Idx3Pad384_uid132_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (383 downto 0);
    signal rightShiftStage0Idx3_uid133_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal rightShiftStage0_uid135_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid135_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal rightShiftStage1Idx1Rng32_uid136_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (372 downto 0);
    signal rightShiftStage1Idx1_uid138_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal rightShiftStage1Idx2Rng64_uid139_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (340 downto 0);
    signal rightShiftStage1Idx2_uid141_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal rightShiftStage1Idx3Rng96_uid142_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (308 downto 0);
    signal rightShiftStage1Idx3Pad96_uid143_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (95 downto 0);
    signal rightShiftStage1Idx3_uid144_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal rightShiftStage1_uid146_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid146_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal rightShiftStage2Idx1Rng8_uid147_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (396 downto 0);
    signal rightShiftStage2Idx1_uid149_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal rightShiftStage2Idx2Rng16_uid150_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (388 downto 0);
    signal rightShiftStage2Idx2_uid152_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal rightShiftStage2Idx3Rng24_uid153_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (380 downto 0);
    signal rightShiftStage2Idx3Pad24_uid154_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (23 downto 0);
    signal rightShiftStage2Idx3_uid155_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal rightShiftStage2_uid157_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage2_uid157_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal rightShiftStage3Idx1Rng2_uid158_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (402 downto 0);
    signal rightShiftStage3Idx1_uid160_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal rightShiftStage3Idx2Rng4_uid161_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (400 downto 0);
    signal rightShiftStage3Idx2_uid163_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal rightShiftStage3Idx3Rng6_uid164_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (398 downto 0);
    signal rightShiftStage3Idx3Pad6_uid165_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (5 downto 0);
    signal rightShiftStage3Idx3_uid166_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal rightShiftStage3_uid168_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage3_uid168_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal rightShiftStage4Idx1Rng1_uid169_alignmentShifter_uid17_fpAccTest_b : STD_LOGIC_VECTOR (403 downto 0);
    signal rightShiftStage4Idx1_uid171_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal rightShiftStage4_uid173_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage4_uid173_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal zeroOutCst_uid174_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal r_uid175_alignmentShifter_uid17_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid175_alignmentShifter_uid17_fpAccTest_q : STD_LOGIC_VECTOR (404 downto 0);
    signal leftShiftStage0Idx1Rng128_uid180_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (254 downto 0);
    signal leftShiftStage0Idx1Rng128_uid180_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (254 downto 0);
    signal leftShiftStage0Idx1_uid181_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (382 downto 0);
    signal leftShiftStage0Idx2Rng256_uid183_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (126 downto 0);
    signal leftShiftStage0Idx2Rng256_uid183_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (126 downto 0);
    signal leftShiftStage0Idx2_uid184_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (382 downto 0);
    signal leftShiftStage0Idx3_uid185_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (382 downto 0);
    signal leftShiftStage0_uid187_normalizationShifter_uid40_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid187_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (382 downto 0);
    signal leftShiftStage1Idx1Rng32_uid189_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (350 downto 0);
    signal leftShiftStage1Idx1Rng32_uid189_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (350 downto 0);
    signal leftShiftStage1Idx1_uid190_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (382 downto 0);
    signal leftShiftStage1Idx2Rng64_uid192_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (318 downto 0);
    signal leftShiftStage1Idx2Rng64_uid192_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (318 downto 0);
    signal leftShiftStage1Idx2_uid193_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (382 downto 0);
    signal leftShiftStage1Idx3Rng96_uid195_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (286 downto 0);
    signal leftShiftStage1Idx3Rng96_uid195_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (286 downto 0);
    signal leftShiftStage1Idx3_uid196_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (382 downto 0);
    signal leftShiftStage1_uid198_normalizationShifter_uid40_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid198_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (382 downto 0);
    signal leftShiftStage2Idx1Rng8_uid200_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (374 downto 0);
    signal leftShiftStage2Idx1Rng8_uid200_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (374 downto 0);
    signal leftShiftStage2Idx1_uid201_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (382 downto 0);
    signal leftShiftStage2Idx2Rng16_uid203_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (366 downto 0);
    signal leftShiftStage2Idx2Rng16_uid203_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (366 downto 0);
    signal leftShiftStage2Idx2_uid204_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (382 downto 0);
    signal leftShiftStage2Idx3Rng24_uid206_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (358 downto 0);
    signal leftShiftStage2Idx3Rng24_uid206_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (358 downto 0);
    signal leftShiftStage2Idx3_uid207_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (382 downto 0);
    signal leftShiftStage2_uid209_normalizationShifter_uid40_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage2_uid209_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (382 downto 0);
    signal leftShiftStage3Idx1Rng2_uid211_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (380 downto 0);
    signal leftShiftStage3Idx1Rng2_uid211_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (380 downto 0);
    signal leftShiftStage3Idx1_uid212_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (382 downto 0);
    signal leftShiftStage3Idx2Rng4_uid214_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (378 downto 0);
    signal leftShiftStage3Idx2Rng4_uid214_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (378 downto 0);
    signal leftShiftStage3Idx2_uid215_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (382 downto 0);
    signal leftShiftStage3Idx3Rng6_uid217_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (376 downto 0);
    signal leftShiftStage3Idx3Rng6_uid217_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (376 downto 0);
    signal leftShiftStage3Idx3_uid218_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (382 downto 0);
    signal leftShiftStage3_uid220_normalizationShifter_uid40_fpAccTest_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage3_uid220_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (382 downto 0);
    signal leftShiftStage4Idx1Rng1_uid222_normalizationShifter_uid40_fpAccTest_in : STD_LOGIC_VECTOR (381 downto 0);
    signal leftShiftStage4Idx1Rng1_uid222_normalizationShifter_uid40_fpAccTest_b : STD_LOGIC_VECTOR (381 downto 0);
    signal leftShiftStage4Idx1_uid223_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (382 downto 0);
    signal leftShiftStage4_uid225_normalizationShifter_uid40_fpAccTest_s : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage4_uid225_normalizationShifter_uid40_fpAccTest_q : STD_LOGIC_VECTOR (382 downto 0);
    signal rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_in : STD_LOGIC_VECTOR (8 downto 0);
    signal rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_d : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_e : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_f : STD_LOGIC_VECTOR (0 downto 0);
    signal rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (255 downto 0);
    signal rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (124 downto 0);
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
    signal leftShiftStageSel8Dto7_uid186_normalizationShifter_uid40_fpAccTest_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel8Dto7_uid186_normalizationShifter_uid40_fpAccTest_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel8Dto7_uid186_normalizationShifter_uid40_fpAccTest_merged_bit_select_d : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel8Dto7_uid186_normalizationShifter_uid40_fpAccTest_merged_bit_select_e : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel8Dto7_uid186_normalizationShifter_uid40_fpAccTest_merged_bit_select_f : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist1_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist2_vCount_uid94_zeroCounter_uid37_fpAccTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_vCount_uid88_zeroCounter_uid37_fpAccTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_vCount_uid82_zeroCounter_uid37_fpAccTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_vCount_uid76_zeroCounter_uid37_fpAccTest_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_vCount_uid68_zeroCounter_uid37_fpAccTest_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_oRXUnderflowFlagFeedback_uid58_fpAccTest_q_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_accValuePositive_uid35_fpAccTest_q_2_q : STD_LOGIC_VECTOR (382 downto 0);
    signal redist11_accumulatorSign_uid29_fpAccTest_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_shiftedFracUpper_uid20_fpAccTest_b_1_q : STD_LOGIC_VECTOR (380 downto 0);
    signal redist13_cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_signX_uid8_fpAccTest_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_xIn_n_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_xIn_n_2_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- signX_uid8_fpAccTest(BITSELECT,7)@0
    signX_uid8_fpAccTest_b <= STD_LOGIC_VECTOR(x(31 downto 31));

    -- redist14_signX_uid8_fpAccTest_b_1(DELAY,250)
    redist14_signX_uid8_fpAccTest_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => signX_uid8_fpAccTest_b, xout => redist14_signX_uid8_fpAccTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- redist15_xIn_n_1(DELAY,251)
    redist15_xIn_n_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => n, xout => redist15_xIn_n_1_q, ena => en(0), clk => clk, aclr => areset );

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- zeroOutCst_uid174_alignmentShifter_uid17_fpAccTest(CONSTANT,173)
    zeroOutCst_uid174_alignmentShifter_uid17_fpAccTest_q <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- rightShiftStage4Idx1Rng1_uid169_alignmentShifter_uid17_fpAccTest(BITSELECT,168)@0
    rightShiftStage4Idx1Rng1_uid169_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage3_uid168_alignmentShifter_uid17_fpAccTest_q(404 downto 1);

    -- rightShiftStage4Idx1_uid171_alignmentShifter_uid17_fpAccTest(BITJOIN,170)@0
    rightShiftStage4Idx1_uid171_alignmentShifter_uid17_fpAccTest_q <= GND_q & rightShiftStage4Idx1Rng1_uid169_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage3Idx3Pad6_uid165_alignmentShifter_uid17_fpAccTest(CONSTANT,164)
    rightShiftStage3Idx3Pad6_uid165_alignmentShifter_uid17_fpAccTest_q <= "000000";

    -- rightShiftStage3Idx3Rng6_uid164_alignmentShifter_uid17_fpAccTest(BITSELECT,163)@0
    rightShiftStage3Idx3Rng6_uid164_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage2_uid157_alignmentShifter_uid17_fpAccTest_q(404 downto 6);

    -- rightShiftStage3Idx3_uid166_alignmentShifter_uid17_fpAccTest(BITJOIN,165)@0
    rightShiftStage3Idx3_uid166_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage3Idx3Pad6_uid165_alignmentShifter_uid17_fpAccTest_q & rightShiftStage3Idx3Rng6_uid164_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid104_zeroCounter_uid37_fpAccTest(CONSTANT,103)
    zs_uid104_zeroCounter_uid37_fpAccTest_q <= "0000";

    -- rightShiftStage3Idx2Rng4_uid161_alignmentShifter_uid17_fpAccTest(BITSELECT,160)@0
    rightShiftStage3Idx2Rng4_uid161_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage2_uid157_alignmentShifter_uid17_fpAccTest_q(404 downto 4);

    -- rightShiftStage3Idx2_uid163_alignmentShifter_uid17_fpAccTest(BITJOIN,162)@0
    rightShiftStage3Idx2_uid163_alignmentShifter_uid17_fpAccTest_q <= zs_uid104_zeroCounter_uid37_fpAccTest_q & rightShiftStage3Idx2Rng4_uid161_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid110_zeroCounter_uid37_fpAccTest(CONSTANT,109)
    zs_uid110_zeroCounter_uid37_fpAccTest_q <= "00";

    -- rightShiftStage3Idx1Rng2_uid158_alignmentShifter_uid17_fpAccTest(BITSELECT,157)@0
    rightShiftStage3Idx1Rng2_uid158_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage2_uid157_alignmentShifter_uid17_fpAccTest_q(404 downto 2);

    -- rightShiftStage3Idx1_uid160_alignmentShifter_uid17_fpAccTest(BITJOIN,159)@0
    rightShiftStage3Idx1_uid160_alignmentShifter_uid17_fpAccTest_q <= zs_uid110_zeroCounter_uid37_fpAccTest_q & rightShiftStage3Idx1Rng2_uid158_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage2Idx3Pad24_uid154_alignmentShifter_uid17_fpAccTest(CONSTANT,153)
    rightShiftStage2Idx3Pad24_uid154_alignmentShifter_uid17_fpAccTest_q <= "000000000000000000000000";

    -- rightShiftStage2Idx3Rng24_uid153_alignmentShifter_uid17_fpAccTest(BITSELECT,152)@0
    rightShiftStage2Idx3Rng24_uid153_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage1_uid146_alignmentShifter_uid17_fpAccTest_q(404 downto 24);

    -- rightShiftStage2Idx3_uid155_alignmentShifter_uid17_fpAccTest(BITJOIN,154)@0
    rightShiftStage2Idx3_uid155_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage2Idx3Pad24_uid154_alignmentShifter_uid17_fpAccTest_q & rightShiftStage2Idx3Rng24_uid153_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid92_zeroCounter_uid37_fpAccTest(CONSTANT,91)
    zs_uid92_zeroCounter_uid37_fpAccTest_q <= "0000000000000000";

    -- rightShiftStage2Idx2Rng16_uid150_alignmentShifter_uid17_fpAccTest(BITSELECT,149)@0
    rightShiftStage2Idx2Rng16_uid150_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage1_uid146_alignmentShifter_uid17_fpAccTest_q(404 downto 16);

    -- rightShiftStage2Idx2_uid152_alignmentShifter_uid17_fpAccTest(BITJOIN,151)@0
    rightShiftStage2Idx2_uid152_alignmentShifter_uid17_fpAccTest_q <= zs_uid92_zeroCounter_uid37_fpAccTest_q & rightShiftStage2Idx2Rng16_uid150_alignmentShifter_uid17_fpAccTest_b;

    -- zeroExponent_uid42_fpAccTest(CONSTANT,41)
    zeroExponent_uid42_fpAccTest_q <= "00000000";

    -- rightShiftStage2Idx1Rng8_uid147_alignmentShifter_uid17_fpAccTest(BITSELECT,146)@0
    rightShiftStage2Idx1Rng8_uid147_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage1_uid146_alignmentShifter_uid17_fpAccTest_q(404 downto 8);

    -- rightShiftStage2Idx1_uid149_alignmentShifter_uid17_fpAccTest(BITJOIN,148)@0
    rightShiftStage2Idx1_uid149_alignmentShifter_uid17_fpAccTest_q <= zeroExponent_uid42_fpAccTest_q & rightShiftStage2Idx1Rng8_uid147_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage1Idx3Pad96_uid143_alignmentShifter_uid17_fpAccTest(CONSTANT,142)
    rightShiftStage1Idx3Pad96_uid143_alignmentShifter_uid17_fpAccTest_q <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- rightShiftStage1Idx3Rng96_uid142_alignmentShifter_uid17_fpAccTest(BITSELECT,141)@0
    rightShiftStage1Idx3Rng96_uid142_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage0_uid135_alignmentShifter_uid17_fpAccTest_q(404 downto 96);

    -- rightShiftStage1Idx3_uid144_alignmentShifter_uid17_fpAccTest(BITJOIN,143)@0
    rightShiftStage1Idx3_uid144_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1Idx3Pad96_uid143_alignmentShifter_uid17_fpAccTest_q & rightShiftStage1Idx3Rng96_uid142_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid80_zeroCounter_uid37_fpAccTest(CONSTANT,79)
    zs_uid80_zeroCounter_uid37_fpAccTest_q <= "0000000000000000000000000000000000000000000000000000000000000000";

    -- rightShiftStage1Idx2Rng64_uid139_alignmentShifter_uid17_fpAccTest(BITSELECT,138)@0
    rightShiftStage1Idx2Rng64_uid139_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage0_uid135_alignmentShifter_uid17_fpAccTest_q(404 downto 64);

    -- rightShiftStage1Idx2_uid141_alignmentShifter_uid17_fpAccTest(BITJOIN,140)@0
    rightShiftStage1Idx2_uid141_alignmentShifter_uid17_fpAccTest_q <= zs_uid80_zeroCounter_uid37_fpAccTest_q & rightShiftStage1Idx2Rng64_uid139_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid86_zeroCounter_uid37_fpAccTest(CONSTANT,85)
    zs_uid86_zeroCounter_uid37_fpAccTest_q <= "00000000000000000000000000000000";

    -- rightShiftStage1Idx1Rng32_uid136_alignmentShifter_uid17_fpAccTest(BITSELECT,135)@0
    rightShiftStage1Idx1Rng32_uid136_alignmentShifter_uid17_fpAccTest_b <= rightShiftStage0_uid135_alignmentShifter_uid17_fpAccTest_q(404 downto 32);

    -- rightShiftStage1Idx1_uid138_alignmentShifter_uid17_fpAccTest(BITJOIN,137)@0
    rightShiftStage1Idx1_uid138_alignmentShifter_uid17_fpAccTest_q <= zs_uid86_zeroCounter_uid37_fpAccTest_q & rightShiftStage1Idx1Rng32_uid136_alignmentShifter_uid17_fpAccTest_b;

    -- rightShiftStage0Idx3Pad384_uid132_alignmentShifter_uid17_fpAccTest(CONSTANT,131)
    rightShiftStage0Idx3Pad384_uid132_alignmentShifter_uid17_fpAccTest_q <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- rightShiftStage0Idx3Rng384_uid131_alignmentShifter_uid17_fpAccTest(BITSELECT,130)@0
    rightShiftStage0Idx3Rng384_uid131_alignmentShifter_uid17_fpAccTest_b <= rightPaddedIn_uid18_fpAccTest_q(404 downto 384);

    -- rightShiftStage0Idx3_uid133_alignmentShifter_uid17_fpAccTest(BITJOIN,132)@0
    rightShiftStage0Idx3_uid133_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0Idx3Pad384_uid132_alignmentShifter_uid17_fpAccTest_q & rightShiftStage0Idx3Rng384_uid131_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid66_zeroCounter_uid37_fpAccTest(CONSTANT,65)
    zs_uid66_zeroCounter_uid37_fpAccTest_q <= "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- rightShiftStage0Idx2Rng256_uid128_alignmentShifter_uid17_fpAccTest(BITSELECT,127)@0
    rightShiftStage0Idx2Rng256_uid128_alignmentShifter_uid17_fpAccTest_b <= rightPaddedIn_uid18_fpAccTest_q(404 downto 256);

    -- rightShiftStage0Idx2_uid130_alignmentShifter_uid17_fpAccTest(BITJOIN,129)@0
    rightShiftStage0Idx2_uid130_alignmentShifter_uid17_fpAccTest_q <= zs_uid66_zeroCounter_uid37_fpAccTest_q & rightShiftStage0Idx2Rng256_uid128_alignmentShifter_uid17_fpAccTest_b;

    -- zs_uid74_zeroCounter_uid37_fpAccTest(CONSTANT,73)
    zs_uid74_zeroCounter_uid37_fpAccTest_q <= "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- rightShiftStage0Idx1Rng128_uid125_alignmentShifter_uid17_fpAccTest(BITSELECT,124)@0
    rightShiftStage0Idx1Rng128_uid125_alignmentShifter_uid17_fpAccTest_b <= rightPaddedIn_uid18_fpAccTest_q(404 downto 128);

    -- rightShiftStage0Idx1_uid127_alignmentShifter_uid17_fpAccTest(BITJOIN,126)@0
    rightShiftStage0Idx1_uid127_alignmentShifter_uid17_fpAccTest_q <= zs_uid74_zeroCounter_uid37_fpAccTest_q & rightShiftStage0Idx1Rng128_uid125_alignmentShifter_uid17_fpAccTest_b;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- fracX_uid7_fpAccTest(BITSELECT,6)@0
    fracX_uid7_fpAccTest_b <= x(22 downto 0);

    -- oFracX_uid10_fpAccTest(BITJOIN,9)@0
    oFracX_uid10_fpAccTest_q <= VCC_q & fracX_uid7_fpAccTest_b;

    -- padConst_uid17_fpAccTest(CONSTANT,16)
    padConst_uid17_fpAccTest_q <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- rightPaddedIn_uid18_fpAccTest(BITJOIN,17)@0
    rightPaddedIn_uid18_fpAccTest_q <= oFracX_uid10_fpAccTest_q & padConst_uid17_fpAccTest_q;

    -- rightShiftStage0_uid135_alignmentShifter_uid17_fpAccTest(MUX,134)@0
    rightShiftStage0_uid135_alignmentShifter_uid17_fpAccTest_s <= rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_b;
    rightShiftStage0_uid135_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (rightShiftStage0_uid135_alignmentShifter_uid17_fpAccTest_s, en, rightPaddedIn_uid18_fpAccTest_q, rightShiftStage0Idx1_uid127_alignmentShifter_uid17_fpAccTest_q, rightShiftStage0Idx2_uid130_alignmentShifter_uid17_fpAccTest_q, rightShiftStage0Idx3_uid133_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (rightShiftStage0_uid135_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "00" => rightShiftStage0_uid135_alignmentShifter_uid17_fpAccTest_q <= rightPaddedIn_uid18_fpAccTest_q;
            WHEN "01" => rightShiftStage0_uid135_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0Idx1_uid127_alignmentShifter_uid17_fpAccTest_q;
            WHEN "10" => rightShiftStage0_uid135_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0Idx2_uid130_alignmentShifter_uid17_fpAccTest_q;
            WHEN "11" => rightShiftStage0_uid135_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0Idx3_uid133_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => rightShiftStage0_uid135_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStage1_uid146_alignmentShifter_uid17_fpAccTest(MUX,145)@0
    rightShiftStage1_uid146_alignmentShifter_uid17_fpAccTest_s <= rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_c;
    rightShiftStage1_uid146_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (rightShiftStage1_uid146_alignmentShifter_uid17_fpAccTest_s, en, rightShiftStage0_uid135_alignmentShifter_uid17_fpAccTest_q, rightShiftStage1Idx1_uid138_alignmentShifter_uid17_fpAccTest_q, rightShiftStage1Idx2_uid141_alignmentShifter_uid17_fpAccTest_q, rightShiftStage1Idx3_uid144_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (rightShiftStage1_uid146_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "00" => rightShiftStage1_uid146_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage0_uid135_alignmentShifter_uid17_fpAccTest_q;
            WHEN "01" => rightShiftStage1_uid146_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1Idx1_uid138_alignmentShifter_uid17_fpAccTest_q;
            WHEN "10" => rightShiftStage1_uid146_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1Idx2_uid141_alignmentShifter_uid17_fpAccTest_q;
            WHEN "11" => rightShiftStage1_uid146_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1Idx3_uid144_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => rightShiftStage1_uid146_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStage2_uid157_alignmentShifter_uid17_fpAccTest(MUX,156)@0
    rightShiftStage2_uid157_alignmentShifter_uid17_fpAccTest_s <= rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_d;
    rightShiftStage2_uid157_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (rightShiftStage2_uid157_alignmentShifter_uid17_fpAccTest_s, en, rightShiftStage1_uid146_alignmentShifter_uid17_fpAccTest_q, rightShiftStage2Idx1_uid149_alignmentShifter_uid17_fpAccTest_q, rightShiftStage2Idx2_uid152_alignmentShifter_uid17_fpAccTest_q, rightShiftStage2Idx3_uid155_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (rightShiftStage2_uid157_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "00" => rightShiftStage2_uid157_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage1_uid146_alignmentShifter_uid17_fpAccTest_q;
            WHEN "01" => rightShiftStage2_uid157_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage2Idx1_uid149_alignmentShifter_uid17_fpAccTest_q;
            WHEN "10" => rightShiftStage2_uid157_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage2Idx2_uid152_alignmentShifter_uid17_fpAccTest_q;
            WHEN "11" => rightShiftStage2_uid157_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage2Idx3_uid155_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => rightShiftStage2_uid157_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStage3_uid168_alignmentShifter_uid17_fpAccTest(MUX,167)@0
    rightShiftStage3_uid168_alignmentShifter_uid17_fpAccTest_s <= rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_e;
    rightShiftStage3_uid168_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (rightShiftStage3_uid168_alignmentShifter_uid17_fpAccTest_s, en, rightShiftStage2_uid157_alignmentShifter_uid17_fpAccTest_q, rightShiftStage3Idx1_uid160_alignmentShifter_uid17_fpAccTest_q, rightShiftStage3Idx2_uid163_alignmentShifter_uid17_fpAccTest_q, rightShiftStage3Idx3_uid166_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (rightShiftStage3_uid168_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "00" => rightShiftStage3_uid168_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage2_uid157_alignmentShifter_uid17_fpAccTest_q;
            WHEN "01" => rightShiftStage3_uid168_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage3Idx1_uid160_alignmentShifter_uid17_fpAccTest_q;
            WHEN "10" => rightShiftStage3_uid168_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage3Idx2_uid163_alignmentShifter_uid17_fpAccTest_q;
            WHEN "11" => rightShiftStage3_uid168_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage3Idx3_uid166_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => rightShiftStage3_uid168_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- expX_uid6_fpAccTest(BITSELECT,5)@0
    expX_uid6_fpAccTest_b <= x(30 downto 23);

    -- rShiftConstant_uid15_fpAccTest(CONSTANT,14)
    rShiftConstant_uid15_fpAccTest_q <= "101111110";

    -- rightShiftValue_uid16_fpAccTest(SUB,15)@0
    rightShiftValue_uid16_fpAccTest_a <= STD_LOGIC_VECTOR("0" & rShiftConstant_uid15_fpAccTest_q);
    rightShiftValue_uid16_fpAccTest_b <= STD_LOGIC_VECTOR("00" & expX_uid6_fpAccTest_b);
    rightShiftValue_uid16_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(rightShiftValue_uid16_fpAccTest_a) - UNSIGNED(rightShiftValue_uid16_fpAccTest_b));
    rightShiftValue_uid16_fpAccTest_q <= rightShiftValue_uid16_fpAccTest_o(9 downto 0);

    -- rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select(BITSELECT,226)@0
    rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_in <= rightShiftValue_uid16_fpAccTest_q(8 downto 0);
    rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_b <= rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_in(8 downto 7);
    rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_c <= rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_in(6 downto 5);
    rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_d <= rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_in(4 downto 3);
    rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_e <= rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_in(2 downto 1);
    rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_f <= rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_in(0 downto 0);

    -- rightShiftStage4_uid173_alignmentShifter_uid17_fpAccTest(MUX,172)@0
    rightShiftStage4_uid173_alignmentShifter_uid17_fpAccTest_s <= rightShiftStageSel8Dto7_uid134_alignmentShifter_uid17_fpAccTest_merged_bit_select_f;
    rightShiftStage4_uid173_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (rightShiftStage4_uid173_alignmentShifter_uid17_fpAccTest_s, en, rightShiftStage3_uid168_alignmentShifter_uid17_fpAccTest_q, rightShiftStage4Idx1_uid171_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (rightShiftStage4_uid173_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "0" => rightShiftStage4_uid173_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage3_uid168_alignmentShifter_uid17_fpAccTest_q;
            WHEN "1" => rightShiftStage4_uid173_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage4Idx1_uid171_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => rightShiftStage4_uid173_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- wIntCst_uid123_alignmentShifter_uid17_fpAccTest(CONSTANT,122)
    wIntCst_uid123_alignmentShifter_uid17_fpAccTest_q <= "110010101";

    -- shiftedOut_uid124_alignmentShifter_uid17_fpAccTest(COMPARE,123)@0
    shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_a <= STD_LOGIC_VECTOR("00" & rightShiftValue_uid16_fpAccTest_q);
    shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_b <= STD_LOGIC_VECTOR("000" & wIntCst_uid123_alignmentShifter_uid17_fpAccTest_q);
    shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_a) - UNSIGNED(shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_b));
    shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_n(0) <= not (shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_o(11));

    -- r_uid175_alignmentShifter_uid17_fpAccTest(MUX,174)@0
    r_uid175_alignmentShifter_uid17_fpAccTest_s <= shiftedOut_uid124_alignmentShifter_uid17_fpAccTest_n;
    r_uid175_alignmentShifter_uid17_fpAccTest_combproc: PROCESS (r_uid175_alignmentShifter_uid17_fpAccTest_s, en, rightShiftStage4_uid173_alignmentShifter_uid17_fpAccTest_q, zeroOutCst_uid174_alignmentShifter_uid17_fpAccTest_q)
    BEGIN
        CASE (r_uid175_alignmentShifter_uid17_fpAccTest_s) IS
            WHEN "0" => r_uid175_alignmentShifter_uid17_fpAccTest_q <= rightShiftStage4_uid173_alignmentShifter_uid17_fpAccTest_q;
            WHEN "1" => r_uid175_alignmentShifter_uid17_fpAccTest_q <= zeroOutCst_uid174_alignmentShifter_uid17_fpAccTest_q;
            WHEN OTHERS => r_uid175_alignmentShifter_uid17_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- shiftedFracUpper_uid20_fpAccTest(BITSELECT,19)@0
    shiftedFracUpper_uid20_fpAccTest_b <= r_uid175_alignmentShifter_uid17_fpAccTest_q(404 downto 24);

    -- redist12_shiftedFracUpper_uid20_fpAccTest_b_1(DELAY,248)
    redist12_shiftedFracUpper_uid20_fpAccTest_b_1 : dspba_delay
    GENERIC MAP ( width => 381, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => shiftedFracUpper_uid20_fpAccTest_b, xout => redist12_shiftedFracUpper_uid20_fpAccTest_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- extendedAlignedShiftedFrac_uid21_fpAccTest(BITJOIN,20)@1
    extendedAlignedShiftedFrac_uid21_fpAccTest_q <= GND_q & redist12_shiftedFracUpper_uid20_fpAccTest_b_1_q;

    -- onesComplementExtendedFrac_uid22_fpAccTest(LOGICAL,21)@1
    onesComplementExtendedFrac_uid22_fpAccTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((381 downto 1 => redist14_signX_uid8_fpAccTest_b_1_q(0)) & redist14_signX_uid8_fpAccTest_b_1_q));
    onesComplementExtendedFrac_uid22_fpAccTest_q <= extendedAlignedShiftedFrac_uid21_fpAccTest_q xor onesComplementExtendedFrac_uid22_fpAccTest_b;

    -- accumulator_uid24_fpAccTest(ADD,23)@1 + 1
    accumulator_uid24_fpAccTest_cin <= redist14_signX_uid8_fpAccTest_b_1_q;
    accumulator_uid24_fpAccTest_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((384 downto 383 => sum_uid27_fpAccTest_b(382)) & sum_uid27_fpAccTest_b) & '1');
    accumulator_uid24_fpAccTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((384 downto 382 => onesComplementExtendedFrac_uid22_fpAccTest_q(381)) & onesComplementExtendedFrac_uid22_fpAccTest_q) & accumulator_uid24_fpAccTest_cin(0));
    accumulator_uid24_fpAccTest_i <= accumulator_uid24_fpAccTest_b;
    accumulator_uid24_fpAccTest_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            accumulator_uid24_fpAccTest_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (en = "1") THEN
                IF (redist15_xIn_n_1_q = "1") THEN
                    accumulator_uid24_fpAccTest_o <= accumulator_uid24_fpAccTest_i;
                ELSE
                    accumulator_uid24_fpAccTest_o <= STD_LOGIC_VECTOR(SIGNED(accumulator_uid24_fpAccTest_a) + SIGNED(accumulator_uid24_fpAccTest_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    accumulator_uid24_fpAccTest_c(0) <= accumulator_uid24_fpAccTest_o(385);
    accumulator_uid24_fpAccTest_q <= accumulator_uid24_fpAccTest_o(384 downto 1);

    -- os_uid25_fpAccTest(BITJOIN,24)@2
    os_uid25_fpAccTest_q <= accumulator_uid24_fpAccTest_c & accumulator_uid24_fpAccTest_q;

    -- osr_uid26_fpAccTest(BITSELECT,25)@2
    osr_uid26_fpAccTest_in <= STD_LOGIC_VECTOR(os_uid25_fpAccTest_q(383 downto 0));
    osr_uid26_fpAccTest_b <= STD_LOGIC_VECTOR(osr_uid26_fpAccTest_in(383 downto 0));

    -- sum_uid27_fpAccTest(BITSELECT,26)@2
    sum_uid27_fpAccTest_in <= STD_LOGIC_VECTOR(osr_uid26_fpAccTest_b(382 downto 0));
    sum_uid27_fpAccTest_b <= STD_LOGIC_VECTOR(sum_uid27_fpAccTest_in(382 downto 0));

    -- accumulatorSign_uid29_fpAccTest(BITSELECT,28)@2
    accumulatorSign_uid29_fpAccTest_in <= sum_uid27_fpAccTest_b(381 downto 0);
    accumulatorSign_uid29_fpAccTest_b <= accumulatorSign_uid29_fpAccTest_in(381 downto 381);

    -- accOverflowBitMSB_uid30_fpAccTest(BITSELECT,29)@2
    accOverflowBitMSB_uid30_fpAccTest_b <= sum_uid27_fpAccTest_b(382 downto 382);

    -- accOverflow_uid32_fpAccTest(LOGICAL,31)@2
    accOverflow_uid32_fpAccTest_q <= accOverflowBitMSB_uid30_fpAccTest_b xor accumulatorSign_uid29_fpAccTest_b;

    -- redist16_xIn_n_2(DELAY,252)
    redist16_xIn_n_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => redist15_xIn_n_1_q, xout => redist16_xIn_n_2_q, ena => en(0), clk => clk, aclr => areset );

    -- muxAccOverflowFeedbackSignal_uid61_fpAccTest(MUX,60)@2
    muxAccOverflowFeedbackSignal_uid61_fpAccTest_s <= redist16_xIn_n_2_q;
    muxAccOverflowFeedbackSignal_uid61_fpAccTest_combproc: PROCESS (muxAccOverflowFeedbackSignal_uid61_fpAccTest_s, en, oRAccOverflowFlagFeedback_uid62_fpAccTest_q, GND_q)
    BEGIN
        CASE (muxAccOverflowFeedbackSignal_uid61_fpAccTest_s) IS
            WHEN "0" => muxAccOverflowFeedbackSignal_uid61_fpAccTest_q <= oRAccOverflowFlagFeedback_uid62_fpAccTest_q;
            WHEN "1" => muxAccOverflowFeedbackSignal_uid61_fpAccTest_q <= GND_q;
            WHEN OTHERS => muxAccOverflowFeedbackSignal_uid61_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oRAccOverflowFlagFeedback_uid62_fpAccTest(LOGICAL,61)@2 + 1
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
    expLTLSBA_uid11_fpAccTest_q <= "00000001";

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

    -- redist8_oRXUnderflowFlagFeedback_uid58_fpAccTest_q_4(DELAY,244)
    redist8_oRXUnderflowFlagFeedback_uid58_fpAccTest_q_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRXUnderflowFlagFeedback_uid58_fpAccTest_q, xout => redist8_oRXUnderflowFlagFeedback_uid58_fpAccTest_q_4_q, ena => en(0), clk => clk, aclr => areset );

    -- expGTMaxMSBX_uid13_fpAccTest(CONSTANT,12)
    expGTMaxMSBX_uid13_fpAccTest_q <= "01111110";

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

    -- redist13_cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c_2(DELAY,249)
    redist13_cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c, xout => redist13_cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c_2_q, ena => en(0), clk => clk, aclr => areset );

    -- muxXOverflowFeedbackSignal_uid51_fpAccTest(MUX,50)@2
    muxXOverflowFeedbackSignal_uid51_fpAccTest_s <= redist16_xIn_n_2_q;
    muxXOverflowFeedbackSignal_uid51_fpAccTest_combproc: PROCESS (muxXOverflowFeedbackSignal_uid51_fpAccTest_s, en, oRXOverflowFlagFeedback_uid52_fpAccTest_q, GND_q)
    BEGIN
        CASE (muxXOverflowFeedbackSignal_uid51_fpAccTest_s) IS
            WHEN "0" => muxXOverflowFeedbackSignal_uid51_fpAccTest_q <= oRXOverflowFlagFeedback_uid52_fpAccTest_q;
            WHEN "1" => muxXOverflowFeedbackSignal_uid51_fpAccTest_q <= GND_q;
            WHEN OTHERS => muxXOverflowFeedbackSignal_uid51_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oRXOverflowFlagFeedback_uid52_fpAccTest(LOGICAL,51)@2 + 1
    oRXOverflowFlagFeedback_uid52_fpAccTest_qi <= muxXOverflowFeedbackSignal_uid51_fpAccTest_q or redist13_cmpGT_expX_expGTMaxMSBX_uid14_fpAccTest_c_2_q;
    oRXOverflowFlagFeedback_uid52_fpAccTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRXOverflowFlagFeedback_uid52_fpAccTest_qi, xout => oRXOverflowFlagFeedback_uid52_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- delayedXOverflowFeedbackSignal_uid50_fpAccTest(DELAY,49)
    delayedXOverflowFeedbackSignal_uid50_fpAccTest : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => oRXOverflowFlagFeedback_uid52_fpAccTest_q, xout => delayedXOverflowFeedbackSignal_uid50_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist11_accumulatorSign_uid29_fpAccTest_b_2(DELAY,247)
    redist11_accumulatorSign_uid29_fpAccTest_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => accumulatorSign_uid29_fpAccTest_b, xout => redist11_accumulatorSign_uid29_fpAccTest_b_2_q, ena => en(0), clk => clk, aclr => areset );

    -- accValidRange_uid33_fpAccTest(BITSELECT,32)@2
    accValidRange_uid33_fpAccTest_in <= sum_uid27_fpAccTest_b(381 downto 0);
    accValidRange_uid33_fpAccTest_b <= accValidRange_uid33_fpAccTest_in(381 downto 0);

    -- accOnesComplement_uid34_fpAccTest(LOGICAL,33)@2
    accOnesComplement_uid34_fpAccTest_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((381 downto 1 => accumulatorSign_uid29_fpAccTest_b(0)) & accumulatorSign_uid29_fpAccTest_b));
    accOnesComplement_uid34_fpAccTest_q <= accValidRange_uid33_fpAccTest_b xor accOnesComplement_uid34_fpAccTest_b;

    -- accValuePositive_uid35_fpAccTest(ADD,34)@2
    accValuePositive_uid35_fpAccTest_a <= STD_LOGIC_VECTOR("0" & accOnesComplement_uid34_fpAccTest_q);
    accValuePositive_uid35_fpAccTest_b <= STD_LOGIC_VECTOR("0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & accumulatorSign_uid29_fpAccTest_b);
    accValuePositive_uid35_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(accValuePositive_uid35_fpAccTest_a) + UNSIGNED(accValuePositive_uid35_fpAccTest_b));
    accValuePositive_uid35_fpAccTest_q <= accValuePositive_uid35_fpAccTest_o(382 downto 0);

    -- posAccWoLeadingZeroBit_uid36_fpAccTest(BITSELECT,35)@2
    posAccWoLeadingZeroBit_uid36_fpAccTest_in <= accValuePositive_uid35_fpAccTest_q(380 downto 0);
    posAccWoLeadingZeroBit_uid36_fpAccTest_b <= posAccWoLeadingZeroBit_uid36_fpAccTest_in(380 downto 0);

    -- rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,227)@2
    rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= posAccWoLeadingZeroBit_uid36_fpAccTest_b(380 downto 125);
    rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= posAccWoLeadingZeroBit_uid36_fpAccTest_b(124 downto 0);

    -- vCount_uid68_zeroCounter_uid37_fpAccTest(LOGICAL,67)@2
    vCount_uid68_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid66_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- redist6_vCount_uid68_zeroCounter_uid37_fpAccTest_q_2(DELAY,242)
    redist6_vCount_uid68_zeroCounter_uid37_fpAccTest_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid68_zeroCounter_uid37_fpAccTest_q, xout => redist6_vCount_uid68_zeroCounter_uid37_fpAccTest_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- mO_uid69_zeroCounter_uid37_fpAccTest(CONSTANT,68)
    mO_uid69_zeroCounter_uid37_fpAccTest_q <= "11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111";

    -- cStage_uid71_zeroCounter_uid37_fpAccTest(BITJOIN,70)@2
    cStage_uid71_zeroCounter_uid37_fpAccTest_q <= rVStage_uid67_zeroCounter_uid37_fpAccTest_merged_bit_select_c & mO_uid69_zeroCounter_uid37_fpAccTest_q;

    -- vStagei_uid73_zeroCounter_uid37_fpAccTest(MUX,72)@2 + 1
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

    -- rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,228)@3
    rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid73_zeroCounter_uid37_fpAccTest_q(255 downto 128);
    rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid73_zeroCounter_uid37_fpAccTest_q(127 downto 0);

    -- vCount_uid76_zeroCounter_uid37_fpAccTest(LOGICAL,75)@3
    vCount_uid76_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid74_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- redist5_vCount_uid76_zeroCounter_uid37_fpAccTest_q_1(DELAY,241)
    redist5_vCount_uid76_zeroCounter_uid37_fpAccTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid76_zeroCounter_uid37_fpAccTest_q, xout => redist5_vCount_uid76_zeroCounter_uid37_fpAccTest_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid79_zeroCounter_uid37_fpAccTest(MUX,78)@3
    vStagei_uid79_zeroCounter_uid37_fpAccTest_s <= vCount_uid76_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid79_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid79_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid79_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid79_zeroCounter_uid37_fpAccTest_q <= rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid79_zeroCounter_uid37_fpAccTest_q <= rVStage_uid75_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid79_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,229)@3
    rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid79_zeroCounter_uid37_fpAccTest_q(127 downto 64);
    rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid79_zeroCounter_uid37_fpAccTest_q(63 downto 0);

    -- vCount_uid82_zeroCounter_uid37_fpAccTest(LOGICAL,81)@3
    vCount_uid82_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid80_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- redist4_vCount_uid82_zeroCounter_uid37_fpAccTest_q_1(DELAY,240)
    redist4_vCount_uid82_zeroCounter_uid37_fpAccTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid82_zeroCounter_uid37_fpAccTest_q, xout => redist4_vCount_uid82_zeroCounter_uid37_fpAccTest_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid85_zeroCounter_uid37_fpAccTest(MUX,84)@3
    vStagei_uid85_zeroCounter_uid37_fpAccTest_s <= vCount_uid82_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid85_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid85_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid85_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid85_zeroCounter_uid37_fpAccTest_q <= rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid85_zeroCounter_uid37_fpAccTest_q <= rVStage_uid81_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid85_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,230)@3
    rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid85_zeroCounter_uid37_fpAccTest_q(63 downto 32);
    rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid85_zeroCounter_uid37_fpAccTest_q(31 downto 0);

    -- vCount_uid88_zeroCounter_uid37_fpAccTest(LOGICAL,87)@3
    vCount_uid88_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid86_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- redist3_vCount_uid88_zeroCounter_uid37_fpAccTest_q_1(DELAY,239)
    redist3_vCount_uid88_zeroCounter_uid37_fpAccTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid88_zeroCounter_uid37_fpAccTest_q, xout => redist3_vCount_uid88_zeroCounter_uid37_fpAccTest_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid91_zeroCounter_uid37_fpAccTest(MUX,90)@3
    vStagei_uid91_zeroCounter_uid37_fpAccTest_s <= vCount_uid88_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid91_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid91_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid91_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid91_zeroCounter_uid37_fpAccTest_q <= rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid91_zeroCounter_uid37_fpAccTest_q <= rVStage_uid87_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid91_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,231)@3
    rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid91_zeroCounter_uid37_fpAccTest_q(31 downto 16);
    rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid91_zeroCounter_uid37_fpAccTest_q(15 downto 0);

    -- vCount_uid94_zeroCounter_uid37_fpAccTest(LOGICAL,93)@3
    vCount_uid94_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid92_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- redist2_vCount_uid94_zeroCounter_uid37_fpAccTest_q_1(DELAY,238)
    redist2_vCount_uid94_zeroCounter_uid37_fpAccTest_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid94_zeroCounter_uid37_fpAccTest_q, xout => redist2_vCount_uid94_zeroCounter_uid37_fpAccTest_q_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid97_zeroCounter_uid37_fpAccTest(MUX,96)@3
    vStagei_uid97_zeroCounter_uid37_fpAccTest_s <= vCount_uid94_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid97_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid97_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid97_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid97_zeroCounter_uid37_fpAccTest_q <= rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid97_zeroCounter_uid37_fpAccTest_q <= rVStage_uid93_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid97_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,232)@3
    rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid97_zeroCounter_uid37_fpAccTest_q(15 downto 8);
    rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid97_zeroCounter_uid37_fpAccTest_q(7 downto 0);

    -- vCount_uid100_zeroCounter_uid37_fpAccTest(LOGICAL,99)@3 + 1
    vCount_uid100_zeroCounter_uid37_fpAccTest_qi <= "1" WHEN rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zeroExponent_uid42_fpAccTest_q ELSE "0";
    vCount_uid100_zeroCounter_uid37_fpAccTest_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => vCount_uid100_zeroCounter_uid37_fpAccTest_qi, xout => vCount_uid100_zeroCounter_uid37_fpAccTest_q, ena => en(0), clk => clk, aclr => areset );

    -- redist1_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c_1(DELAY,237)
    redist1_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c, xout => redist1_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c_1_q, ena => en(0), clk => clk, aclr => areset );

    -- redist0_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b_1(DELAY,236)
    redist0_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b, xout => redist0_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b_1_q, ena => en(0), clk => clk, aclr => areset );

    -- vStagei_uid103_zeroCounter_uid37_fpAccTest(MUX,102)@4
    vStagei_uid103_zeroCounter_uid37_fpAccTest_s <= vCount_uid100_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid103_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid103_zeroCounter_uid37_fpAccTest_s, en, redist0_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b_1_q, redist1_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c_1_q)
    BEGIN
        CASE (vStagei_uid103_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid103_zeroCounter_uid37_fpAccTest_q <= redist0_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_b_1_q;
            WHEN "1" => vStagei_uid103_zeroCounter_uid37_fpAccTest_q <= redist1_rVStage_uid99_zeroCounter_uid37_fpAccTest_merged_bit_select_c_1_q;
            WHEN OTHERS => vStagei_uid103_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,233)@4
    rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid103_zeroCounter_uid37_fpAccTest_q(7 downto 4);
    rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid103_zeroCounter_uid37_fpAccTest_q(3 downto 0);

    -- vCount_uid106_zeroCounter_uid37_fpAccTest(LOGICAL,105)@4
    vCount_uid106_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid104_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- vStagei_uid109_zeroCounter_uid37_fpAccTest(MUX,108)@4
    vStagei_uid109_zeroCounter_uid37_fpAccTest_s <= vCount_uid106_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid109_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid109_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid109_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid109_zeroCounter_uid37_fpAccTest_q <= rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid109_zeroCounter_uid37_fpAccTest_q <= rVStage_uid105_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid109_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid111_zeroCounter_uid37_fpAccTest_merged_bit_select(BITSELECT,234)@4
    rVStage_uid111_zeroCounter_uid37_fpAccTest_merged_bit_select_b <= vStagei_uid109_zeroCounter_uid37_fpAccTest_q(3 downto 2);
    rVStage_uid111_zeroCounter_uid37_fpAccTest_merged_bit_select_c <= vStagei_uid109_zeroCounter_uid37_fpAccTest_q(1 downto 0);

    -- vCount_uid112_zeroCounter_uid37_fpAccTest(LOGICAL,111)@4
    vCount_uid112_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid111_zeroCounter_uid37_fpAccTest_merged_bit_select_b = zs_uid110_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- vStagei_uid115_zeroCounter_uid37_fpAccTest(MUX,114)@4
    vStagei_uid115_zeroCounter_uid37_fpAccTest_s <= vCount_uid112_zeroCounter_uid37_fpAccTest_q;
    vStagei_uid115_zeroCounter_uid37_fpAccTest_combproc: PROCESS (vStagei_uid115_zeroCounter_uid37_fpAccTest_s, en, rVStage_uid111_zeroCounter_uid37_fpAccTest_merged_bit_select_b, rVStage_uid111_zeroCounter_uid37_fpAccTest_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid115_zeroCounter_uid37_fpAccTest_s) IS
            WHEN "0" => vStagei_uid115_zeroCounter_uid37_fpAccTest_q <= rVStage_uid111_zeroCounter_uid37_fpAccTest_merged_bit_select_b;
            WHEN "1" => vStagei_uid115_zeroCounter_uid37_fpAccTest_q <= rVStage_uid111_zeroCounter_uid37_fpAccTest_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid115_zeroCounter_uid37_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid117_zeroCounter_uid37_fpAccTest(BITSELECT,116)@4
    rVStage_uid117_zeroCounter_uid37_fpAccTest_b <= vStagei_uid115_zeroCounter_uid37_fpAccTest_q(1 downto 1);

    -- vCount_uid118_zeroCounter_uid37_fpAccTest(LOGICAL,117)@4
    vCount_uid118_zeroCounter_uid37_fpAccTest_q <= "1" WHEN rVStage_uid117_zeroCounter_uid37_fpAccTest_b = GND_q ELSE "0";

    -- r_uid119_zeroCounter_uid37_fpAccTest(BITJOIN,118)@4
    r_uid119_zeroCounter_uid37_fpAccTest_q <= redist6_vCount_uid68_zeroCounter_uid37_fpAccTest_q_2_q & redist5_vCount_uid76_zeroCounter_uid37_fpAccTest_q_1_q & redist4_vCount_uid82_zeroCounter_uid37_fpAccTest_q_1_q & redist3_vCount_uid88_zeroCounter_uid37_fpAccTest_q_1_q & redist2_vCount_uid94_zeroCounter_uid37_fpAccTest_q_1_q & vCount_uid100_zeroCounter_uid37_fpAccTest_q & vCount_uid106_zeroCounter_uid37_fpAccTest_q & vCount_uid112_zeroCounter_uid37_fpAccTest_q & vCount_uid118_zeroCounter_uid37_fpAccTest_q;

    -- resExpSub_uid43_fpAccTest(SUB,42)@4
    resExpSub_uid43_fpAccTest_a <= STD_LOGIC_VECTOR("0" & rShiftConstant_uid15_fpAccTest_q);
    resExpSub_uid43_fpAccTest_b <= STD_LOGIC_VECTOR("0" & r_uid119_zeroCounter_uid37_fpAccTest_q);
    resExpSub_uid43_fpAccTest_o <= STD_LOGIC_VECTOR(UNSIGNED(resExpSub_uid43_fpAccTest_a) - UNSIGNED(resExpSub_uid43_fpAccTest_b));
    resExpSub_uid43_fpAccTest_q <= resExpSub_uid43_fpAccTest_o(9 downto 0);

    -- finalExponent_uid44_fpAccTest(BITSELECT,43)@4
    finalExponent_uid44_fpAccTest_in <= resExpSub_uid43_fpAccTest_q(7 downto 0);
    finalExponent_uid44_fpAccTest_b <= finalExponent_uid44_fpAccTest_in(7 downto 0);

    -- ShiftedOutComparator_uid38_fpAccTest(CONSTANT,37)
    ShiftedOutComparator_uid38_fpAccTest_q <= "101111101";

    -- accResOutOfExpRange_uid39_fpAccTest(LOGICAL,38)@4
    accResOutOfExpRange_uid39_fpAccTest_q <= "1" WHEN ShiftedOutComparator_uid38_fpAccTest_q = r_uid119_zeroCounter_uid37_fpAccTest_q ELSE "0";

    -- finalExpUpdated_uid45_fpAccTest(MUX,44)@4
    finalExpUpdated_uid45_fpAccTest_s <= accResOutOfExpRange_uid39_fpAccTest_q;
    finalExpUpdated_uid45_fpAccTest_combproc: PROCESS (finalExpUpdated_uid45_fpAccTest_s, en, finalExponent_uid44_fpAccTest_b, zeroExponent_uid42_fpAccTest_q)
    BEGIN
        CASE (finalExpUpdated_uid45_fpAccTest_s) IS
            WHEN "0" => finalExpUpdated_uid45_fpAccTest_q <= finalExponent_uid44_fpAccTest_b;
            WHEN "1" => finalExpUpdated_uid45_fpAccTest_q <= zeroExponent_uid42_fpAccTest_q;
            WHEN OTHERS => finalExpUpdated_uid45_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage4Idx1Rng1_uid222_normalizationShifter_uid40_fpAccTest(BITSELECT,221)@4
    leftShiftStage4Idx1Rng1_uid222_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage3_uid220_normalizationShifter_uid40_fpAccTest_q(381 downto 0);
    leftShiftStage4Idx1Rng1_uid222_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage4Idx1Rng1_uid222_normalizationShifter_uid40_fpAccTest_in(381 downto 0);

    -- leftShiftStage4Idx1_uid223_normalizationShifter_uid40_fpAccTest(BITJOIN,222)@4
    leftShiftStage4Idx1_uid223_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage4Idx1Rng1_uid222_normalizationShifter_uid40_fpAccTest_b & GND_q;

    -- leftShiftStage3Idx3Rng6_uid217_normalizationShifter_uid40_fpAccTest(BITSELECT,216)@4
    leftShiftStage3Idx3Rng6_uid217_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage2_uid209_normalizationShifter_uid40_fpAccTest_q(376 downto 0);
    leftShiftStage3Idx3Rng6_uid217_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage3Idx3Rng6_uid217_normalizationShifter_uid40_fpAccTest_in(376 downto 0);

    -- leftShiftStage3Idx3_uid218_normalizationShifter_uid40_fpAccTest(BITJOIN,217)@4
    leftShiftStage3Idx3_uid218_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage3Idx3Rng6_uid217_normalizationShifter_uid40_fpAccTest_b & rightShiftStage3Idx3Pad6_uid165_alignmentShifter_uid17_fpAccTest_q;

    -- leftShiftStage3Idx2Rng4_uid214_normalizationShifter_uid40_fpAccTest(BITSELECT,213)@4
    leftShiftStage3Idx2Rng4_uid214_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage2_uid209_normalizationShifter_uid40_fpAccTest_q(378 downto 0);
    leftShiftStage3Idx2Rng4_uid214_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage3Idx2Rng4_uid214_normalizationShifter_uid40_fpAccTest_in(378 downto 0);

    -- leftShiftStage3Idx2_uid215_normalizationShifter_uid40_fpAccTest(BITJOIN,214)@4
    leftShiftStage3Idx2_uid215_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage3Idx2Rng4_uid214_normalizationShifter_uid40_fpAccTest_b & zs_uid104_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage3Idx1Rng2_uid211_normalizationShifter_uid40_fpAccTest(BITSELECT,210)@4
    leftShiftStage3Idx1Rng2_uid211_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage2_uid209_normalizationShifter_uid40_fpAccTest_q(380 downto 0);
    leftShiftStage3Idx1Rng2_uid211_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage3Idx1Rng2_uid211_normalizationShifter_uid40_fpAccTest_in(380 downto 0);

    -- leftShiftStage3Idx1_uid212_normalizationShifter_uid40_fpAccTest(BITJOIN,211)@4
    leftShiftStage3Idx1_uid212_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage3Idx1Rng2_uid211_normalizationShifter_uid40_fpAccTest_b & zs_uid110_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage2Idx3Rng24_uid206_normalizationShifter_uid40_fpAccTest(BITSELECT,205)@4
    leftShiftStage2Idx3Rng24_uid206_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage1_uid198_normalizationShifter_uid40_fpAccTest_q(358 downto 0);
    leftShiftStage2Idx3Rng24_uid206_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage2Idx3Rng24_uid206_normalizationShifter_uid40_fpAccTest_in(358 downto 0);

    -- leftShiftStage2Idx3_uid207_normalizationShifter_uid40_fpAccTest(BITJOIN,206)@4
    leftShiftStage2Idx3_uid207_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx3Rng24_uid206_normalizationShifter_uid40_fpAccTest_b & rightShiftStage2Idx3Pad24_uid154_alignmentShifter_uid17_fpAccTest_q;

    -- leftShiftStage2Idx2Rng16_uid203_normalizationShifter_uid40_fpAccTest(BITSELECT,202)@4
    leftShiftStage2Idx2Rng16_uid203_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage1_uid198_normalizationShifter_uid40_fpAccTest_q(366 downto 0);
    leftShiftStage2Idx2Rng16_uid203_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage2Idx2Rng16_uid203_normalizationShifter_uid40_fpAccTest_in(366 downto 0);

    -- leftShiftStage2Idx2_uid204_normalizationShifter_uid40_fpAccTest(BITJOIN,203)@4
    leftShiftStage2Idx2_uid204_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx2Rng16_uid203_normalizationShifter_uid40_fpAccTest_b & zs_uid92_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage2Idx1Rng8_uid200_normalizationShifter_uid40_fpAccTest(BITSELECT,199)@4
    leftShiftStage2Idx1Rng8_uid200_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage1_uid198_normalizationShifter_uid40_fpAccTest_q(374 downto 0);
    leftShiftStage2Idx1Rng8_uid200_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage2Idx1Rng8_uid200_normalizationShifter_uid40_fpAccTest_in(374 downto 0);

    -- leftShiftStage2Idx1_uid201_normalizationShifter_uid40_fpAccTest(BITJOIN,200)@4
    leftShiftStage2Idx1_uid201_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx1Rng8_uid200_normalizationShifter_uid40_fpAccTest_b & zeroExponent_uid42_fpAccTest_q;

    -- leftShiftStage1Idx3Rng96_uid195_normalizationShifter_uid40_fpAccTest(BITSELECT,194)@4
    leftShiftStage1Idx3Rng96_uid195_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage0_uid187_normalizationShifter_uid40_fpAccTest_q(286 downto 0);
    leftShiftStage1Idx3Rng96_uid195_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage1Idx3Rng96_uid195_normalizationShifter_uid40_fpAccTest_in(286 downto 0);

    -- leftShiftStage1Idx3_uid196_normalizationShifter_uid40_fpAccTest(BITJOIN,195)@4
    leftShiftStage1Idx3_uid196_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx3Rng96_uid195_normalizationShifter_uid40_fpAccTest_b & rightShiftStage1Idx3Pad96_uid143_alignmentShifter_uid17_fpAccTest_q;

    -- leftShiftStage1Idx2Rng64_uid192_normalizationShifter_uid40_fpAccTest(BITSELECT,191)@4
    leftShiftStage1Idx2Rng64_uid192_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage0_uid187_normalizationShifter_uid40_fpAccTest_q(318 downto 0);
    leftShiftStage1Idx2Rng64_uid192_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage1Idx2Rng64_uid192_normalizationShifter_uid40_fpAccTest_in(318 downto 0);

    -- leftShiftStage1Idx2_uid193_normalizationShifter_uid40_fpAccTest(BITJOIN,192)@4
    leftShiftStage1Idx2_uid193_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx2Rng64_uid192_normalizationShifter_uid40_fpAccTest_b & zs_uid80_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage1Idx1Rng32_uid189_normalizationShifter_uid40_fpAccTest(BITSELECT,188)@4
    leftShiftStage1Idx1Rng32_uid189_normalizationShifter_uid40_fpAccTest_in <= leftShiftStage0_uid187_normalizationShifter_uid40_fpAccTest_q(350 downto 0);
    leftShiftStage1Idx1Rng32_uid189_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage1Idx1Rng32_uid189_normalizationShifter_uid40_fpAccTest_in(350 downto 0);

    -- leftShiftStage1Idx1_uid190_normalizationShifter_uid40_fpAccTest(BITJOIN,189)@4
    leftShiftStage1Idx1_uid190_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx1Rng32_uid189_normalizationShifter_uid40_fpAccTest_b & zs_uid86_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage0Idx3_uid185_normalizationShifter_uid40_fpAccTest(CONSTANT,184)
    leftShiftStage0Idx3_uid185_normalizationShifter_uid40_fpAccTest_q <= "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- leftShiftStage0Idx2Rng256_uid183_normalizationShifter_uid40_fpAccTest(BITSELECT,182)@4
    leftShiftStage0Idx2Rng256_uid183_normalizationShifter_uid40_fpAccTest_in <= redist10_accValuePositive_uid35_fpAccTest_q_2_q(126 downto 0);
    leftShiftStage0Idx2Rng256_uid183_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage0Idx2Rng256_uid183_normalizationShifter_uid40_fpAccTest_in(126 downto 0);

    -- leftShiftStage0Idx2_uid184_normalizationShifter_uid40_fpAccTest(BITJOIN,183)@4
    leftShiftStage0Idx2_uid184_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx2Rng256_uid183_normalizationShifter_uid40_fpAccTest_b & zs_uid66_zeroCounter_uid37_fpAccTest_q;

    -- leftShiftStage0Idx1Rng128_uid180_normalizationShifter_uid40_fpAccTest(BITSELECT,179)@4
    leftShiftStage0Idx1Rng128_uid180_normalizationShifter_uid40_fpAccTest_in <= redist10_accValuePositive_uid35_fpAccTest_q_2_q(254 downto 0);
    leftShiftStage0Idx1Rng128_uid180_normalizationShifter_uid40_fpAccTest_b <= leftShiftStage0Idx1Rng128_uid180_normalizationShifter_uid40_fpAccTest_in(254 downto 0);

    -- leftShiftStage0Idx1_uid181_normalizationShifter_uid40_fpAccTest(BITJOIN,180)@4
    leftShiftStage0Idx1_uid181_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx1Rng128_uid180_normalizationShifter_uid40_fpAccTest_b & zs_uid74_zeroCounter_uid37_fpAccTest_q;

    -- redist10_accValuePositive_uid35_fpAccTest_q_2(DELAY,246)
    redist10_accValuePositive_uid35_fpAccTest_q_2 : dspba_delay
    GENERIC MAP ( width => 383, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => accValuePositive_uid35_fpAccTest_q, xout => redist10_accValuePositive_uid35_fpAccTest_q_2_q, ena => en(0), clk => clk, aclr => areset );

    -- leftShiftStage0_uid187_normalizationShifter_uid40_fpAccTest(MUX,186)@4
    leftShiftStage0_uid187_normalizationShifter_uid40_fpAccTest_s <= leftShiftStageSel8Dto7_uid186_normalizationShifter_uid40_fpAccTest_merged_bit_select_b;
    leftShiftStage0_uid187_normalizationShifter_uid40_fpAccTest_combproc: PROCESS (leftShiftStage0_uid187_normalizationShifter_uid40_fpAccTest_s, en, redist10_accValuePositive_uid35_fpAccTest_q_2_q, leftShiftStage0Idx1_uid181_normalizationShifter_uid40_fpAccTest_q, leftShiftStage0Idx2_uid184_normalizationShifter_uid40_fpAccTest_q, leftShiftStage0Idx3_uid185_normalizationShifter_uid40_fpAccTest_q)
    BEGIN
        CASE (leftShiftStage0_uid187_normalizationShifter_uid40_fpAccTest_s) IS
            WHEN "00" => leftShiftStage0_uid187_normalizationShifter_uid40_fpAccTest_q <= redist10_accValuePositive_uid35_fpAccTest_q_2_q;
            WHEN "01" => leftShiftStage0_uid187_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx1_uid181_normalizationShifter_uid40_fpAccTest_q;
            WHEN "10" => leftShiftStage0_uid187_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx2_uid184_normalizationShifter_uid40_fpAccTest_q;
            WHEN "11" => leftShiftStage0_uid187_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0Idx3_uid185_normalizationShifter_uid40_fpAccTest_q;
            WHEN OTHERS => leftShiftStage0_uid187_normalizationShifter_uid40_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage1_uid198_normalizationShifter_uid40_fpAccTest(MUX,197)@4
    leftShiftStage1_uid198_normalizationShifter_uid40_fpAccTest_s <= leftShiftStageSel8Dto7_uid186_normalizationShifter_uid40_fpAccTest_merged_bit_select_c;
    leftShiftStage1_uid198_normalizationShifter_uid40_fpAccTest_combproc: PROCESS (leftShiftStage1_uid198_normalizationShifter_uid40_fpAccTest_s, en, leftShiftStage0_uid187_normalizationShifter_uid40_fpAccTest_q, leftShiftStage1Idx1_uid190_normalizationShifter_uid40_fpAccTest_q, leftShiftStage1Idx2_uid193_normalizationShifter_uid40_fpAccTest_q, leftShiftStage1Idx3_uid196_normalizationShifter_uid40_fpAccTest_q)
    BEGIN
        CASE (leftShiftStage1_uid198_normalizationShifter_uid40_fpAccTest_s) IS
            WHEN "00" => leftShiftStage1_uid198_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage0_uid187_normalizationShifter_uid40_fpAccTest_q;
            WHEN "01" => leftShiftStage1_uid198_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx1_uid190_normalizationShifter_uid40_fpAccTest_q;
            WHEN "10" => leftShiftStage1_uid198_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx2_uid193_normalizationShifter_uid40_fpAccTest_q;
            WHEN "11" => leftShiftStage1_uid198_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1Idx3_uid196_normalizationShifter_uid40_fpAccTest_q;
            WHEN OTHERS => leftShiftStage1_uid198_normalizationShifter_uid40_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage2_uid209_normalizationShifter_uid40_fpAccTest(MUX,208)@4
    leftShiftStage2_uid209_normalizationShifter_uid40_fpAccTest_s <= leftShiftStageSel8Dto7_uid186_normalizationShifter_uid40_fpAccTest_merged_bit_select_d;
    leftShiftStage2_uid209_normalizationShifter_uid40_fpAccTest_combproc: PROCESS (leftShiftStage2_uid209_normalizationShifter_uid40_fpAccTest_s, en, leftShiftStage1_uid198_normalizationShifter_uid40_fpAccTest_q, leftShiftStage2Idx1_uid201_normalizationShifter_uid40_fpAccTest_q, leftShiftStage2Idx2_uid204_normalizationShifter_uid40_fpAccTest_q, leftShiftStage2Idx3_uid207_normalizationShifter_uid40_fpAccTest_q)
    BEGIN
        CASE (leftShiftStage2_uid209_normalizationShifter_uid40_fpAccTest_s) IS
            WHEN "00" => leftShiftStage2_uid209_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage1_uid198_normalizationShifter_uid40_fpAccTest_q;
            WHEN "01" => leftShiftStage2_uid209_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx1_uid201_normalizationShifter_uid40_fpAccTest_q;
            WHEN "10" => leftShiftStage2_uid209_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx2_uid204_normalizationShifter_uid40_fpAccTest_q;
            WHEN "11" => leftShiftStage2_uid209_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2Idx3_uid207_normalizationShifter_uid40_fpAccTest_q;
            WHEN OTHERS => leftShiftStage2_uid209_normalizationShifter_uid40_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStage3_uid220_normalizationShifter_uid40_fpAccTest(MUX,219)@4
    leftShiftStage3_uid220_normalizationShifter_uid40_fpAccTest_s <= leftShiftStageSel8Dto7_uid186_normalizationShifter_uid40_fpAccTest_merged_bit_select_e;
    leftShiftStage3_uid220_normalizationShifter_uid40_fpAccTest_combproc: PROCESS (leftShiftStage3_uid220_normalizationShifter_uid40_fpAccTest_s, en, leftShiftStage2_uid209_normalizationShifter_uid40_fpAccTest_q, leftShiftStage3Idx1_uid212_normalizationShifter_uid40_fpAccTest_q, leftShiftStage3Idx2_uid215_normalizationShifter_uid40_fpAccTest_q, leftShiftStage3Idx3_uid218_normalizationShifter_uid40_fpAccTest_q)
    BEGIN
        CASE (leftShiftStage3_uid220_normalizationShifter_uid40_fpAccTest_s) IS
            WHEN "00" => leftShiftStage3_uid220_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage2_uid209_normalizationShifter_uid40_fpAccTest_q;
            WHEN "01" => leftShiftStage3_uid220_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage3Idx1_uid212_normalizationShifter_uid40_fpAccTest_q;
            WHEN "10" => leftShiftStage3_uid220_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage3Idx2_uid215_normalizationShifter_uid40_fpAccTest_q;
            WHEN "11" => leftShiftStage3_uid220_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage3Idx3_uid218_normalizationShifter_uid40_fpAccTest_q;
            WHEN OTHERS => leftShiftStage3_uid220_normalizationShifter_uid40_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStageSel8Dto7_uid186_normalizationShifter_uid40_fpAccTest_merged_bit_select(BITSELECT,235)@4
    leftShiftStageSel8Dto7_uid186_normalizationShifter_uid40_fpAccTest_merged_bit_select_b <= r_uid119_zeroCounter_uid37_fpAccTest_q(8 downto 7);
    leftShiftStageSel8Dto7_uid186_normalizationShifter_uid40_fpAccTest_merged_bit_select_c <= r_uid119_zeroCounter_uid37_fpAccTest_q(6 downto 5);
    leftShiftStageSel8Dto7_uid186_normalizationShifter_uid40_fpAccTest_merged_bit_select_d <= r_uid119_zeroCounter_uid37_fpAccTest_q(4 downto 3);
    leftShiftStageSel8Dto7_uid186_normalizationShifter_uid40_fpAccTest_merged_bit_select_e <= r_uid119_zeroCounter_uid37_fpAccTest_q(2 downto 1);
    leftShiftStageSel8Dto7_uid186_normalizationShifter_uid40_fpAccTest_merged_bit_select_f <= r_uid119_zeroCounter_uid37_fpAccTest_q(0 downto 0);

    -- leftShiftStage4_uid225_normalizationShifter_uid40_fpAccTest(MUX,224)@4
    leftShiftStage4_uid225_normalizationShifter_uid40_fpAccTest_s <= leftShiftStageSel8Dto7_uid186_normalizationShifter_uid40_fpAccTest_merged_bit_select_f;
    leftShiftStage4_uid225_normalizationShifter_uid40_fpAccTest_combproc: PROCESS (leftShiftStage4_uid225_normalizationShifter_uid40_fpAccTest_s, en, leftShiftStage3_uid220_normalizationShifter_uid40_fpAccTest_q, leftShiftStage4Idx1_uid223_normalizationShifter_uid40_fpAccTest_q)
    BEGIN
        CASE (leftShiftStage4_uid225_normalizationShifter_uid40_fpAccTest_s) IS
            WHEN "0" => leftShiftStage4_uid225_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage3_uid220_normalizationShifter_uid40_fpAccTest_q;
            WHEN "1" => leftShiftStage4_uid225_normalizationShifter_uid40_fpAccTest_q <= leftShiftStage4Idx1_uid223_normalizationShifter_uid40_fpAccTest_q;
            WHEN OTHERS => leftShiftStage4_uid225_normalizationShifter_uid40_fpAccTest_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fracR_uid46_fpAccTest(BITSELECT,45)@4
    fracR_uid46_fpAccTest_in <= leftShiftStage4_uid225_normalizationShifter_uid40_fpAccTest_q(379 downto 0);
    fracR_uid46_fpAccTest_b <= fracR_uid46_fpAccTest_in(379 downto 357);

    -- R_uid47_fpAccTest(BITJOIN,46)@4
    R_uid47_fpAccTest_q <= redist11_accumulatorSign_uid29_fpAccTest_b_2_q & finalExpUpdated_uid45_fpAccTest_q & fracR_uid46_fpAccTest_b;

    -- xOut(GPOUT,4)@4
    r <= R_uid47_fpAccTest_q;
    xo <= delayedXOverflowFeedbackSignal_uid50_fpAccTest_q;
    xu <= redist8_oRXUnderflowFlagFeedback_uid58_fpAccTest_q_4_q;
    ao <= delayedAccOverflowFeedbackSignal_uid60_fpAccTest_q;

END normal;
