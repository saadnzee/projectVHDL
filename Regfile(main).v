module regfile(rs,rd,rt,Rd_saved,Rd_data,Rs,Rt,clk,rst,w_en,w_en2,opcode, SR);

input [2:0] rs,rd,rt;
input [3:0] opcode;
input clk,rst,w_en,w_en2;
input [16:0] Rd_saved;            // Rd_saved = either contains Rd_ or Rd_out(data to be saved in regfile)
output reg [16:0] Rd_data;        // Rd_data = always output of regfile
output reg [15:0] Rs,Rt;
output reg [15:0] SR ;
reg [15:0] regfile [0:11];
integer i;                            

always@(*)
begin
 Rs = regfile[rs];
 Rt = regfile[rt];
end

initial  
begin
  regfile[0] = 16'b0000000000000000;
  regfile[1] = 16'b0000000000000001;
  regfile[2] = 16'b0000000000000010;
  regfile[3] = 16'b0000000000000011;
  regfile[4] = 16'b0000000000000101;
  regfile[5] = 16'b0000000000000111;
  regfile[6] = 16'b0000000000001000;
  regfile[7] = 16'b0000000000001001;
  regfile[8] = 16'b0000000000000000;  // Hi register
  regfile[9] = 16'b0000000000000000;  // Lo register
  regfile[10] = 16'b0000000000001010;  
  regfile[11] = 16'b0000000000001011;  
  SR = 16'b0000000000000000;  // Status register (SR)
end

always @(posedge clk,posedge rst)
begin

if (rst == 1)
begin
   for (i = 0; i < 8; i = i +1)
    regfile[i] =  i;
    
  end
 else
  begin
   if (w_en == 1)                // w_en = 1, regfile writes ( final answer ) 
    begin
    regfile[rd] = Rd_saved;
    end
  end
end

always @(*)
begin
 if (w_en2==1)                   // picks value from regfile to be saved in RAM  
  Rd_data = regfile[rd];
end

always @(*)
begin
 if (opcode==10)                 // this saved the the higher bits of register into HI reg and lower bits into LO reg
  begin
   regfile[8] <= Rd_saved[15:8];
   regfile[9] <= Rd_saved[7:0];
  end
 else if (opcode==11) // only saves the lower bits
  begin
   regfile[9] <= Rd_saved[7:0];
  end
 else if (opcode==12) // only saves the higher bits
  begin
   regfile[8] <= Rd_saved[15:8];
  end

end

always@(*)
begin
if ( Rs == Rt )       // if the operands are equivalent zero flag is raised
	begin
	SR = 16'b0000000000001000;
	end
else                  // else wont raise flag
	begin
	SR = 16'b0000000000000000;  // SR
	end
end

always@(*)
begin 
SR[1] = Rd_saved[16];     // carry flag

SR[0] = Rd_saved[16];     // overflow flag on the 17th bit
end

always@(*)
begin
 if (Rt > Rs)
  begin
   SR[2] = 1;  // negative flag
  end
end

endmodule
