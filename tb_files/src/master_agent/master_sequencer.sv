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
//`ifndef _master_sequencer.sv_INCLUDED_
//`define _master_sequencer.sv_INCLUDED_

//------------------------------------------------------------------------------------------------//
//  Class: master_sequencer
//  master_sequencer is extended from uvm_sequencer. The sequencer controls the flow of request and
//  response sequence items between sequences and the driver. Sequencer and driver uses TLM 
//  Interface to communicate transactions. uvm_sequencer and uvm_driver base classes have 
//  seq_item_export and seq_item_port defined respectively. User needs to connect them using TLM 
//  connect method.
//------------------------------------------------------------------------------------------------//
class master_sequencer extends uvm_sequencer #(master_xtn);

//  Factory Method in UVM enables us to register a class, object and variables inside the factory 
  	`uvm_component_utils(master_sequencer)

	 extern function new(string name="master_sequencer", uvm_component parent);
endclass:master_sequencer


//-----------------------------------------------------------------------------------------------//
//  constructor:new
//  The new function is called as class constructor. On calling the new method it allocates the 
//  memory and returns the address to the class handle.
//------------------------------------------------------------------------------------------------//
function master_sequencer::new(string name = "master_sequencer", uvm_component parent);
	super.new(name, parent);
endfunction:new

