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
//  2) Use of Include Guards
//`ifndef _master_agent_INCLUDED_
//`define _master_agent_INCLUDED_

//------------------------------------------------------------------------------------------------//
//  Class: master_agent
//  master_agent is extended from uvm_agent, uvm_agent is inherited by uvm_component.
//  An agent typically contains: a driver,sequencer, and monitor. Agents can be configured either
//  active or passive.
//------------------------------------------------------------------------------------------------//
class master_agent extends uvm_agent;


//------------------------------------------------------------------------------------------------//
//  Factory registration is done by passing class name as argument.
//  Factory Method in UVM enables us to register a class, object and variables inside the factory 
//  so that we can override their type (if needed) from the test bench without needing to make any
//  significant change in component structure.
//------------------------------------------------------------------------------------------------//
 `uvm_component_utils(master_agent)
	

//------------------------------------------------------------------------------------------------//
//  w_cfg is the handle of master_agent_config which is extended from the configuration class.
//  Handles for the driver, monitor, sequencer is also defined here.
//------------------------------------------------------------------------------------------------//
	master_agent_config w_cfg;
	master_driver drvh;
	master_monitor monh;
	master_sequencer m_sequencer;
 

//------------------------------------------------------------------------------------------------//
//  The extern qualifier indicates that the body of the method (its implementation) is to be found 
//  outside the declaration.
//------------------------------------------------------------------------------------------------//
  extern function new(string name="master_agent", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase (uvm_phase phase);
endclass


//----------------------------------------New_Constructor-----------------------------------------//
//  The new function is called as class constructor. On calling the new method it allocates the 
//  memory and returns the address to the class handle.
//------------------------------------------------------------------------------------------------//
	function master_agent::new(string name="master_agent", uvm_component parent);
		super.new(name, parent);
	endfunction:new


//----------------------------------------Build_Phase---------------------------------------------//
//  The build phases are executed at the start of the UVM Testbench simulation and their overall 
//  purpose is to construct, configure and connect the Testbench component hierarchy.
//  All the build phase methods are functions and therefore execute in zero simulation time.
//------------------------------------------------------------------------------------------------//
	function void master_agent::build_phase(uvm_phase phase);
		super.build_phase(phase);
  

//------------------------------------------------------------------------------------------------//
//  The configuration database provides access to a centralized database, where type specific 
//  information can be stored and received. config_db can contain class handles, virtual 
//  interfaces and etc.
//------------------------------------------------------------------------------------------------//
		if(!uvm_config_db #(master_agent_config)::get(this,"","master_agent_config",w_cfg))
			`uvm_fatal("CONFIG", "cannot get() w_cfg from uvm_config_db. Have you set it?")


//------------------------------------------------------------------------------------------------//
//  For Active UVM Agent monitor class is created along with the Sequencer and Driver but for the
//  Passive UVM Agent only Monitor is created
//------------------------------------------------------------------------------------------------//
				monh=master_monitor::type_id::create("monh", this);
				if(w_cfg.is_active==UVM_ACTIVE);
					begin
						drvh=master_driver::type_id::create("drvh", this);
						m_sequencer=master_sequencer::type_id::create("m_sequencer", this);
					end
		endfunction:build_phase


//----------------------------------------Connect_Phase-------------------------------------------//
//  The connect phase is used to make TLM connections between components or to assign handles to 
//  testbench resources. It has to occur after the build method so that Testbench component 
//  hierarchy could be in place and it works from the bottom-up of the hierarchy upwards.
//------------------------------------------------------------------------------------------------//
function void master_agent::connect_phase(uvm_phase phase);
		if(w_cfg.is_active==UVM_ACTIVE)
			drvh.seq_item_port.connect(m_sequencer.seq_item_export);
	endfunction:connect_phase
