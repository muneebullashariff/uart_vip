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
//
//   Use of Include Guards
//`ifndef _slave_seqs.sv_INCLUDED_
//`define _slave_seqs.sv_INCLUDED_

//------------------------------------------------------------------------------------------------//
//  Class: slave_seqs
//  slave_seqs is extended from uvm_sequence. The uvm_sequence class provides the interfaces
//  necessary in order to create streams of sequence items and/or other sequences.
//------------------------------------------------------------------------------------------------//
class slave_seqs extends uvm_sequence #(slave_xtn);

//------------------------------------------------------------------------------------------------//
//  Factory registration is done by passing class name as argument.
//  Factory Method in UVM enables us to register a class, object and variables inside the factory 
//  so that we can override their type (if needed) from the test bench without needing to make any
//  significant change in component structure.
//------------------------------------------------------------------------------------------------//
	`uvm_object_utils(slave_seqs)

//------------------------------------------------------------------------------------------------//
//  The extern qualifier indicates that the body of the method (its implementation) is to be found 
//  outside the declaration.
//------------------------------------------------------------------------------------------------//
	extern function new(string name="slave_seqs");
endclass:slave_seqs 

//----------------------------------------New_Constructor-----------------------------------------//
//  The new function is called as class constructor. On calling the new method it allocates the 
//  memory and returns the address to the class handle.
//------------------------------------------------------------------------------------------------//
	function slave_seqs::new(string name="slave_seqs");
		super.new(name);
	endfunction:new
