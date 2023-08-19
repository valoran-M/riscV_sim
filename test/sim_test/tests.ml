open Alcotest

let tests : unit Alcotest.test list =
  [ "Simulator", [
      test_case "R_instruction" `Quick R_instruction.test;
      test_case "I_instruction_arith" `Quick I_instruction.test_arith;
      test_case "I_instruction_load"  `Quick I_instruction.test_load;
  ] ]
