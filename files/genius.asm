
jmp main

; Palavras/frases utilizadas
nomeJogo : string "GENIUS"
mensagemInicio : string "[enter para iniciar o jogo]"
apagaMensagem : string "                           "
Letra : var #0
pontos : string " Pontos: "

incRand: var #1;circular a tabela de nr. Randomicos
randSequence : var #35; tabela de nr. Randomicos
   static randSequence + #0 , #56241    ; %4 = 1
   static randSequence + #1 , #53281    ; %4 = 2
   static randSequence + #2 , #1409     ; %4 = 3
   static randSequence + #3 , #30428    ; %4 = 0
   static randSequence + #4 , #51627    ; %4 = 3
   static randSequence + #7 , #10476    ; %4 = 0
   static randSequence + #8 , #42149    ; %4 = 1
   static randSequence + #9 , #15652    ; %4 = 2
   static randSequence + #10, #40367    ; %4 = 3
   static randSequence + #11, #1221     ; %4 = 1
   static randSequence + #12, #33317    ; %4 = 2
   static randSequence + #13, #49878    ; %4 = 0
   static randSequence + #14, #57321    ; %4 = 1
   static randSequence + #15, #13091    ; %4 = 2
   static randSequence + #16, #12214    ; %4 = 3
   static randSequence + #17, #7925     ; %4 = 1
   static randSequence + #18, #15409    ; %4 = 2
   static randSequence + #19, #51788    ; %4 = 0
   static randSequence + #20, #29654    ; %4 = 2
   static randSequence + #21, #23848    ; %4 = 0
   static randSequence + #22, #43871    ; %4 = 3
   static randSequence + #23, #56169    ; %4 = 1
   static randSequence + #24, #33517    ; %4 = 3
   static randSequence + #25, #39218    ; %4 = 2
   static randSequence + #26, #39371    ; %4 = 3
   static randSequence + #27, #61204    ; %4 = 0
   static randSequence + #28, #47533    ; %4 = 1
   static randSequence + #29, #18006    ; %4 = 2
   static randSequence + #30, #18996    ; %4 = 2
   static randSequence + #31, #18456    ; %4 = 3
   static randSequence + #32, #19456    ; %4 = 0
   static randSequence + #33, #21456    ; %4 = 1
   static randSequence + #34, #0        ; %4 = 0
; %4: 0 = verde, 1 = vermelho, 2 = amarelo, 3 = azul
; cima: verde, direita: vermelho, esquerda: amarelo, baixo: azul
; probabilidades:
; 0: 0.25 (8)
; 1: 0.25 (8)
; 2: 0.25 (8)
; 3: 0.25 (8)
; fim da tabela de nr. Randomicos

jogadasAtual : var #0 ; indice da ultima jogada no vetor jogadas
ultimaJogada : var #0 ; converte Letra para numero
jogadas : var #32
numJogadas: var #0

; da pra dividir em tres grupos
; um -> piscarSequencia e verificaExec
;   piscarSequencia -> pisca as cores de acordo com a sequencia (jogadas)
;   verificaExec -> verifica se a sequencia digitada pelo usuario esta correta
; dois-> geradordeAleatorio e escreve main
; tres -> geraPaginaJogo

main:   ; gera pagina inicial

    ; NAO REMOVER
    loadn r0, #0
    store jogadasAtual, r0
    call insereJogadaAleatoria
    ; NAO REMOVER

	call DesenharEstrelas;
	loadn r0, #296			; Posicao na tela onde a mensagem sera' escrita
	loadn r1, #nomeJogo	; Carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #0			; Seleciona a COR da Mensagem
	
	call Imprimestr

	loadn r0, #807			; Posicao na tela onde a mensagem sera' escrita
	loadn r1, #mensagemInicio	; Carrega r1 com o endereco do vetor que contem a mensagem
	loadn r2, #0			; Seleciona a COR da Mensagem
	
	call Imprimestr

	call esperaInicio

	call geraPaginaJogo
	
    ; pode comentar isso aqui depois
    call insereJogadaAleatoria
    loadn r0, #1
    call acessaJogada
    mov r1, r0
    loadn r0, #1
    call acessaJogada

    call loseSound

    ;call loopJogo


	halt

