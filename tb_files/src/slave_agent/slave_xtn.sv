//  ###########################################################################
//
//  Licensed to the Apache Software Foundation (ASF) under one
//  or more contributor license agreements.  See the NOTICE file
//  distributed with this work for additional information
//  regarding copyright ownership.  The ASF licenses this file
//  to you under the Apache License, Version 2.0 (the
//  "License"); you may not use this file except in compliance
//  with the License.  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.
//
//  ###########################################################################
//   Use of Include Guards
//`ifndef _slave_xtn_INCLUDED_
//`define _slave_xtn_INCLUDED_

//-------------------------------------------------------------------------------------------------
//class:slave_xtn
//This class provide information about the sequences that are present
//-------------------------------------------------------------------------------------------------
class slave_xtn extends uvm_sequence_item;


//------------------------------------------------------------------------------------------------
//Factory registration is done by passing class name as argument.
//Factory Method in UVM enables us to register a class, object and variables inside the factory 
//so that we can override their type (if needed) from the test bench without needing to make any
//significant change in component structure.
//-------------------------------------------------------------------------------------------------
  `uvm_object_utils(slave_xtn)

  //bit tx;
  //bit rx;
  bit [7:0] rx_data;
	
		extern function new(string name = "slave_xtn");
		extern function void do_print(uvm_printer printer);
	endclass:slave_xtn

  
//-------------------------------------------------------------------------------------------------
//constructor:new
  //The new function is called as class constructor. On calling the new method it allocates the 
  //memory and returns the address to the class handle. For the component class two arguments to be 
  //passed. 
  //-----------------------------------------------------------------------------------------------
	function slave_xtn::new(string name="slave_xtn");
		super.new(name);
	endfunction:new


//------------------------------------------------------------------------------------------------
// do_print method
// srting name bitstream value size radix for printing 
// ------------------------------------------------------------------------------------------------

	function void  slave_xtn::do_print (uvm_printer printer);
    super.do_print(printer);
     endfunction:do_print
    

  

