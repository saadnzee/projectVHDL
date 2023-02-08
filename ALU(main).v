module ALU(Rs,Rt_cnst,opcode,shamt,Rd);
input [15:0] Rs,Rt_cnst;
output reg [16:0] Rd;
input [3:0] opcode;
input [2:0] shamt;
wire [7:0] Hi,Lo;
reg [15:0] SR;

always @(*)
begin
if (opcode == 0)
 Rd = Rs + Rt_cnst;
else if (opcode == 1)
 Rd = Rs << shamt;
else if (opcode == 2)
 Rd = Rs >> shamt;
else if (opcode == 3)
 Rd = Rs | Rt_cnst;
else if (opcode == 4)
 Rd = Rs & Rt_cnst;
else if (opcode == 10)
 Rd = Rs * Rt_cnst;  
else if (opcode == 11)
 Rd = Lo;
else if (opcode == 12)
 Rd = Hi;
else if (opcode == 5)
 Rd = Rs + Rt_cnst;
else if (opcode == 6)
 Rd = Rt_cnst;
else if (opcode == 7)
 Rd = Rs + Rt_cnst;
else if (opcode == 8)
 Rd = Rs + Rt_cnst;

//else if (opcode == 9)            // this is carried out in the top module for ease of implementation
 //PC = PC + address;

else if (opcode == 13)             // checking for flags
begin
 	if ( SR[3] == 1 )
	begin
	Rd = Rs + Rt_cnst;
	end
        else if ( SR[2] == 1 )
        begin 
        Rd = Rs + Rt_cnst;
        end
end

end

// opcode = 10 case
assign Hi = Rd[15:8];              
assign Lo = Rd[7:0];

endmodule
