// License copy
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
//`ifndef _scoreboard_INCLUDED_
//`define _scoreboard_INCLUDED_

//-------------------------------------------------------------------------------------------------
//class:scoreboard
//This provide thhe information about comparision of data from monitors of master and slave
//-------------------------------------------------------------------------------------------------
class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)

env_config ecfg;

//Tlm analysis FIFO's connecting from both the monitors to scoreboard
uvm_tlm_analysis_fifo #(master_xtn) wrh[];
uvm_tlm_analysis_fifo #(slave_xtn) rdh[];


master_xtn wxtn;
slave_xtn rxtn;

//handles to store the modifications
master_xtn loc_wxtn;
slave_xtn loc_rxtn;

//creating a queue to perform FIFO operation
master_xtn w_que[$];
slave_xtn r_que[$];


//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the config_template class object
//
// Parameters:
//  name - instance name of the config_template
//  parent - parent under which this component is created
//-----------------------------------------------------------------------------
function new(string name="scoreboard",uvm_component parent);
super.new(name,parent);
mem_coverage=new;
endfunction 


//-----------------------------------------------------------------------------
//phase:build
//This will execute all its methods in zero simulation time
//-----------------------------------------------------------------------------
function void build_phase(uvm_phase phase);
if(!uvm_config_db#(env_config)::get(this,"","ENV_CONFIG",ecfg))
  `uvm_error("SB","COULDNT GET")

wrh=new[ecfg.no_of_wagt];
rdh=new[ecfg.no_of_ragt];

foreach(wrh[i])
wrh[i]=new($sformatf("wrh[%0d]",i),this);

foreach(rdh[i])
rdh[i]=new($sformatf("rdh[%0d]",i),this);
endfunction


//------------------------------------------------------------------------------
//phase:run
//In this task we are trying to get transactions and pushing them into the queue
//-------------------------------------------------------------------------------
task run_phase(uvm_phase phase);
forever
  begin

    fork
	        begin
          wrh[0].get(wxtn);
	 	       w_que.push_front(wxtn);
        	end
  
        	begin
	        rdh[0].get(rxtn);
	        r_que.push_front(rxtn);
	       	end
   join


  end
endtask


//--------------------------------------------------------------------------------------
//phase:check-phase
//this phase provide the information about the data match whether it is successful 
//or un succesful
//----------------------------------------------------------------------------------------
function void check_phase(uvm_phase phase);
  foreach(w_que[i])
    begin
    loc_wxtn=w_que.pop_back;
    loc_rxtn=r_que.pop_back;

           for(int i=0;i<8;i++)
           begin
             if(loc_wxtn.da[i]==loc_rxtn.da[i])
             $display("SUCCESFUL COMPARISION");
             else
	          $display("DATA_MISMATCH");
            end
            else
            $display("READING FROM UN-WRITTEN LOCATION");
    end
 
endfunction


endclass
