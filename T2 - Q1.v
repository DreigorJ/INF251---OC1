//Trabalho Prático 2 - OCI - INF 251 - 2018/2
//Aluno/Matrícula: Jean Martins Vieira de Goes - es85259
//
//
// Conversão dos estados
//      Decimal: 85259
//          |
//          v
//      Binary: 10100110100001011
//
//			
//
//
//		Máquina de estados em anexo
//
//
//
//
// Memória e/ou karnaugh
//
//Linha	A1	A0	e2	e1	e0		p2	p1	p0		s2	s1	s0
// 0	0	0	0	0	0		0	0	1		0	0	0
// 1	0	0	0	0	1		0	1	0		0	0	1
// 2	0	0	0	1	0		0	0	0		0	1	0
// 3	0	0	0	1	1		0	0	0		0	1	1
// 4	0	0	1	0	0		0	0	0		1	0	0
// 5	0	0	1	0	1		0	0	0		1	0	1
// 6	0	0	1	1	0		0	0	0		1	1	0
// 7	0	0	1	1	1		0	0	0		0	1	1
// 8	0	1	0	0	0		0	1	1		0	0	0
// 9	0	1	0	0	1		0	1	1		0	0	1
//10	0	1	0	1	0		1	0	0		0	1	0
//11	0	1	0	1	1		0	1	0		0	1	1
//12	0	1	1	0	0		0	1	1		1	0	0
//13	0	1	1	0	1		0	1	1		1	0	1
//14	0	1	1	1	0		0	1	1		1	1	0
//15	0	1	1	1	1		0	1	1		0	1	1
//16	1	0	0	0	0		0	0	1		0	0	0
//17	1	0	0	0	1		0	1	1		0	0	1
//18	1	0	0	1	0		1	1	1		0	1	0
//19	1	0	0	1	1		0	1	0		0	1	1
//20	1	0	1	0	0		0	0	1		1	0	0
//21	1	0	1	0	1		0	0	1		1	0	1
//22	1	0	1	1	0		0	0	1		1	1	0
//23	1	0	1	1	1		0	0	1		0	1	1
//24	1	1	0	0	0		1	0	1		0	0	0
//25	1	1	0	0	1		1	0	1		0	0	1
//26	1	1	0	1	0		1	0	1		0	1	0
//27	1	1	0	1	1		1	0	1		0	1	1
//28	1	1	1	0	0		1	0	1		1	0	0
//29	1	1	1	0	1		1	1	0		1	0	1
//30	1	1	1	1	0		0	1	1		1	1	0
//31	1	1	1	1	1		1	0	1		0	1	1
//
//
//



