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

// Use of Include Guards
`ifndef _slave_agent_top.sv_INCLUDED_
`define _slave_agent_top.sv_INCLUDED_

//-------------------------------------------------------------------------------------------------
//class:slave_agent_top
//slave_agent_top is extended from uvm_env. It contains the agent. Configuration of 
//agent_congif_db is done in agent_top.
//-------------------------------------------------------------------------------------------------
class slave_agent_top extends uvm_env;
  

  //-----------------------------------------------------------------------------------------------
  //Factory registration is done by passing class name as argument.
  //Factory Method in UVM enables us to register a class, object and variables inside the factory 
  //so that we can override their type (if needed) from the test bench without needing to make any
  //significant change in component structure.
  //-----------------------------------------------------------------------------------------------
	`uvm_component_utils(slave_agent_top)
	

  //slave_agent class is defined as dynamic so multiple agents can be instantiated. But in UART 
  //only one slave is enough since it is one to one transmission. Hence Master_agent should always 
  //set to be one.
	slave_agent ragent[];
	env_config e_cfg;

	extern function new(string name= "slave_agent_top", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
endclass:slave_agent_top


//-------------------------------------------------------------------------------------------------
//constructor:new
  //The new function is called as class constructor. On calling the new method it allocates the 
  //memory and returns the address to the class handle. For the component class two arguments to be 
  //passed. 
  //-----------------------------------------------------------------------------------------------
	function slave_agent_top::new(string name= "slave_agent_top", uvm_component parent);
		super.new(name, parent);
	endfunction:new


//-------------------------------------------------------------------------------------------------
//phase:build
  //The build phases are executed at the start of the UVM Testbench simulation and their overall 
  //purpose is to construct, configure and connect the Testbench component hierarchy.
  //All the build phase methods are functions and therefore execute in zero simulation time.
  //-----------------------------------------------------------------------------------------------
	function void slave_agent_top::build_phase(uvm_phase phase);
	if(!uvm_config_db #(env_config)::get(this,"","env_config", e_cfg))
		`uvm_fatal("CONFIG_ENV","cannot get() env_config from uvm_config_db. Have you set() it?")
			ragent=new[e_cfg.no_of_ragent];
			foreach(ragent[i])
				begin
					uvm_config_db #(slave_agent_config)::set(this,$sformatf("ragent[%0d]*",i),
          "slave_agent_config",e_cfg.r_cfg[i]);
					ragent[i]=slave_agent::type_id::create($sformatf("ragent[%0d]",i), this);

				end
		super.build_phase(phase);
				
	endfunction:build_phase


//-------------------------------------------------------------------------------------------------
//phase:run
//The run phase is used for the stimulus generation and checking activities of the Testbench. 
//The run phase is implemented as a task, and all uvm_component run tasks are executed in parallel.
//-------------------------------------------------------------------------------------------------
	task slave_agent_top::run_phase(uvm_phase phase);
		uvm_top.print_topology;
	endtask :run_phase 


	
	
		