loseSound:
    push r0
    push r1
    push r2

    loadn r2, #2 ;onda triangular

    loadn r0, #5873 ; NOTE_D4
    loadn r1, #400 ; 400ms
    sound r0, r1, r2

    loadn r0, #5544 ; NOTE_C4s
    sound r0, r1, r2

    loadn r0, #5232 ; NOTE_C4
    sound r0, r1, r2

    loadn r0, #4938 ; NOTE_B4
    loadn r1, #1000 ; 1s
    sound r0, r1, r2

    pop r2
    pop r1
    pop r0

    rts

digLetra:	; Espera que uma tecla seja digitada e salva na variavel global "Letra"
	push fr		; Protege o registrador de flags
	push r0
	push r1
	loadn r1, #255	; Se nao digitar nada vem 255

   	digLetra_Loop:
		inchar r0			; Le o teclado, se nada for digitado = 255
		cmp r0, r1			;compara r0 com 255
		jeq digLetra_Loop	; Fica lendo ate' que digite uma tecla valida

	store Letra, r0			; Salva a tecla na variavel global "Letra"			
	
	pop r1
	pop r0
	pop fr
	rts

esperaInicio:
	push r0
	push r1
	loadn r1, #13
	esperaInicioLoop:
		call digLetra
		load r0, Letra
		cmp r0, r1
		jne esperaInicioLoop
	pop r1
	pop r0
	rts


geraPaginaJogo:
	push r0
	push r1
	push r2

	; apaga mensagem da tela
	loadn r0, #807			; Posicao na tela onde a mensagem sera' escrita
	loadn r1, #apagaMensagem
	loadn r2, #0			; Seleciona a COR da Mensagem
	
	call Imprimestr

	loadn r0, #53
	loadn r1, #pontos
	loadn r2, #1536
	call Imprimestr

	loadn r0, #64
	loadn r1, #1584
	outchar r1, r0

	loadn r1, #512 ; cor do bloco de cima
	loadn r2, #216 ; posicao do bloco de cima
	call desenhaBloco

	loadn r1, #2816 ; cor do bloco de esq
	loadn r2, #525 ; posicao do bloco de esq
	call desenhaBloco

	loadn r1, #2304 ; cor do bloco de dir
	loadn r2, #547 ; posicao do bloco de dir
	call desenhaBloco
	
	loadn r1, #3072 ; cor do bloco de baixo
	loadn r2, #856 ; posicao do bloco de baixo
	call desenhaBloco

	pop r2
	pop r1
	pop r0
	rts

; definir r1 como cor do bloco e r2 a posicao de INICIO
desenhaBloco:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5

	loadn r0, #125 ; tipo de caracter usado para desenhar o bloco
	loadn r4, #40
	loadn r5, #240 ; criterio de parada das linhas
	add r5, r5, r2 ; adicionando a posicao inicial, assim temos a posicao final do bloco

	desenhaColunaLoop:
		loadn r3, #8
		add r3, r3, r2 ; final da linha
		call desenhaLinha
		add r2, r2, r4
		cmp r2, r5
		jle desenhaColunaLoop

	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts

desenhaLinha:
	push r0 ; caracter
	push r1 ; cor
	push r2 ; posicao

	add r0, r0, r1 ; adiciona cor ao caracter

	desenhaLoop:
		outchar r0, r2 ; printa ele
		inc r2
		cmp r2, r3
		jle desenhaLoop
	
	pop r2
	pop r1
	pop r0
	rts

geraAleatorio: ; gera num aleatorio de 0 a 3 (para o proximo valor do genius)
   push r1

   load r0, incRand
   inc r0
   loadn r1, #35
   mod r0, r0, r1
   store incRand, r0
   loadn r1, #randSequence
   add r1, r1, r0
   loadi r0, r1

   pop r1
   rts


;(r0 - 1) é o valor maximo que pode ser gerado
geraAleatorioComMax:
   push r1
   push r2

   mov r1, r0
   call geraAleatorio
   mod r2, r0, r1
   mov r0, r2

    pop r2
   pop r1
   rts

