`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 02/04/2022 07:43:34 PM
// Design Name:
// Module Name: flop_r
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

module p_mod#(parameter width = 8, parameter numPipeStage = 3) 
       (
input logic clk,                                  //clock
input logic ce,                                   //clock enable                        
input logic rst,                                  //reset
input logic [width-1:0] din,                  //data in
output logic [width-1:0] dout                 //data out
);


logic [width-1:0] sr [numPipeStage-1:0];  

          
logic [width-1:0] temp;
always@(posedge clk or posedge rst)
    temp <=  din;


generate
genvar i;
for(i = 0;i < numPipeStage;i = i + 1)
begin
    always@(posedge clk or posedge rst)
    begin
        if(rst)                          
        begin
            sr[i] <= 'd0;
        end
        else
        begin
            if(ce)                            //the shift register operates only when the clock-enable is active
            begin
                if(i == 'd0)
                begin
                    sr[i] <= din;
                end
                else
                begin
                    sr[i] <= sr[i-1];
                end
            end
        end
    end
end
endgenerate
assign dout = sr[numPipeStage-1];

endmodule 
