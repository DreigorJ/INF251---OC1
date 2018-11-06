v: .void

.text

//vetor x começa no 100 em t1, indo de 4 em 4
//vetor y começa no 200 em t1, indo de 4 em 4
//vetor z começa no 300 em t1, indo de 4 em 4, sendo z o vetor resultado
	
li $t0,0;
li $s1,0;               //iterador
	
	loop:
		lw $t1,100($s1);            //x[t1]
		lw $t2,200($s1);            //y[t1]
		beq $t1,$t0,fim;            //Verifica se algum vetor acabou
		beq $t2,$t0,fim;
		add $t3,$t1,$t2;            //faz a soma
		sw $t3,300($s1);            //salva a soma em z[t1]
		addi $s1,$s1,4;          
	jump loop;

fim: