//  ################################################################################################
//
//  Licensed to the Apache Software Foundation (ASF) under one or more contributor license 
//  agreements. See the NOTICE file distributed with this work for additional information
//  regarding copyright ownership. The ASF licenses this file to you under the Apache License,
//  Version 2.0 (the"License"); you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software distributed under the 
//  License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
//  either express or implied. See the License for the specific language governing permissions and 
//  limitations under the License.
//
//  ################################################################################################

// Use of Include Guards
//`ifndef _top_INCLUDED_
//`define _top_INCLUDED_

//-------------------------------------------------------------------------------------------------
//module:top
//This provide the information about instantiating test_pkg,interface,and running the base test
//-------------------------------------------------------------------------------------------------
module top;
	
    import test_pkg::*;
		import uvm_pkg::*;
		

    bit reset;
   initial
  begin 
  #10;
  reset = ~reset;
  end
		uart_if in();

 	initial
    begin
		uvm_config_db #(virtual uart_if)::set(null,"*","vif_0",in);
     
//running the basic test case
	run_test("base_test");
//  $display("running base_test in top");
   end
 

   
endmodule


  
   
  
