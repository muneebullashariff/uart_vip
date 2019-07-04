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
//`ifndef _test_pkg_INCLUDED_
//`define _test_pkg_INCLUDED_

//------------------------------------------------------------------------------------------------
//package:test_pkg
//including allthe package files,,macrocs,master_files,slave_files,env,test,scoreboard
//------------------------------------------------------------------------------------------------
package test_pkg;


  import uvm_pkg::*;
  `include "uvm_macros.svh"


  `include "../src/master_agent/master_xtn.sv"
  `include "../src/master_agent/master_agent_config.sv"
  `include "../src/slave_agent/slave_agent_config.sv"
  `include "../src/env/env_config.sv"
  `include "../src/master_agent/master_driver.sv"
  `include "../src/master_agent/master_monitor.sv"
  `include "../src/master_agent/master_sequencer.sv"
  
  `include "../src/master_agent/master_agent.sv"
  `include "../src/master_agent/master_agent_top.sv"
  `include "../src/master_agent/master_seqs.sv"

  `include "../src/slave_agent/slave_xtn.sv"
  `include "../src/slave_agent/slave_monitor.sv"
  `include "../src/slave_agent/slave_sequencer.sv"
  `include "../src/slave_agent/slave_seqs.sv"
  `include "../src/slave_agent/slave_driver.sv"
  `include "../src/slave_agent/slave_agent.sv"
  `include "../src/slave_agent/slave_agent_top.sv"

  `include "../src/env/virtual_sequencer.sv"
  `include "../src/env/virtual_seqs.sv"

  `include "../src/env/tb.sv"
 // `include "scoreboard.sv"


`include "../src/test/base_test.sv"

endpackage
