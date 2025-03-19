.MODEL SMALL
.STACK 500H

.DATA 

; LINES T1, T2, T3 AND T4 ARE USED TO BUILD THE TIC - TAC - TOE LOGO
T1 DB  4,  4, 4,  4,  4, 32,  4, 32,  4,  4,  4,  4, 32, 32, 32,  4,  4,  4, 4,  4, 32, 32,  4,  4, 32, 32,  4, 4,  4,  4,  32, 32, 32,   4,  4, 4,  4,  4,  32, 32,  4,   4, 32, 32, 4, 4, 4, 4, '$'
T2 DB 32, 32, 4, 32, 32, 32,  4, 32,  4, 32, 32, 32, 32, 32, 32, 32, 32, 4, 32, 32, 32,  4, 32, 32,  4, 32,  4, 32, 32, 32, 32, 32, 32 , 32, 32, 4, 32, 32,  32,  4, 32,  32,  4, 32, 4,'$'
T3 DB 32, 32, 4, 32, 32, 32,  4, 32,  4, 32, 32, 32, 32, 32, 32, 32, 32, 4, 32, 32, 32,  4,  4,  4,  4, 32,  4, 32, 32, 32, 32, 32, 32 , 32, 32, 4, 32, 32,  32,  4, 32,  32,  4, 32, 4, 4, 4, 4,'$' 
T4 DB 32, 32, 4, 32, 32, 32,  4, 32,  4,  4,  4,  4, 32,  4, 32, 32, 32, 4, 32, 32, 32,  4, 32, 32,  4, 32,  4,  4,  4,  4, 32,  4, 32 , 32, 32, 4, 32, 32,  32, 32,  4,   4, 32, 32, 4, 4, 4, 4,'$'
;--------------------------------------------------------------------

PAK DB 'Presiona una tecla...$'


R DB 'Reglas:$' 
R1 DB '1. Los jugadores tomarán turnos.$'
R2 DB '2. El Jugador 1 comenzará el juego.$'
R3 DB '3. El Jugador 1 colocará "X" y el Jugador 2 colocará "O".$'
R4 DB '4. El tablero está marcado con números de celda.$'
R5 DB '5. Ingresa el NÚMERO DE CELDA para colocar tu marca.$'
R6 DB '6. Coloca 3 de tus marcas horizontalmente, verticalmente o diagonalmente para ganar.$'

R7 DB '¡Buena suerte!$'

; MARCA DE CELDA PARA LOS JUGADORES
PC1 DB ' (X)$'
PC2 DB ' (O)$'

; LÍNEAS DEL TABLERO -------
L1 DB '   |   |   $'
L2 DB '-----------$'
N1 DB ' | $'
; -------------------

; NÚMEROS DE CELDA ------
C1 DB '1$'
C2 DB '2$'
C3 DB '3$'
C4 DB '4$'
C5 DB '5$'
C6 DB '6$'
C7 DB '7$'
C8 DB '8$'
C9 DB '9$'
; -------------------

; NÚMERO DE JUGADOR, MOVIMIENTOS Y BANDERAS PARA VERIFICAR SI EL JUEGO ESTÁ GANADO O EMPATADO
PLAYER DB 50, '$'
MOVES DB 0
DONE DB 0
DR DB 0
; SECCIÓN DE ENTRADA -------------------------
INP DB 32, ':: Ingresa el número de celda: $'
TKN DB '¡Esta celda ya está ocupada! Presiona cualquier tecla...$'

; MARCA ACTUAL (X/O) -------------------------
CUR DB 88

; MENSAJES FINALES ---------------------------
W1 DB '¡El jugador $'
W2 DB ' ha ganado el juego!$'
DRW DB '¡El juego ha terminado en empate!$'

; MENSAJES PARA JUGAR DE NUEVO ---------------
TRA DB '¿Quieres jugar de nuevo? (s/n): $'
WI DB  32, 32, 32, '¡Entrada incorrecta! Presiona cualquier tecla...   $'

