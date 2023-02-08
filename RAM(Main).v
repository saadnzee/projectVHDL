module ram_1(Rd,Rd_data,w_en2,Rd_out);
input [16:0] Rd,Rd_data;
input w_en2;
output reg [16:0] Rd_out;
reg [15:0] RAM [0:255];
integer d;

initial
 begin 
  RAM[0] = 16'b0000000000000001;
  RAM[1] = 16'b0000000000000010;
  RAM[2] = 16'b0000000000000011;
  RAM[3] = 16'b0000000000000100;
  RAM[4] = 16'b0000000000000101;
  RAM[5] = 16'b0000000000000111;
  RAM[6] = 16'b0000000000001000;
  RAM[7] = 16'b0000000000001001;
 end

initial        // filling up 255 locations of data memory
 begin
 for (d = 8; d < 255; d = d + 1)
   RAM[d] <= d;
 end

always @(*)            
begin 
 if (w_en2 == 0)
  begin
   Rd_out <= RAM[Rd];         // Loads word from memory (RAM) to be saved in regfile 
  end
 else
  begin
   RAM[Rd] <= Rd_data;        // Store word, Rd_data is coming from regfile and is placed at Rd'th location of RAM 
  end
end
endmodule
