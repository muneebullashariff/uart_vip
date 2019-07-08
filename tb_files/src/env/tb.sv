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
//`ifndef _tb_INCLUDED_
//`define _tb_INCLUDED_


//------------------------------------------------------------------------------------------------//
//  Class: tb
//  Class tb is derived from uvm_env, contains all the components such as agent, scoreboard, 
//  coverage, virtual sequencer.
//------------------------------------------------------------------------------------------------//
class tb extends uvm_env;
	`uvm_component_utils(tb)

//Declaring  handles different components
	env_config e_cfg;
	master_agent_top wtop;
	slave_agent_top rtop;
	scoreboard sb;
	virtual_sequencer v_seqrh;
	

//---------------------------------------------
// Externally defined tasks and functions
//---------------------------------------------
	extern function new ( string name="tb", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
endclass


//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the config_template class object
//
// Parameters:
//  name - instance name of the config_template
//  parent - parent under which this component is created
//-----------------------------------------------------------------------------
function tb::new(string name = "tb", uvm_component parent);
		super.new(name, parent);
endfunction:new


//-----------------------------------------------------------------------------
// Function: build_phase
// Creates the required ports
//
// Parameters:
//  phase - stores the current phase 
//----------------------------------------------------------------------------- 
function void tb::build_phase(uvm_phase phase);
	if(!uvm_config_db #(env_config)::get(this, "","env_config",e_cfg))
			`uvm_fatal("CONFIG", "Cannot get() e_cfg  from uvm_config")
					
	 super.build_phase(phase);

	if(e_cfg.has_wtop==1) 
	 wtop=master_agent_top::type_id::create("wtop",this);

	if(e_cfg.has_rtop==1) 
   rtop=slave_agent_top::type_id::create("rtop",this);
							
	if(e_cfg.has_virtual_sequencer)
	 v_seqrh=virtual_sequencer::type_id::create("v_seqrh",this);

  if(e_cfg.has_scoreboard) 
	 begin
	 sb=scoreboard::type_id::create("sb",this);
   end
          
endfunction:build_phase

 
//------------------------------------------------------------------------------------------------
//phase:connect
//here the connection is done between virtual sequences in test and environment and
//connection between monitor to scoreboard
//------------------------------------------------------------------------------------------------
function void tb::connect_phase (uvm_phase phase);
	if(e_cfg.has_wtop==1) 
  begin
	for(int i=0; i<e_cfg.no_of_wagent; i++)
	 begin
	 v_seqrh.master_seqrh[i] = wtop.wagent[i].m_sequencer;
	 wtop.wagent[i].monh.monitor_port.connect(sb.wfifo[i].analysis_export);
   end
	end
			
	if(e_cfg.has_rtop==1) 
  begin
	for(int i=0; i<e_cfg.no_of_ragent; i++)
	 begin
   rtop.ragent[i].monh.monitor_port.connect(sb.rfifo[i].analysis_export);
	 v_seqrh.slave_seqrh[i] = rtop.ragent[i].m_sequencer;
	 end
	end
endfunction:connect_phase


