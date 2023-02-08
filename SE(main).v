module se(clk,rst,const,cnst_out);
input clk,rst;
input [5:0] const;           // 6 bit constant from decode unit
output reg [15:0] cnst_out;  
wire x = const[5];           // checking msb
always @(*)
begin
 if (x == 0)
  cnst_out <= const;           // if msb 0 = extends 0 to the left
 else 
  cnst_out <= const | 65472;   // if msb 1 = extend 1 to the left by or operation
end
endmodule

