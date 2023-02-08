module calling_modules(clk,rst);    // declared inputs as either wire or reg while output is always wire
input clk,rst;
wire [15:0] Rs,Rt, SR;
wire [16:0] Rd,Rd_saved,Rd_data,Rd_out;
reg [16:0] Rd_;
reg [15:0] Rt_cnst;
wire [7:0] PCout,adr;
reg [7:0] PC_out;
wire [2:0] rs,rd,rt,shamt;
wire [3:0] opcode,unused;
wire [15:0] cnst_out;
wire w_en,rt_sel,Rd_sel,w_en2,Pc_sel;
wire [5:0] const;
wire [15:0] gvn_instr;

always @(*)    // opcode 9 case (jump instruction)
begin
 if (Pc_sel==1)
  begin
   PC_out <= PCout+adr;
  end
 else
  begin
   PC_out <= PCout;
  end 
end
PC ab (clk,rst,PCout);
ROM db (clk,rst,PCout,PC_out,gvn_instr, opcode);
decode cb (clk,rst,gvn_instr,rs,rd,rt,shamt,opcode,w_en,rt_sel,const,w_en2,Rd_sel,Pc_sel,unused,adr);
ram_1 eb (Rd,Rd_data,w_en2,Rd_out);

always @(*)               
begin 
 if (Rd_sel == 1)        // Rd_sel = 1, Load word case
  begin
   Rd_ <= Rd_out;        // Rd_out = from memory (RAM)
  end
 else
  begin  
   Rd_ <= Rd;            // else Rd = ALU computed data 
  end
end
assign Rd_saved = Rd_;
regfile gb (rs,rd,rt,Rd_saved,Rd_data,Rs,Rt,clk,rst,w_en,w_en2,opcode, SR);
se hb (clk,rst,const,cnst_out);
always @(*)                            // Rt can either be a 16 bit constant or 16 bit data from reg file (R and I type)
begin
 if (rt_sel == 1)
  Rt_cnst <= cnst_out;
 else
  Rt_cnst <= Rt;
end
ALU pb (Rs,Rt_cnst,opcode,shamt,Rd);

endmodule

