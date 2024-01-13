module aligner (
  input [7:0] e_1, 
  input [7:0] e_2, 
  input op,
  input sign_1, sign_2,
  input [22:0] m_1, m_2,
  output [7:0] e,
  output [7:0] diff,
  output sign,
  output new_sign_2,
  output [26:0] aligned_guarded_m_1,
  output [26:0] aligned_guarded_m_2
);

  wire [23:0] normalized_m_1, normalized_m_2; 
  wire adjusted_sign_2 = op ^ sign_2;   
  wire [7:0] e1_e2 = e_1 - e_2;
  wire [7:0] e2_e1 = e_2 - e_1;
  wire sel = e1_e2[7];

  // * Check that we are not dealing with subn numbers
  wire [276:0] aligned_m2 = {sel ? normalized_m_1 : normalized_m_2, 253'b0} >> diff;
  wire [31:0] test = aligned_m2[276-:32];
  
  // * these are assuming normal range, do not include subnormal range
  assign normalized_m_1 = {1'b1, m_1};
  assign normalized_m_2 = {1'b1, m_2};
  assign diff = sel ? e2_e1 : e1_e2;  
  assign e = sel ? e_2 : e_1;
  assign sign = sel ? adjusted_sign_2 : sign_1; 
  assign new_sign_2 = sel ? sign_1 : adjusted_sign_2;
  assign aligned_guarded_m_1 = {sel ? normalized_m_2 : normalized_m_1, 3'b0};
  assign aligned_guarded_m_2 = {aligned_m2[276-:26], |aligned_m2[250:0]};


endmodule


