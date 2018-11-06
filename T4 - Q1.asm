.data
v: .void

.text

li $t0, 0;          //Contador
li $t1, $gp
li $t2, $gp+4
li $t3, $gp+8

li $s0,0;          //resultado
li $t4,0;          //contador resultado 

loop:
	bne $t0,$t1,next1;           //verifica se o 1º apareceu
	sw $s0+$t4,0($t1);
	add $t4, $t4, 4;
	next1:	
	bne $t0,$t1,next2;           //verifica se o 1º apareceu
	sw $s0+$t4,0($t2);
	add $t4, $t4, 4;
	next2:
	bne $t0,$t1,next3;           //verifica se o 1º apareceu3
	sw $s0+$t4,0($t3);
	add $t4, $t4, 4;	
	next3:
	bne $t4,12,loop;
fim:	