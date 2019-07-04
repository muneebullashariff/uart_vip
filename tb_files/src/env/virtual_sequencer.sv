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
//`ifndef _virtual_seqs_INCLUDED_
//`define _virtual_seqs_INCLUDED_


//------------------------------------------------------------------------------------------------//
//  Class: virtual_sequencer
//  A virtual sequence is a container to start multiple sequences on different sequencers in
//  the environment. 
//------------------------------------------------------------------------------------------------//
class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);

	`uvm_component_utils(virtual_sequencer)
	
	master_sequencer master_seqrh[];
	slave_sequencer slave_seqrh[];

	env_config e_cfg;


	extern function new(string name = "virtual_sequencer", uvm_component parent);
	extern function void build_phase(uvm_phase phase);
endclass

//new
	function virtual_sequencer::new(string name= "virtual_sequencer", uvm_component parent);
		super.new(name, parent);
	endfunction

//build
	function void virtual_sequencer::build_phase(uvm_phase phase);
			super.build_phase(phase);
	
		if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
			`uvm_fatal("CONFIG","Cannot get() e_cfg from uvm_congig_db. Have you set it?")
			master_seqrh=new[e_cfg.no_of_wagent];
			slave_seqrh=new[e_cfg.no_of_ragent];
	endfunction