; r0 = posicao a ser acessada
acessaJogada:
    push r1
    push r2

    mov r1, r0
    ; r0 esta livre
    ; r1 = posicao a ser acessada
    loadn r0, #jogadas
    add r2, r1, r0
    ; r2 agora aponta para a posicao da jogada
    loadi r0, r2

    pop r2
    pop r1
    rts


insereJogadaAleatoria:
    push r0
    push r1
    push r2
    push r3

    ; r3 = contador de jogadas
    load r3, jogadasAtual

    ; coloca em r1 a posicao a ser acessada
    loadn r1, #jogadas
    add r2, r1, r3

    ; r0 = num max - 1
    loadn r0, #4
    call geraAleatorioComMax

    ; r0 = valor aleatorio
    ; r2 = posicao a ser acessada
    storei r2, r0

    inc r3
    store jogadasAtual, r3

    pop r3
    pop r2
    pop r1
    pop r0
    rts


DesenharEstrelas:
	loadn r0, #70
	loadn r1, #810
	outchar r1, r0

	loadn r0, #126
	loadn r1, #1578
	outchar r1, r0

	loadn r0, #456
	loadn r1, #2858
	outchar r1, r0

	loadn r0, #924
	loadn r1, #2858
	outchar r1, r0

	loadn r0, #515
	loadn r1, #810
	outchar r1, r0

	loadn r0, #723
	loadn r1, #1578
	outchar r1, r0

	loadn r0, #664
	loadn r1, #3626
	outchar r1, r0

	loadn r0, #1032
	loadn r1, #1322
	outchar r1, r0

	loadn r0, #232
	loadn r1, #3370
	outchar r1, r0

	loadn r0, #282
	loadn r1, #1322
	outchar r1, r0

	loadn r0, #1055
	loadn r1, #2858
	outchar r1, r0

	loadn r0, #1185
	loadn r1, #3370
	outchar r1, r0
	rts


Imprimestr:		;  Rotina de Impresao de Mensagens:    
				; r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso
				; r1 = endereco onde comeca a mensagem
				; r2 = cor da mensagem
				; Obs: a mensagem sera' impressa ate' encontrar "/0"
				
;---- Empilhamento: protege os registradores utilizados na subrotina na pilha para preservar seu valor				
	push r0	; Posicao da tela que o primeiro caractere da mensagem sera' impresso
	push r1	; endereco onde comeca a mensagem
	push r2	; cor da mensagem
	push r3	; Criterio de parada
	push r4	; Recebe o codigo do caractere da Mensagem
	
	loadn r3, #'\0'	; Criterio de parada

ImprimestrLoop:	
	loadi r4, r1		; aponta para a memoria no endereco r1 e busca seu conteudo em r4
	cmp r4, r3			; compara o codigo do caractere buscado com o criterio de parada
	jeq ImprimestrSai	; goto Final da rotina
	add r4, r2, r4		; soma a cor (r2) no codigo do caractere em r4
	outchar r4, r0		; imprime o caractere cujo codigo está em r4 na posicao r0 da tela
	inc r0				; incrementa a posicao que o proximo caractere sera' escrito na tela
	inc r1				; incrementa o ponteiro para a mensagem na memoria
	jmp ImprimestrLoop	; goto Loop
	
ImprimestrSai:	
;---- Desempilhamento: resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r4	
	pop r3
	pop r2
	pop r1
	pop r0
	rts		; retorno da subrotina

Delay:
	push r0
	push r1
	
	loadn r1, #800  ; a
   	Delay_volta2:				;Quebrou o contador acima em duas partes (dois loops de decremento)
	loadn r0, #3000	; b
   	Delay_volta: 
	dec r0					; (4*a + 6)b = 1000000  == 1 seg  em um clock de 1MHz
	jnz Delay_volta	
	dec r1
	jnz Delay_volta2
	
	pop r1
	pop r0
	
	rts
	
limpaBlocos:
	push r1
	push r2

	loadn r1, #3840

	loadn r2, #216 ; posicao do bloco de cima
	call desenhaBloco

	loadn r2, #525 ; posicao do bloco de esq
	call desenhaBloco

	loadn r2, #547 ; posicao do bloco de dir
	call desenhaBloco
	
	loadn r2, #856 ; posicao do bloco de baixo
	call desenhaBloco
	
	pop r2
	pop r1
	
	rts
	
