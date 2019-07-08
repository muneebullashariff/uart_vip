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
//`ifndef _master_xtn_INCLUDED_
//`define _master_xtn_INCLUDED_

class master_xtn extends uvm_sequence_item;

//Factory Method in UVM enables us to register a class, object and variables inside the factory.
  `uvm_object_utils(master_xtn

  rand bit [7:0] tx_data;

//---------------------------------------------------------------------------------------------
//Defining external tasks and functions
//---------------------------------------------------------------------------------------------
	extern function new(string name = "master_xtn");
	extern function void do_print(uvm_printer printer);
endclass:master_xtn


//------------------------------------------------------------------------------------------------
//new:constructor
//The new function is called as class constructor. On calling the new method it allocates the 
//memory and returns the address to the class handle. For the component class two arguments to be 
//passed.
//-----------------------------------------------------------------------------------------------
function master_xtn::new(string name="master_xtn");
	super.new(name);
endfunction:new


//Do_Print method
function void  master_xtn::do_print (uvm_printer printer);
  super.do_print(printer);
// string name bitstream value size radix for printing 
endfunction:do_print



    

  

