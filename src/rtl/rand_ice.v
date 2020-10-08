//======================================================================
//
// rand_ice.v
// ----------
// Top level module for the Random number generator in iCEstick.
//
//
// Author: Joachim Strombergson
// Copyright (c) 2019, Assured AB
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
// - Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
//
// - Redistributions in binary form must reproduce the above copyright
//   notice, this list of conditions and the following disclaimer in the
//   documentation and/or other materials provided with the distribution.
//
// - Neither the name of the NORDUnet nor the names of its contributors may
//   be used to endorse or promote products derived from this software
//   without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
// IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
// PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
// TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
// PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
// LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//======================================================================

module rand_ice(
                input wire clk,

                output wire rled1,
                output wire rled2,
                output wire rled3,
                output wire rled4,
                output wire gled5
               );

  //----------------------------------------------------------------
  // Internal constant and parameter definitions.
  //----------------------------------------------------------------


  //----------------------------------------------------------------
  // Registers including update variables and write enable.
  //----------------------------------------------------------------
  reg [21 : 0] alarm_counter_reg = 22'h0;


  //----------------------------------------------------------------
  // Concurrent connectivity for ports etc.
  //----------------------------------------------------------------
  assign rled1 = alarm_counter_reg[19];
  assign rled2 = alarm_counter_reg[19];
  assign rled3 = alarm_counter_reg[19];
  assign rled4 = alarm_counter_reg[19];
  assign gled5 = key_loaded_reg;


  //----------------------------------------------------------------
  // Module instantiations.
  //----------------------------------------------------------------
  rosc_entropy_core core(
                         input wire           clk,
                         input wire           enable,
                         input wire [31 : 0]  opa,
                         input wire [31 : 0]  opb,
                         output wire [31 : 0] raw_entropy,
                         output wire [31 : 0] rosc_outputs,
                         output wire [31 : 0] entropy_data,
                         output wire          entropy_valid,
                         input wire           entropy_ack
                        );


  //----------------------------------------------------------------
  // reg_update
  //----------------------------------------------------------------
  always @ (posedge clk)
    begin : reg_update

      alarm_counter_reg <= alarm_counter_reg + 1;

    end

endmodule // rand_ice

//======================================================================
// EOF rand_ice.v
//======================================================================