; ESTA LÍNEA SE UTILIZA PARA SOBREESCRIBIR UNA LÍNEA Y LIMPIAR EL ÁREA
EMP DB '                                        $'

;--------------------------------------------------------

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX 
    
; --------- MOSTRAR LA PANTALLA DE TÍTULO ---------    
    TITLESCREEN:
    
        ; INICIO DE LA VISUALIZACIÓN DEL LOGO -----------------
         
            ; ESTABLECER CURSOR
            MOV AH, 2
            MOV BH, 0
            MOV DH, 6
            MOV DL, 14
            INT 10H 
            
        LEA DX, T1
        MOV AH, 9
        INT 21H

            ; ESTABLECER CURSOR
            MOV AH, 2
            MOV DH, 7
            MOV DL, 14
            INT 10H 
            
           
        
        LEA DX, T2
        MOV AH, 9
        INT 21H
                         
                          
            ; ESTABLECER CURSOR 
            MOV AH, 2
            MOV DH, 8
            MOV DL, 14
            INT 10H 
           
        
        LEA DX, T3
        MOV AH, 9
        INT 21H
                

            ; ESTABLECER CURSOR 
            MOV AH, 2
            MOV DH, 9
            MOV DL, 14
            INT 10H  
              
        
        LEA DX, T2
        MOV AH, 9
        INT 21H

            ; ESTABLECER CURSOR 
            MOV AH, 2
            MOV DH, 10
            MOV DL, 14
            INT 10H 
        
        LEA DX, T4
        MOV AH, 9
        INT 21H 
            
        
        ; FIN DE LA VISUALIZACIÓN DEL LOGO -----------------
        
            ; ESTABLECER CURSOR
            MOV AH, 2
            MOV DH, 12
            MOV DL, 22
            INT 10H 
            
        
        LEA DX, TAGLINE
        MOV AH, 9
        INT 21H
        
            ; ESTABLECER CURSOR
            MOV AH, 2
            MOV DH, 13
            MOV DL, 24
            INT 10H  
         
        
        LEA DX, PAK  ; PRESIONA CUALQUIER TECLA
        MOV AH, 9
        INT 21H
        
        MOV AH, 7    ; ENTRADA SIN ECO
        INT 21H
        
            ; LIMPIAR PANTALLA
                    
            MOV AX,0600H 
            MOV BH,07H 
            MOV CX,0000H 
            MOV DX,184FH 
            INT 10H 
            
            
            
            JMP RULES