module ff ( input data, input c, input r, output q);
reg q;
always @(posedge c or negedge r) 
begin
 if(r==1'b0)
  q <= 1'b0; 
 else 
  q <= data; 
end 
endmodule 


//FNM com Memória


module stateMem (input clk, input res,input [1:0]a, output [2:0]s);
reg [5:0] StateMachine [0:31];    //Memória de 16 linhas com 6 bits de dados

initial
begin

	StateMachine[0] = 6'b001000;	
	StateMachine[1] = 6'b010001;
	StateMachine[2] = 6'b000010;	
	StateMachine[3] = 6'b000011;
	StateMachine[4] = 6'b000100;	
	StateMachine[5] = 6'b000101;
	StateMachine[6] = 6'b000110;	
	StateMachine[7] = 6'b000011;
	
	
	StateMachine[8] = 6'b011000;	
	StateMachine[9] = 6'b011001;
	StateMachine[10] = 6'b100010;
	StateMachine[11] = 6'b010011;
	StateMachine[12] = 6'b011100;
	StateMachine[13] = 6'b011101;
	StateMachine[14] = 6'b011110;	
	StateMachine[15] = 6'b011011;
	
	
	StateMachine[16] = 6'b001000;	
	StateMachine[17] = 6'b011001;
	StateMachine[18] = 6'b111010;
	StateMachine[19] = 6'b010011;
	StateMachine[20] = 6'b001100;	
	StateMachine[21] = 6'b001101;
	StateMachine[22] = 6'b001110;
	StateMachine[23] = 6'b001011;
	
	
	StateMachine[24] = 6'b101000;	
	StateMachine[25] = 6'b101001;
	StateMachine[26] = 6'b101010;
	StateMachine[27] = 6'b101011;
	StateMachine[28] = 6'b101100;	
	StateMachine[29] = 6'b110101;
	StateMachine[30] = 6'b011110;	
	StateMachine[31] = 6'b101011;
	
end

wire [4:0] address;
wire [5:0] dout;

assign address[4] = a[1];
assign address[3] = a[0];
assign dout = StateMachine[address];
assign s = dout[2:0];

ff st0(dout[3],clk,res,address[0]);
ff st1(dout[4],clk,res,address[1]);
ff st2(dout[5],clk,res,address[2]);

endmodule

//FNM com Maquina de estados (Alto nível com Case)


module stateM (clk, rst, a, s);
input clk, rst;
input [1:0]a;
reg [2:0]state;
output [2:0]s;

parameter zero=3'd0, um=3'd1, dois=3'd2, tres=3'd3, quatro=3'd4, cinco=3'd5, seis=3'd6, sete=3'd7;

assign s = (state == zero)? 3'd0:
		   (state == um)? 3'd1:
           (state == dois)? 3'd2:
           (state == tres)? 3'd3:
		   (state == quatro)? 3'd4:
		   (state == cinco)? 3'd5:
           (state == seis)? 3'd6: 3'd3;   

  
always @(posedge clk or negedge rst)
     begin
          if (rst==0)
          begin
               if(a == 2'd0) state = zero;
			   else if(a == 2'd1) state = tres;
			   else if(a == 2'd2) state = um;
			   else state = cinco;
		  end
          else
               case (state)
                    zero:	
                            if(a == 2'd1) state = tres;
							else if(a == 2'd3) state = cinco;
							else state = um;
							
					um:		if(a == 2'd0) state = dois;
							else if(a == 2'd3) state = cinco;
							else state = tres;
						
					dois:	if(a == 2'd0) state = zero;
							else if(a == 2'd1) state = quatro;
							else if(a == 2'd2) state = sete;
							else state = cinco;
							
					tres:	if(a == 2'd0) state = zero;
							else if(a == 2'd3) state = cinco;
							else state = dois;
			   
					quatro:	if(a == 2'd0) state = zero;
							else if(a == 2'd1) state = tres;
							else if(a == 2'd2) state = um;
							else state = cinco;
							
					cinco:	if(a == 2'd0) state = zero;
							else if(a == 2'd1) state = tres;
							else if(a == 2'd2) state = um;
							else state = seis;
							
					seis: 	if(a == 2'd0) state = zero;
							else if(a == 2'd1) state = tres;
							else if(a == 2'd2) state = um;
							else state = tres;
					
					sete:	if(a == 2'd0) state = zero;
							else if(a == 2'd1) state = tres;
							else if(a == 2'd2) state = um;
							else state = cinco;
				endcase
     end
  
endmodule
 
 
//FNM com Porta Lógica
 
//	p[2] <= ABD' + ABE + BC'DE' + AC'DE'
//	p[1] <= A'BD' + A'BE + B'C'D'E + BCD'E + BCDE' + AB'C'D
//	p[0] <= AE' + C'D'E' + A'BD' + BCD + AB'D' + AB'C + ABC'
//	said[2] <= CD' + CE'
//	said[1] <= D
//	said[0] <= E
 
 
module statePorta (input clk, input res,input [1:0]a, output [2:0]s);

wire [2:0] e;
wire [2:0] p;

assign p[2] = ((a[1]&a[0])&~e[1]) | ((a[1]&a[0])&e[0]) | ((a[0]&~e[2])&(e[1]&~e[0])) | ((a[1]&~e[2])&(e[1]&~e[0]));
assign p[1] = ((~a[1]&a[0])&~e[1]) | ((~a[1]&a[0])&e[0]) | ((~a[0]&~e[2])&(~e[1]&e[0])) | ((a[0]&e[2])&(~e[1]&e[0])) | ((a[0]&e[2])&(e[1]&~e[0])) | ((a[1]&~a[0])&(~e[2]&e[1]));
assign p[0] = (a[1]&~e[0]) | ((~e[2]&~e[1])&~e[0]) | ((~a[1]&a[0])&~e[1]) | ((a[0]&e[2])&e[1]) | ((a[1]&~a[0])&~e[1]) | ((a[1]&~a[0])&e[2]) | ((a[1]&a[0])&~e[2]);
assign s[2] = (e[2]&~e[1]) | (e[2]&~e[0]);
assign s[1] = e[1];
assign s[0] = e[0];

ff  e0(p[0],clk,res,e[0]);
ff  e1(p[1],clk,res,e[1]);
ff  e2(p[2],clk,res,e[2]);

endmodule 


//Main (Coloquei os 3 para rodar junto para ter uma verificação facilitada)

	
module main;
reg c,res;
reg [1:0]a;
wire [2:0]estM;
wire [2:0]estP;
wire [2:0]estMem;


stateMem FSM1(c,res,a,estMem);
stateM FSM2(c,res,a,estM);
statePorta FSM3(c,res,a,estP);


initial
    c = 1'b0;
  always
    c= #(1) ~c;
	
initial  begin
     $dumpfile ("out.vcd"); 
     $dumpvars; 
   end 

  initial 
    begin
     $monitor($time," Cloclk %b Reset %b a %d EstadoMem %d EstadoM %d EstadoP %d",c,res,a,estMem, estM, estP);
      #1 a=0; res=0; 
      #1 res=1;
	  #6 a=1;
      #6 a=2;
      #8 a=3;
      #6
      $finish ;
    end
endmodule