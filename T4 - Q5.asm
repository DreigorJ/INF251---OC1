.data
v: .void

.text
//vetor começa no 100 em t1, indo de 4 em 4
//resultado guardado no 200 em t1

li $t0,0;

li $t1,0; //iterador
li $t3,0; //auxiliar para a soma


loop:
	
	lw $t2,100($t1);               //carrega o elemento
	beq $t2,$t0,fim; 	     //verifica se acabou
	add $t3,$t3,$t2;             //soma
	addi $t1,$t1,4;              //incrementa
	jump loop;

fim:

sw $t3,200($t1);