; ----------- MOSTRAR LAS REGLAS DEL JUEGO --------------
                                               
                                               
    RULES:
            ; ESTABLECER CURSOR
            MOV AH, 2
            MOV BH, 0
            MOV DH, 6
            MOV DL, 7
            INT 10H
        
        LEA DX, R
        MOV AH, 9
        INT 21H
        

            ; ESTABLECER CURSOR
            MOV AH, 2
            MOV DH, 7
            MOV DL, 7
            INT 10H 
        
        
        LEA DX, R1   ; REGLA 1
        MOV AH, 9
        INT 21H 
        

            ; ESTABLECER CURSOR 
            MOV AH, 2
            MOV DH, 8
            MOV DL, 7
            INT 10H 
        
        LEA DX, R2   ; REGLA 2
        MOV AH, 9
        INT 21H
        

            ; ESTABLECER CURSOR 
            MOV AH, 2
            MOV DH, 9
            MOV DL, 7
            INT 10H 
        
        
        LEA DX, R3   ; REGLA 3
        MOV AH, 9
        INT 21H
        

            ; ESTABLECER CURSOR
            MOV AH, 2
            MOV DH, 10
            MOV DL, 7
            INT 10H
        
        
        LEA DX, R4   ; REGLA 4
        MOV AH, 9
        INT 21H
        
  
            ; ESTABLECER CURSOR 
            MOV AH, 2
            MOV DH, 11
            MOV DL, 7
            INT 10H      
            
        
        LEA DX, R5  ; REGLA 5
        MOV AH, 9
        INT 21H
        
            
            ; ESTABLECER CURSOR
            MOV AH, 2
            MOV DH, 12
            MOV DL, 7
            INT 10H
            
            
        LEA DX, R6
        MOV AH, 9
        INT 21H
           
           ; ESTABLECER CURSOR
            MOV AH, 2
            MOV DH, 13
            MOV DL, 7
            INT 10H
             
       LEA DX, R7
       MOV AH, 9
       INT 21H
            
            ; ESTABLECER CURSOR
            MOV AH, 2
            MOV DH, 15
            MOV DL, 7
            INT 10H     
        
        LEA DX, PAK ; PRESIONA CUALQUIER TECLA
        MOV AH, 9
        INT 21H
        
        MOV AH, 7   ; ENTRADA SIN ECO
        INT 21H    
    ; ---------- INICIALIZACIÓN ---------------------
       
       INIT: 
           
            MOV PLAYER, 50     ; INICIALIZANDO TODAS LAS VARIABLES
            MOV MOVES, 0  
            MOV DONE, 0
            MOV DR, 0 
            
            MOV C1, 49
            MOV C2, 50
            MOV C3, 51
            MOV C4, 52
            MOV C5, 53
            MOV C6, 54
            MOV C7, 55
            MOV C8, 56
            MOV C9, 57
                                                  
            JMP PLRCHANGE

; ---------- FIN DE LA INICIALIZACIÓN --------------

            
            
                       
; ------------ VICTORIA ------------------------

    VICTORY:
    
            
            LEA DX, W1
            MOV AH, 9
            INT 21H
            
            LEA DX, PLAYER
            MOV AH, 9
            INT 21H
            
            LEA DX, W2
            MOV AH, 9
            INT 21H
            
                ; ESTABLECER CURSOR 
                MOV AH, 2
                MOV DH, 17
                MOV DL, 28 
                INT 10H  
                
            LEA DX, PAK  ; PRESIONA CUALQUIER TECLA
            MOV AH, 9
            INT 21H
            
            MOV AH, 7    ; ENTRADA SIN ECO
            INT 21H    
            
            JMP TRYAGAIN 
            
            
; ------------ EMPATE ------------  

    DRAW:
            LEA DX, DRW
            MOV AH, 9
            INT 21H 
            
            
            
                    ; ESTABLECER CURSOR 
                MOV AH, 2
                MOV DH, 17
                MOV DL, 28 
                INT 10H
                
            LEA DX, PAK ; PRESIONA CUALQUIER TECLA
            MOV AH, 9
            INT 21H
            
            MOV AH, 7   ; ENTRADA SIN ECO
            INT 21H    
            
            JMP TRYAGAIN
