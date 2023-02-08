module PC(clk,rst,PCout);
input clk,rst;
output reg [7:0] PCout;             // PCout is Program counter for normal instructions
always @(posedge clk, posedge rst)
begin 
 if (rst == 1)                      // if rst = 1 then PCout = 0
  PCout <= 0;
 else
  PCout <= PCout+1;                 // else PCout gets incremented
end
endmodule
