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
  	logic reset_n;

  	initial
  	begin
// Asserting the active_low reset
  	reset_n = 0;
// De-asserting the active_low reset
    	#10 reset_n = ~reset_n;
  	end
// Instantiation of UART interface
  	uart_if intf(.reset(reset_n));

// TODO: Need to have the loopback mode
// assign intf.rx = intf.tx;
  
  	initial
  	begin
// TODO: Need to suppor for multiple interfaces
// Temporarily having vif_0
        uvm_config_db #(virtual uart_if)::set(null,"*","vif_0",intf);
     
//running the basic test case
    	run_test("base_test");
//  $display("running base_test in top");
 	 end  
endmodule


  
   
  