; ------------ VERIFICAR SI SE CUMPLE LA CONDICIÓN DE VICTORIA -----------

    CHECK:   ; HAY 8 COMBINACIONES GANADORAS POSIBLES 
        
        CHECK1:  ; VERIFICANDO 1, 2, 3 
            MOV AL, C1
            MOV BL, C2 
            MOV CL, C3
            
            CMP AL, BL
            JNZ CHECK2
            
            CMP BL, CL
            JNZ CHECK2
            
            MOV DONE, 1
            JMP BOARD
            
        CHECK2:  ; VERIFICANDO 4, 5, 6 
            MOV AL, C4
            MOV BL, C5 
            MOV CL, C6
            
            CMP AL, BL
            JNZ CHECK3
            
            CMP BL, CL
            JNZ CHECK3
            
          
            MOV DONE, 1
            JMP BOARD
            
           
       CHECK3:  ; VERIFICANDO 7, 8, 9
            MOV AL, C4
            MOV BL, C5 
            MOV CL, C6
            
            CMP AL, BL
            JNZ CHECK4
            
            CMP BL, CL
            JNZ CHECK4 
            
            MOV DONE, 1
            JMP BOARD
            
             
       CHECK4:   ; VERIFICANDO 1, 4, 7
            MOV AL, C1
            MOV BL, C4 
            MOV CL, C7
            
            CMP AL, BL
            JNZ CHECK5
            
            CMP BL, CL
            JNZ CHECK5
        
            MOV DONE, 1
            JMP BOARD
        
       
       CHECK5:   ; VERIFICANDO 2, 5, 8
            MOV AL, C2
            MOV BL, C5 
            MOV CL, C8
            
            CMP AL, BL
            JNZ CHECK6
            
            CMP BL, CL
            JNZ CHECK6
        
            MOV DONE, 1
            JMP BOARD
            
       
       CHECK6:   ; VERIFICANDO 3, 6, 9
            MOV AL, C3
            MOV BL, C6 
            MOV CL, C9
            
            CMP AL, BL
            JNZ CHECK7
            
            CMP BL, CL
            JNZ CHECK7
        
            MOV DONE, 1
            JMP BOARD
            
        
        CHECK7:   ; VERIFICANDO 1, 5, 9
            MOV AL, C1
            MOV BL, C5 
            MOV CL, C9
            
            CMP AL, BL
            JNZ CHECK8
            
            CMP BL, CL
            JNZ CHECK8
        
            MOV DONE, 1
            JMP BOARD  
            
        
        CHECK8:   ; VERIFICANDO 3, 5, 7
            MOV AL, C3
            MOV BL, C5 
            MOV CL, C7
            
            CMP AL, BL
            JNZ DRAWCHECK
            
            CMP BL, CL
            JNZ DRAWCHECK
            
            MOV DONE, 1
            JMP BOARD
            
       DRAWCHECK:
            MOV AL, MOVES
            CMP AL, 9
            JB PLRCHANGE
            
            MOV DR, 1
            JMP BOARD
            
            JMP EXIT
       

; ------------ JUGADOR ----------        
    PLRCHANGE:
                         
        CMP PLAYER, 49
        JZ P2
        CMP PLAYER, 50
        JZ P1
        
        P1:
            MOV PLAYER, 49
            MOV CUR, 88
            
            
            
            JMP BOARD
             
        P2:
            MOV PLAYER, 50
            MOV CUR, 79
            JMP BOARD
; ------------- TABLERO ----------   
    BOARD: 
    
        ; LIMPIAR PANTALLA        
        MOV AX,0600H 
        MOV BH,07H 
        MOV CX,0000H 
        MOV DX,184FH 
        INT 10H
    
        ; ESTABLECER CURSOR
        MOV AH, 2
        MOV BH, 0
        MOV DH, 6
        MOV DL, 30
        INT 10H   
        
    LEA DX, L1
    MOV AH, 9
    INT 21H 
     
        ; ESTABLECER CURSOR 
        MOV AH, 2
        MOV DH, 7
        MOV DL, 30 
        INT 10H
    
    MOV AH, 2
    MOV DL, 32
    INT 21H

; --------------------------------    
    ; CELDA 1 
    
    LEA DX, C1
    MOV AH, 9
    INT 21H 
    
    LEA DX, N1
    MOV AH, 9
    INT 21H
    
    ; CELDA 2
    
    LEA DX, C2
    MOV AH, 9
    INT 21H
    
    LEA DX, N1
    MOV AH, 9
    INT 21H
    
    ; CELDA 3
    
    LEA DX, C3
    MOV AH, 9
    INT 21H
    
