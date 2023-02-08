module ROM(clk,rst,PCout,PC_out,gvn_instr, opcode);
reg [15:0] ROM [0:255];
input [7:0] PCout, PC_out;      // PCout = normal instructions, PC_out = jump instruction (PC+address) 
input clk,rst;
input [3:0] opcode;          
output reg [15:0] gvn_instr;
integer c;

// FOR TESTING I INTIALIZED SOME VALUES IN ROM

initial 
 begin 
  ROM[0] = 16'b0110100010110000;                         // setting values in ROM
  ROM[1] = 16'b0110100010000001;
  ROM[2] = 16'b0110000010000010;
  ROM[3] = 16'b0000100010000011;
  ROM[4] = 16'b0000100010000100;
  ROM[5] = 16'b0000100010000101;
  ROM[6] = 16'b0000100010000110;
  ROM[7] = 16'b0000100010000111;
  ROM[8] = 16'b0010010010001000;
  ROM[13] = 16'b0010010000001001;
  ROM[10] = 16'b0010010010001010; 
  ROM[11] = 16'b0010010010001011; 
  ROM[12] = 16'b0110010010111101;
  ROM[9] = 16'b0110010010101110;
  ROM[14] = 16'b0010010010001100;
 end

initial    // filling up the rest of the 255 locations using for loop
 begin 
  for (c = 15; c < 255; c = c + 1)
   ROM[c] <= c;
 end

always @(posedge clk, posedge rst)
begin 
 if (rst == 1)
begin	
  gvn_instr <= 0;
end	

 else if (opcode != 9 )      // except opcode 9 we have normal PC=PC+1
begin
  gvn_instr <= ROM[PCout];
end
else                         // for opcode 9 i.e jump instruction we have PC = PC + adr
begin 
  gvn_instr <= ROM[PC_out];
end
end

endmodule
