open Alcotest

let tests : unit Alcotest.test =
   "Simulator", [
      test_case "R_instruction" `Quick R_instruction.test;
      test_case "R_instruction_mul" `Quick R_instruction.test_mul;
      test_case "I_instruction_arith" `Quick I_instruction.test_arith;
      test_case "I_instruction_load"  `Quick I_instruction.test_load;
      test_case "I_instruction_jalr"  `Quick I_instruction.test_jalr;
      test_case "S_instruction"  `Quick S_instruction.test;
      test_case "B_instruction"  `Quick B_instruction.test;
      test_case "U_instruction"  `Quick U_instruction.test;
      test_case "J_instruction"  `Quick J_instruction.test;
  ]