; ---------------------------------    
    

        ; ESTABLECER CURSOR
        MOV AH, 2
        MOV DH, 8
        MOV DL, 30 
        INT 10H 
     
    
    LEA DX, L2
    MOV AH, 9
    INT 21H 
    

        ; ESTABLECER CURSOR
        MOV AH, 2
        MOV DH, 9
        MOV DL, 30 
        INT 10H
    
    LEA DX, L1
    MOV AH, 9
    INT 21H 
    
        ; ESTABLECER CURSOR
        MOV AH, 2
        MOV DH, 10
        MOV DL, 30 
        INT 10H
    
    MOV AH, 2
    MOV DL, 32
    INT 21H
    
; --------------------------------    
    ; CELDA 4 
    
    LEA DX, C4
    MOV AH, 9
    INT 21H 
    
    LEA DX, N1
    MOV AH, 9
    INT 21H
    
    ; CELDA 5
    
    LEA DX, C5
    MOV AH, 9
    INT 21H
    
    LEA DX, N1
    MOV AH, 9
    INT 21H
    
    ; CELDA 6
    
    LEA DX, C6
    MOV AH, 9
    INT 21H
    
; ---------------------------------     

        ; ESTABLECER CURSOR
        MOV AH, 2
        MOV DH, 11
        MOV DL, 30 
        INT 10H
        
    LEA DX, L1
    MOV AH, 9
    INT 21H 
 
        ; ESTABLECER CURSOR
        MOV AH, 2
        MOV DH, 12
        MOV DL, 30 
        INT 10H 
     
    
    LEA DX, L2
    MOV AH, 9
    INT 21H 
    

        ; ESTABLECER CURSOR
        MOV AH, 2
        MOV DH, 13
        MOV DL, 30 
        INT 10H
    
    LEA DX, L1
    MOV AH, 9
    INT 21H 
    

        ; ESTABLECER CURSOR
        MOV AH, 2
        MOV DH, 14
        MOV DL, 30 
        INT 10H 
    
    MOV AH, 2
    MOV DL, 32
    INT 21H   
    
         
; --------------------------------    
    ; CELDA 7 
    
    LEA DX, C7
    MOV AH, 9
    INT 21H 
    
    LEA DX, N1
    MOV AH, 9
    INT 21H
    
    ; CELDA 8
    
    LEA DX, C8
    MOV AH, 9
    INT 21H
    
    LEA DX, N1
    MOV AH, 9
    INT 21H
    
    ; CELDA 9
    
    LEA DX, C9
    MOV AH, 9
    INT 21H
    
; ---------------------------------     

        ; ESTABLECER CURSOR
        MOV AH, 2
        MOV DH, 15
        MOV DL, 30 
        INT 10H 
     
    
    LEA DX, L1
    MOV AH, 9
    INT 21H
     
        ; ESTABLECER CURSOR 
        MOV AH, 2
        MOV DH, 16
        MOV DL, 20 
        INT 10H
    
    
    CMP DONE, 1
    JZ VICTORY
    
    CMP DR, 1
    JZ DRAW
     
