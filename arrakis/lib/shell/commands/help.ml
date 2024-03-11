(******************************************************************************)
(* Copyright 2023-2024 - Arrakis contributors                                 *)
(*                                                                            *)
(* This file is part of Arrakis, a RISC-V simulator.                          *)
(* It is distributed under the CeCILL 2.1 LICENSE <http://www.cecill.info>    *)
(******************************************************************************)

open Format

let print (name : string) (desc : string) (sub : Types.cmd list) (state : Types.state) =
  fprintf state.out_channel "%2s@{<fg_green>%s@}\n" "" name;
  (if desc != "" then fprintf state.out_channel "%2s%s\n" "" desc);
  List.iter (fun (cmd : Types.cmd) ->
    fprintf state.out_channel "%2s@{<fg_green>*@} %-15s%2s%s\n"
    "" cmd.name "" cmd.short_desc)
  sub;
  state

let general (state : Types.state) =
  print "General" "" state.cmds state

let command (cmd : Types.cmd) (state : Types.state) =
  print (String.capitalize_ascii cmd.long_form) cmd.long_desc cmd.sub state

let breakpoint channel =
  Format.fprintf channel
{|  @{<fg_green> Breakpoint help:@}

  @{<fg_green>*@} (b)reakpoint (l)ine <l_1> ... <l_n>

    Set breakpoints on specified lines.

  @{<fg_green>*@} (b)reakpoint (a)ddr <b_1> ... <b_n>

    Set breakpoints on specified addresses.

  @{<fg_green>*@} (b)reakpoint (r)emove <b_1> ... <b_n>

    Remove specified breakpoints.

  @{<fg_green>*@} (b)reakpoint (p)rint

    Print all breakpoints.@.|}

let print channel =
  Format.fprintf channel
{|  @{<fg_green>Print help:@}

  @{<fg_green>*@} (p)rint (m)emory <start> <nb>

      Print memory segment.
      Starts at address <start> and displays <nb> 32 bits.

      <start> can either be an adress or a register.

      @{<fg_yellow>default args:@}
        <start> Starting data segement
        <nb>    0x10

  @{<fg_green>*@} (p)rint (r)egs <r_1> ... <r_n>

      Display value in specified registers.
      If no register are specified, display all of them.

  @{<fg_green>*@} (p)rint (c)ode <offset> <noffset>

      If no offset is specified, print code from start to finish.
      If offset is specified, print code from pc to pc+offset.
      If noffset is also specified, print code from pc-noffset to pc+offset.@.|}

let execute args (state : Types.state) =
  match args with
  | []       -> general state
  | hd :: _  ->
    try               command (List.find (Utils.cmd_eq hd) state.cmds) state
    with Not_found -> general state

let help : Types.cmd = {
  long_form   = "help";
  short_form  = "h";
  name        = "(h)elp";
  short_desc  = "Show this help";
  long_desc   = "";
  execute     = execute;
  sub         = [];
}

