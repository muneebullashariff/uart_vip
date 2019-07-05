
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
//`ifndef _uart_if_INCLUDED_
//`define _uart_if_INCLUDED_

interface uart_if(input reset);

  logic tx;
  logic rx;

  // TODO: The below signals should be in driver
  //logic da[8];
  //real bit_time;
   
  initial
  begin
   //  bit_time = (1/(env_cfg.buard_rate));
  end

    //clocking block for master driver
    clocking masterdrv_cb@(negedge tx);
      //default input #1 output #1;
      output tx;
      output rx;
      output da;
    endclocking

    //clocking block for master monitor
    clocking mastermon_cb@(negedge tx);
      //default input #1 output #0;
      input tx;
      input rx;
      input da;
    endclocking

    //clocking block for slave driver
    clocking slavedrv_cb@(negedge rx);
      //default input #1 output #0;
    output da;
    output rx;
    endclocking

    //clocking block for slave monitor
    clocking slavemon_cb@(negedge rx);
      //default input #1 output #0;
      input tx;
      input da;
      input rx;
    endclocking

    modport MDRIV_MP(clocking masterdrv_cb, input reset);
    modport MMON_MP(clocking mastermon_cb, input reset);
    modport SDRV_MP(clocking slavedrv_cb, input reset);
    modport SMON_MP(clocking slavemon_cb, input reset);
    
  endinterface