; ------------ FIN DEL TABLERO -------
        ; ------------ ENTRADA --------------

    INPUT:
    
    LEA DX, W1
    MOV AH, 9
    INT 21H
    
    MOV AH, 2
    MOV DL, PLAYER
    INT 21H
    
    CMP PLAYER, 49
    JZ PL1
    
        LEA DX, PC2
        MOV AH, 9
        INT 21H
        JMP TAKEINPUT
    
    
        PL1:
            LEA DX, PC1
            MOV AH, 9
            INT 21H 
    
    TAKEINPUT:
    LEA DX, INP
    MOV AH, 9
    INT 21H
    
    MOV AH, 1
    INT 21H 
    
   
    
    INC MOVES ; INCREMENTANDO EL CONTADOR DE MOVIMIENTOS EN 1
     
    MOV BL, AL 
    SUB BL, 48
    
    MOV CL, CUR 
    
       
    
    ; VERIFICANDO SI LA ENTRADA ESTÁ ENTRE 1-9
    CMP BL, 1
    JZ  C1U 
    
    CMP BL, 2
    JZ  C2U
    
    CMP BL, 3
    JZ  C3U
    
    CMP BL, 4
    JZ  C4U
    
    CMP BL, 5
    JZ  C5U
    
    CMP BL, 6
    JZ  C6U
    
    CMP BL, 7
    JZ  C7U
    
    CMP BL, 8
    JZ  C8U
    
    CMP BL, 9
    JZ  C9U  
    ;---------------------------------
    
    
    ; SI LA ENTRADA NO ES VÁLIDA
    
    DEC MOVES ; DECREMENTANDO MOVIMIENTOS EN 1, YA QUE FUE INVÁLIDA
    
        ; ESTABLECER CURSOR 
        MOV AH, 2
        MOV DH, 16
        MOV DL, 20 
        INT 10H 
        
    LEA DX, WI  ; MENSAJE DE ENTRADA INCORRECTA
    MOV AH, 9
    INT 21H
    
    MOV AH, 7   ; ENTRADA SIN ECO
    INT 21H
    
        ; ESTABLECER CURSOR 
        MOV AH, 2
        MOV DH, 16
        MOV DL, 20 
        INT 10H
        
    LEA DX, EMP  ; LIMPIANDO ESA LÍNEA
    MOV AH, 9
    INT 21H  
    
        ; ESTABLECER CURSOR 
        MOV AH, 2
        MOV DH, 16
        MOV DL, 20 
        INT 10H
    
    JMP INPUT
    
    
    TAKEN:
        DEC MOVES
            ; ESTABLECER CURSOR 
            MOV AH, 2
            MOV DH, 16
            MOV DL, 20 
            INT 10H   
            
        LEA DX, TKN   ; MOSTRAR QUE LA CELDA ESTÁ OCUPADA
        MOV AH, 9
        INT 21H  
        
        MOV AH, 7     ; ENTRADA SIN ECO
        INT 21H 
        
            ; ESTABLECER CURSOR 
            MOV AH, 2
            MOV DH, 16
            MOV DL, 20 
            INT 10H
            
        LEA DX, EMP   ; LÍNEA VACÍA PARA SOBREESCRIBIR Y LIMPIAR EL ESPACIO
        MOV AH, 9
        INT 21H 
        
            ; ESTABLECER CURSOR 
            MOV AH, 2
            MOV DH, 16
            MOV DL, 20 
            INT 10H
        
        JMP INPUT
        
        
    
    
    ; AJUSTE 
    
    ; ESTABLECIENDO LA POSICIÓN DEL TABLERO COMO MARCA DE ENTRADA
        C1U:
            CMP C1, 88  ; VERIFICANDO SI LA CELDA YA TIENE 'X'
            JZ TAKEN
            CMP C1, 79  ; VERIFICANDO SI LA CELDA YA TIENE 'O'
            JZ TAKEN 
            
            MOV C1, CL
            JMP CHECK
             
        C2U:
            CMP C2, 88  ; VERIFICANDO SI LA CELDA YA TIENE 'X'
            JZ TAKEN
            CMP C2, 79  ; VERIFICANDO SI LA CELDA YA TIENE 'O'
            JZ TAKEN 
            
            MOV C2, CL
            JMP CHECK
        C3U:
            CMP C3, 88  ; VERIFICANDO SI LA CELDA YA TIENE 'X'
            JZ TAKEN
            CMP C3, 79  ; VERIFICANDO SI LA CELDA YA TIENE 'O'
            JZ TAKEN 
            
            MOV C3, CL
            JMP CHECK
        C4U: 
            CMP C4, 88  ; VERIFICANDO SI LA CELDA YA TIENE 'X'
            JZ TAKEN
            CMP C4, 79  ; VERIFICANDO SI LA CELDA YA TIENE 'O'
            JZ TAKEN 
            
            MOV C4, CL
            JMP CHECK 
        C5U: 
            CMP C5, 88  ; VERIFICANDO SI LA CELDA YA TIENE 'X'
            JZ TAKEN
            CMP C5, 79  ; VERIFICANDO SI LA CELDA YA TIENE 'O'
            JZ TAKEN 
            
            MOV C5, CL
            JMP CHECK
        C6U:
            CMP C6, 88  ; VERIFICANDO SI LA CELDA YA TIENE 'X'
            JZ TAKEN
            CMP C6, 79  ; VERIFICANDO SI LA CELDA YA TIENE 'O'
            JZ TAKEN 
            
            MOV C6, CL
            JMP CHECK
        C7U: 
            CMP C7, 88   ; VERIFICANDO SI LA CELDA YA TIENE 'X'
            JZ TAKEN
            CMP C7, 79   ; VERIFICANDO SI LA CELDA YA TIENE 'O'
            JZ TAKEN 
            
            MOV C7, CL
            JMP CHECK 
        C8U: 
            CMP C8, 88   ; VERIFICANDO SI LA CELDA YA TIENE 'X'
            JZ TAKEN
            CMP C8, 79   ; VERIFICANDO SI LA CELDA YA TIENE 'O'
            JZ TAKEN 
            
            MOV C8, CL
            JMP CHECK
        C9U:
            CMP C9, 88   ; VERIFICANDO SI LA CELDA YA TIENE 'X'
            JZ TAKEN
            CMP C9, 79   ; VERIFICANDO SI LA CELDA YA TIENE 'O'
            JZ TAKEN 
            
            MOV C9, CL
            JMP CHECK
