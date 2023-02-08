module decode(clk,rst,gvn_instr,rs,rd,rt,shamt,opcode,w_en,rt_sel,const,w_en2,Rd_sel,Pc_sel,unused,adr);
input [15:0] gvn_instr;
input clk,rst;
output [2:0] rs,rd,rt,shamt;
output [3:0] opcode;
output reg [7:0] adr;
output reg [3:0] unused; 
output reg w_en,rt_sel,w_en2,Rd_sel,Pc_sel;
output reg [5:0] const;
reg [15:0] SR;

// R-TYPE

assign opcode = gvn_instr[3:0]; 
assign rd = gvn_instr[6:4];
assign rs = gvn_instr[9:7];
assign rt = gvn_instr[12:10];
assign shamt = gvn_instr[15:13];

always @(posedge clk,posedge rst)
begin
 if (opcode != 7)                   
  w_en <= 1;
end

// I-Type

always @(*)              // whenever rt_sel = 1 , I-type instructions will execute
begin
 if (opcode == 5)
  rt_sel <= 1;
 else if (opcode == 6)
  rt_sel <= 1;
 else if (opcode == 7)
  rt_sel <= 1;
 else if (opcode == 8)
  rt_sel <= 1;
 else 
  rt_sel <= 0;
end
always @(*)
begin
 if (rt_sel == 1)
  const <= gvn_instr[15:10];
end
always @(*)
begin 
 if (opcode == 8)         // when w_en2 = 1 then store word case
  begin
   w_en2 <= 1;
  end
 else                     // else otherwise (load word)
  begin
   w_en2 <= 0;
  end
end
always @(*)               
begin 
 if (opcode == 7)         // when Rd_sel = 1 then load word
  begin
   Rd_sel <= 1;
  end
 else
  begin
   Rd_sel <= 0;
  end
end

always @(*)            // opcode 9 = jump instructions
begin
 if (opcode == 9)
  begin 
   Pc_sel = 1;
   adr = gvn_instr[11:4];
   unused = gvn_instr[15:12]; 
  end

else if (opcode == 14)  // (14==conditional jump)
begin                                                                         //checking if any flag is raised
 	if ( SR[0] == 1 || SR[1] == 1 || SR[2] == 1 || SR[3] == 1)
	begin
	 Pc_sel = 1;
  	 adr = gvn_instr[11:4];
  	 unused = gvn_instr[15:12];
	end
end
 else
  begin
   Pc_sel <= 0; 
  end
end
endmodule
