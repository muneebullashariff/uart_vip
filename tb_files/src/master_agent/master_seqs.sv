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
//  Use of Include Guards
//  `ifndef _master_seqs_INCLUDED_
//  `define _master_seqs_INCLUDED_

//------------------------------------------------------------------------------------------------//
//  Class: master_seqs
//  master_seqs is extended from uvm_sequence. The uvm_sequence class provides the interfaces
//  necessary in order to create streams of sequence items and/or other sequences.
//------------------------------------------------------------------------------------------------//
class master_seqs extends uvm_sequence #(master_xtn);

//  Factory Method in UVM enables us to register a class, object and variables inside the factory 
	`uvm_object_utils(master_seqs)

//creating handle for master transaction
  	master_xtn req;
  
//  The extern qualifier indicates that its implementation is to be found outside the declaration.
extern function new(string name="master_seqs");
  	extern task body();
endclass:master_seqs 


//-----------------------------------------------------------------------------------------------//
//  constructor:new
//  The new function is called as class constructor. On calling the new method it allocates the 
//  memory and returns the address to the class handle.
//------------------------------------------------------------------------------------------------//
function master_seqs::new(string name="master_seqs");
	super.new(name);
endfunction:new


//-----------------------------------------------------------------------------------------------
//task:body
//This gives the information about the starting of driver sequencer handshake mechanism
//-----------------------------------------------------------------------------------------------
task master_seqs::body();
  	req=master_xtn::type_id::create("req");
 	repeat(1)
  	begin
  	start_item(req);
  	if(! (req.randomize()) 
   	begin
  	`uvm_error(get_type_name(), "Not able to randomize req\n")
   	end
  	finish_item(req);
  	end
endtask