; --------------------------------

; ----------- INTENTAR DE NUEVO -----------

    TRYAGAIN:
            ; LIMPIAR PANTALLA
                        
            MOV AX,0600H 
            MOV BH,07H 
            MOV CX,0000H 
            MOV DX,184FH 
            INT 10H  
            
            ; ESTABLECER CURSOR
            MOV AH, 2
            MOV BH, 0
            MOV DH, 10
            MOV DL, 24
            INT 10H
        
        
    
        LEA DX, TRA   ; PREGUNTA PARA INTENTAR DE NUEVO
        MOV AH, 9 
        INT 21H
        
        MOV AH, 1     
        INT 21H
        
        CMP AL, 121  ; VERIFICAR SI LA ENTRADA ES 'y'
        JZ INIT 
        
        CMP AL, 89   ; VERIFICAR SI LA ENTRADA ES 'Y'
        JZ INIT
        
        ; SI LA ENTRADA ES 'Y'/'y' ENTONCES REPETIR EL JUEGO
        
        CMP AL, 110  ; VERIFICAR SI LA ENTRADA ES 'n'
        JZ EXIT
        CMP AL, 78   ; VERIFICAR SI LA ENTRADA ES 'N'
        JZ EXIT  
        
        ; SI LA ENTRADA ES 'N'/'n' ENTONCES SALIR DEL JUEGO
        
        
        ; SI LA ENTRADA NO ES VÁLIDA
        
            ; ESTABLECER CURSOR
            MOV AH, 2
            MOV BH, 0
            MOV DH, 10
            MOV DL, 24
            INT 10H
        
        LEA DX, WI  ; MENSAJE DE ENTRADA INCORRECTA
        MOV AH, 9
        INT 21H 
        
        MOV AH, 7 ; ENTRADA SIN ECO
        INT 21H
            
            ; ESTABLECER CURSOR
            MOV AH, 2
            MOV BH, 0
            MOV DH, 10
            MOV DL, 24
            INT 10H
        
        LEA DX, EMP  ; LÍNEA VACÍA PARA SOBREESCRIBIR Y LIMPIAR EL ESPACIO
        MOV AH, 9
        INT 21H
        
        
        
        JMP TRYAGAIN ; VOLVER A PREGUNTAR SI DESEA INTENTAR DE NUEVO     
    

; ----------- FIN DE LA ENTRADA -------- 

    EXIT:
    MOV AH, 4CH
    INT 21H 
    MAIN ENDP
END MAIN