`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 02/04/2022 07:45:13 PM
// Design Name:
// Module Name: test_flop_r
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module p_test;
   

       reg [7:0] din;
    reg clk;
    reg rst;
    reg ce;
    wire  [7:0] dout;
    
    p_mod #(8,6) inst0 (.*);

      always #10 clk = ~clk;
   
  initial begin
//    inp1 <= 0; //dont care
//    inp2 <= 0;
clk = 0;     
rst = 0;
din<=0;
ce<=1;
#20;
rst = 1;
#60;
rst = 0;
#40;
//#5;
din <= 1;



        #1000;

        $finish;


     end // initial begin





   

 /*    initial
    begin
       $set_gate_level_monitoring("rtl_on");
       $set_toggle_region(inst);
       @(posedge clk);
//       @(negedge rst);
//      @(posedge trigger_saif);
       
       $toggle_start();
    end // initial begin
  
   final
     begin
        $toggle_stop();
        $toggle_report("run.saif", 1.0e-12, inst);
     end
*/
   endmodule
