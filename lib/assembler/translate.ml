open Simulator

let translate code =
  let _mem = Memory.make () in
  prog 0 (Lexing.from_string code)
