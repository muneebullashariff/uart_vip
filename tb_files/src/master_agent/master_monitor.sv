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
//`ifndef _master_monitor_INCLUDED_
//`define _master_monitor_INCLUDED_


//------------------------------------------------------------------------------------------------//
//  Class: master_monitor
//  The user-defined monitor is extended from uvm_monitor, uvm_monitor is inherited by uvm_component.
//  A monitor is a passive entity that samples the DUT signals through the virtual interface and 
//  converts the signal level activity to the transaction level. Monitor samples DUT signals but 
//  does not drive them.
//------------------------------------------------------------------------------------------------//
class master_monitor extends uvm_monitor;


//------------------------------------------------------------------------------------------------//
//  Macro:`uvm_component_utils()
//  Factory registration is done by passing class name as argument.
//  Factory Method in UVM enables us to register a class, object and variables inside the factory 
//  so that we can override their type (if needed) from the test bench without needing to make any
//  significant change in component structure.
//------------------------------------------------------------------------------------------------//
  `uvm_component_utils(master_monitor)
  

//------------------------------------------------------------------------------------------------//
//  Virtual interface holds the pointer to the Interface.  
	virtual uart_if vif;


//------------------------------------------------------------------------------------------------//
//  w_cfg is the handle of master_agent_config which is extended from the configuration class    
//------------------------------------------------------------------------------------------------//
	master_agent_config w_cfg;
  master_driver m_drv;
  

//------------------------------------------------------------------------------------------------//
//  TLM Port:uvm_analysis port
//  The uvm_analysis_port is a specialized TLM based class whose interface consists of a single 
//  function write ().
//------------------------------------------------------------------------------------------------//
	uvm_analysis_port #(master_xtn) monitor_port;


//------------------------------------------------------------------------------------------------//
//  The extern qualifier indicates that the body of the method (its implementation) is to be found 
//  outside the declaration.
//------------------------------------------------------------------------------------------------//
	extern function new(string name = "master_monitor", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase (uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task collect_data();

endclass

//----------------------------------------New_Constructor-----------------------------------------//
//  The new function is called as class constructor. On calling the new method it allocates the 
//  memory and returns the address to the class handle. For the component class two arguments to be 
//  passed. 
//------------------------------------------------------------------------------------------------//
	function master_monitor :: new(string name ="master_monitor",uvm_component parent);
		super.new(name, parent);
		monitor_port = new("monitor_port", this);
	endfunction:new


//----------------------------------------Build_Phase---------------------------------------------//
//  The build phases are executed at the start of the UVM Testbench simulation and their overall 
//  purpose is to construct, configure and connect the Testbench component hierarchy.
//  All the build phase methods are functions and therefore execute in zero simulation time.	
//------------------------------------------------------------------------------------------------//
  function void master_monitor::build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(master_agent_config)::get(this,"","master_agent_config",w_cfg))
		`uvm_fatal("CONFIG","Cannot get() w_cfg from uvm_config_db. Have you set() it?")
	endfunction:build_phase


//----------------------------------------Connect_Phase-------------------------------------------//
//  The connect phase is used to make TLM connections between components or to assign handles to 
//  testbench resources. It has to occur after the build method so that Testbench component 
//  hierarchy could be in place and it works from the bottom-up of the hierarchy upwards.
//------------------------------------------------------------------------------------------------//
	function void master_monitor::connect_phase(uvm_phase phase);
		 vif = w_cfg.vif;
	endfunction:connect_phase


//----------------------------------------Run_Phase-----------------------------------------------//
//  The run phase is used for the stimulus generation and checking activities of the Testbench. 
//  The run phase is implemented as a task, and all uvm_component run tasks are executed in parallel.
//------------------------------------------------------------------------------------------------//
	task master_monitor::run_phase(uvm_phase phase);
    forever
			begin
				collect_data();
			end 
	endtask:run_phase

  
//------------------------------------------------------------------------------------------------//
//  Task: collect_data
//  Collect_data will collect the data from the interface and converts it to class master_txn type
//  which will be used by the scoreboard and coverage
//------------------------------------------------------------------------------------------------//
	task master_monitor::collect_data();
		master_xtn data_sent;
    forever
      begin
		  data_sent=master_xtn::type_id::create("data_sent");
      data_sent.tx=vif.masterdrv_cb.tx;
      #(m_drv.bit_time)
      for(int i=0;i<8;i++)
      begin
        data_sent.da[i]=vif.masterdrv_cb.da[i];
        #(m_drv.bit_time);
      end
      @(vif.mastermon_cb);
      monitor_port.write(data_sent);
      end
	endtask:collect_data


