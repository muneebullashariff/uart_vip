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
//`ifndef _env_config_INCLUDED_
//`define _env_config_INCLUDED_

//------------------------------------------------------------------------------------------------//
//  Class: env_config
//  A env_config is written by extending the uvm_object. 
//------------------------------------------------------------------------------------------------//
class env_config extends uvm_object;

 
//--------------------------------------------------------------------------------------------------
//  Factory registration is done by passing class name as argument.
//  Factory Method in UVM enables us to register a class, object and variables inside the factory 
//  so that we can override their type (if needed) from the test bench without needing to make any
//  significant change in component structure.
//--------------------------------------------------------------------------------------------------
	`uvm_object_utils(env_config)
  
 	master_agent_config w_cfg[];
	slave_agent_config r_cfg[];


	bit has_functional_coverage = 0;
	bit has_wagent_functional_coverage = 0;
	bit has_scoreboard = 1;
	bit has_wagent = 1;
	bit has_ragent = 1;
	bit has_wtop = 1;
	bit has_rtop = 1;
  bit has_buard_rate= 1;

	bit has_virtual_sequencer = 1;
	int no_of_wagent;
	int no_of_ragent;
	int no_of_wtop;
  int no_of_rtop;
	int no_of_sb=1;
  int buard_rate=9600;
  	
  
//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
	extern function new(string name = "env_config");

endclass: env_config


//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the config_template class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------
function env_config::new(string name = "env_config");
  super.new(name);
endfunction:new


