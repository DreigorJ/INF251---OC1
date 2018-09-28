//Trabalho Prático 2 - OCI - INF 251 - 2018/2
//Aluno/Matrícula: Jean Martins Vieira de Goes - es85259
//
//
// Conversão dos estados
//      Decimal: 85259
//          |
//          v
//      Binary: 10100110100001011
//          |
//          v
//      Octal: 246413
//
//
// Máquina de estados (com estados originais):
//
//                     +----------------------------------------+
//                     |                                        |
//                     | +-----------------------------------+  |
//                     | |                                   |  |
//                    0| |1        0+----------------------+ |  |
//                     | |          |                      | |  |
//                    ++-v+   1   +-v-+   1   +---+  1/0  ++-++ |
//		              | 0 +-------> 3 +-------> 2 +-------> 4 <-+
//                    |   |       |   |       |   |       |   |
//                    +-^-+       +-+-+       +-^-+       +---+
//                      |           |           |
//                      |           |           |
//                      |          0|           |0
//                      |           |           |
//                      |           |    +---+  |
//                      |           +----> 5 +--+
//                      +----------------+   |
//                             1         +---+
//
//
// Conversão dos estados:       (Utilizei de um segundo ff para consertar o caso do estado 000)
//
//      0 --> 010 (2)
//
//      2 --> 100 (4)
//
//      3 --> 110 (6)
//
//      4 --> 101 (5)
//
//      5 --> 001 (1)
//
//
//
// Memória e/ou karnaugh
//
//Linha	A	e2	e1	e0		p2	p1	p0		s2	s1	s0
//0 	0	0	0	0		x	x	x		x	x	x
//1 	0	0	0	1		1	0	0		1	0	1
//2 	0	0	1	0		1	0	1		0	0	0
//3 	0	0	1	1		x	x	x		x	x	x
//4 	0	1	0	0		1	0	1		0	1	0
//5 	0	1	0	1		1	1	0		1	0	0
//6 	0	1	1	0		0	0	1		0	1	1
//7 	0	1	1	1		x	x	x		x	x	x
//8 	1	0	0	0		x	x	x		x	x	x
//9 	1	0	0	1		0	1	0		1	0	1
//10	1	0	1	0		1	1	0		0	0	0
//11	1	0	1	1		x	x	x		x	x	x
//12	1	1	0	0		1	0	1		0	1	0
//13	1	1	0	1		0	1	0		1	0	0
//14	1	1	1	0		1	0	0		0	1	1
//15	1	1	1	1		x	x	x		x	x	x
//
//
//
//
// Representação com Memória
//
//
//                    +------------------------+
//  +--+              |                        |
//A |  +-----------+  |                        |
//  +--+           |  |                        |
//                 +--+                        |
//                    |         Memória        |
//  +--+--+--+     +--+                        |
//E |  |  |  +-----+  |                        |
//  ++-++-++-+        |                        |
//   |  |  |          |                        |
//   |  |  |          +-+-+-+------------+-+-+-+
//   |  |  |            | | |            | | |
//   |  |  | +------+   | | |            | | |
//   +-------+      +---+ | |            | | +---------+
//      |  | |  FF  |     | |            | |           |
//      |  | |      |     | |            | +---------+ |
//      |  | +------+     | |            |           | |
//      |  | +------+     | |            +---------+ | |
//      +----+      +-----+ |                      | | |
//         | |  FF  |       |                      | | +
//         | |      |       |                      | +  s0
//         | +------+       |                      +  s1
//         | +------+       |                       s2
//         +-+      +-------+
//           |  FF  |
//           |      |
//           +------+
//
//
//
//
//          
//
//     Implementação:  (Usando de exemplo os exemplos 2 e 6 feitos em sala)



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


//Fliflop para consertar o caso 000


module ff2 ( input data, input c, input r, output q);
reg q;
always @(posedge c or negedge r) 
begin
 if(r==1'b0)
  q <= 1'b1; 
 else 
  q <= data; 
end 
endmodule 

//FNM com Memória


module stateMem (input clk, input res,input a, output [2:0]s);
reg [5:0] StateMachine [0:15];    //Memória de 16 linhas com 6 bits de dados

initial
begin
StateMachine[1] = 6'b100101;
StateMachine[2] = 6'b101000;
StateMachine[4] = 6'b101010;
StateMachine[5] = 6'b110100;
StateMachine[6] = 6'b001011;
StateMachine[9] = 6'b010101;  
StateMachine[10] = 6'b110000;
StateMachine[12] = 6'b101010;
StateMachine[13] = 6'b010100;
StateMachine[14] = 6'b100011;
end

wire [3:0] address;
wire [5:0] dout;

assign address[3] = a;
assign dout = StateMachine[address];
assign s = dout[2:0];

ff2 st0(dout[3],clk,res,address[0]);
ff st1(dout[4],clk,res,address[1]);
ff2 st2(dout[5],clk,res,address[2]);

endmodule


//FNM com Maquina de estados (Alto nível com Case)


module stateM (clk, rst, a, s);
input clk, rst, a;
reg [2:0]state;
output [2:0]s;

parameter zero=3'b010, dois=3'b100, tres=3'b110, quatro=3'b101, cinco=3'b001;

assign s = (state == zero)? 3'b000:
           (state == dois)? 3'b010:
           (state == tres)? 3'b011:
           (state == quatro)? 3'b100: 3'b101;   

  
always @(posedge clk or negedge rst)
     begin
          if (rst==0)
               if(a == 1) state = zero; else state = quatro;
          else
               case (state)
                    zero:	if(a == 1) state <= tres;	else state <= quatro;
					dois:	state <= quatro;
					tres:	if(a == 1) state <= dois;	else state <= cinco;
					quatro:	if(a == 1) state <= zero;	else state <= tres;
					cinco:	if(a == 1) state <= zero;	else state <= dois;
				endcase
     end
  
endmodule
 
 
//FNM com Porta Lógica
 
//	p[2] <= A'B' + A'C' + AD'             5 Not + 3 And + 2 Or      =10
//	p[1] <= BD + AB'                      1 Not + 2 And + 1 Or      =4
//	p[0] <= A'D' + C'D'                   4 Not + 2 And + 1 Or      =6
//	said[2] <= D                          0 Not + 0 And + 0 Or      =0
//	said[1] <= BD'                        1 Not + 1 And + 0 Or      =2
//	said[0] <= B'C' + BC                  2 Not + 2 And + 2 Or      =6
//
//                                        Total de operadores       =28
 
 
module statePorta (input clk, input res,input a, output [2:0]s);

wire [2:0] e;
wire [2:0] p;

assign p[2] = (~a&~e[2]) | (~a&~e[1]) | (a&~e[0]);
assign p[1] = (e[2]&e[0]) | (a&~e[2]);
assign p[0] = (~a&~e[0]) | (~e[1]&~e[0]);
assign s[2] = e[0];
assign s[1] = e[2]&~e[0];
assign s[0] = (~e[2]&~e[1]) | (e[2]&e[1]);

ff2  e0(p[0],clk,res,e[0]);
ff  e1(p[1],clk,res,e[1]);
ff2  e2(p[2],clk,res,e[2]);

endmodule 


//Main (Coloquei os 3 para rodar junto para ter uma verificação facilitada)

	
module main;
reg c,res,a;
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
     $monitor($time," Cloclk %b Reset %b a %b EstadoMem %d EstadoM %d EstadoP %d",c,res,a,estMem, estM, estP);
      #1 a=0; res=0; 
      #1 res=1;
	  #8 a=1;
      #8 a=0;
      #8;
      $finish ;
    end
endmodule