blocoCima:
	push r1
	push r2
	
	loadn r1, #512 ; cor
	loadn r2, #216 ; posicao do bloco de baixo
	call desenhaBloco
	
	pop r2
	pop r1
	
	rts
	
blocoBaixo:
	push r1
	push r2
	
	loadn r1, #3072 ; cor
	loadn r2, #856 ; posicao do bloco de baixo
	call desenhaBloco
	
	pop r2
	pop r1
	
	rts

blocoEsq:
	push r1
	push r2
	
	loadn r1, #2816 ; cor
	loadn r2, #525 ; posicao do bloco de baixo
	call desenhaBloco
	
	pop r2
	pop r1
	
	rts

blocoDir:
	push r1
	push r2
	
	loadn r1, #2304 ; cor
	loadn r2, #547 ; posicao do bloco de baixo
	call desenhaBloco
	
	pop r2
	pop r1
	
	rts
	
geraBlocoAleat:
	push r0
	push r1
	push r2
	push r3
	push r4
	
    ; MODELO DE USO de acessaJogada
    ; acessa primeira jogada
    ; para acessar a ultima jogada, use o valor de jogadasAtual
    ; load r0, jogadasAtual
    ;call acessaJogada
    ; r0 contem o valor da jogada
	;load r0, jogadasAtual
	
	
    loadn r0, #4
    call geraAleatorioComMax
    
	loadn r1, #0
	cmp r0, r1
	ceq blocoCima
	
	loadn r2, #1
	cmp r0, r2
	ceq blocoDir
	
	loadn r3, #2
	cmp r0, r3
	ceq blocoEsq
	
	loadn r4, #3
	cmp r0, r4
	ceq blocoBaixo
	
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
LoopJogada:
	push r0
	push r1
	push r2
	push r3
	
	load r0, jogadasAtual
	load r3, jogadasAtual ; contador
	
	geraLoop:
		loadi r2, r0
		call acessaJogada
		call geraBlocoAleat
		call Delay
		call limpaBlocos
		loadi r0, r2
		dec r0
		dec r3
		jnz geraLoop
	
	pop r3
	pop r2
	pop r1
	pop r0
	
	rts
	
entradasJogador:
	push r0
	push r1

	load r0, jogadasAtual
	loopEntrada:
		call entrada
		call limpaBlocos
		call geraBlocoJogador
		
		dec r0
		jnz loopEntrada
		
	pop r0
	pop r1
	
	call Delay
	
	rts

entrada:
	push fr
	push r0
	push r1
	push r2
	push r3
	push r4
	
	digita:
		call digLetra
		
		load r0, Letra
		loadn r1, #'w'
		loadn r2, #'a'
		loadn r3, #'s'
		loadn r4, #'d'
		
		cmp r0, r1
		jeq retorna
		cmp r0, r2
		jeq retorna
		cmp r0, r3
		jeq retorna
		cmp r0, r4
		jeq retorna
		
		jmp digita 

	retorna:
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0	
		pop fr
		rts
	
geraBlocoJogador:
	push fr
	push r0
	push r1
	push r2
	push r3
	push r4
	
    ;loadn r0, #4
    ;call geraAleatorioComMax
	load r0, Letra
    
	loadn r1, #'w'
	cmp r0, r1
	ceq blocoCima
	
	loadn r2, #'d'
	cmp r0, r2
	ceq blocoDir
	
	loadn r3, #'a'
	cmp r0, r3
	ceq blocoEsq
	
	loadn r4, #'s'
	cmp r0, r4
	ceq blocoBaixo
	
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	pop fr
	rts
	
loopJogo:
	push r0
	push r1
	push r2
	
	load r0, numJogadas
	inc r0
	store numJogadas, r0
	
	call insereJogadaAleatoria
		
	call LoopJogada
		

	call entradasJogador
	call limpaBlocos
	
	call Delay
	call Delay
	call Delay

	pop r2
	pop r1
	pop r0

	jmp loopJogo
	
	rts