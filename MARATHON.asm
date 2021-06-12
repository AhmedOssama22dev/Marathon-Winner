TITLE TWO_DIGIT_ADDITION 
.MODEL SMALL 
include 'emu8086.inc'
.STACK 100H 
.DATA
    ;DEFINE MSGS 
    NUM DB 0AH, 0DH, "ENTER PLAYER NUMBER : ", 0
    TIME DB 0AH, 0DH, "ENTER TIME TAKEN FOR EACH PLAYER : " ,0
    
    ;DEFINE ARRAYS
    PLAYERS DW 25 DUP(?) ;PLAYERS ARRAY
    TIMES DW 25 DUP(?) ;TIMES ARRAY 

    
.CODE 
    MAIN:
    
        MOV AX, @DATA 
        MOV DS, AX
        
        
        
        MOV DX,25  ;NUMBER OF EXCPECTED ENTERIES (COUNTER)
        MOV BX,0   ;OFFSET TO THE ARRAY
        
        INPUT_PLAYERS:
            LEA    SI, NUM       ; ASK FOR THE NUMBER
            putc 10              ; NEW LINE \n
            CALL   print_string  
            CALL   scan_num      ; GET NUMBER IN CX.
            
            MOV PLAYERS[BX],CX   ; INSERT THIS NUMBER TO THE PLAYERS ARRAY
            
            ;INCREMENT BX BY 2 DUE TO WORD ADDRESSING
            INC BX               
            INC BX
            ;LOOP
            DEC DX         
            CMP DX,00H
            
            
            JNZ INPUT_PLAYERS
        
        
        MOV DX,25
        MOV BX,0
        INPUT_TIMES:
            LEA    SI, TIME       ; ASK FOR NUMBER
            putc 10               ; NEW LINE \n
            CALL   print_string   
            CALL   scan_num       ; GET NUMBER IN CX.
            
            MOV TIMES[BX],CX      ; INSERT THIS NUMBER TO THE TIMES ARRAY.
    
            INC BX
            INC BX
            DEC DX         
            CMP DX,00H
            
            
            JNZ INPUT_TIMES    
        
        
        
        MOV BX,0 ;PTR TO ARR BASE
        MOV CX,25 ;ARR SIZE
        DEC CX    ;LOOP UNTILL N-1 (BUBBLE_SORT TECHNIQUE)
            
        BUUBLE_SORT:
            L1: 
                PUSH CX
                MOV BX,0
            L2: 
                ;COMPARE EACH ELEMENT IN TIMES ARR WITH ITS NEXT ONE
                MOV AX,TIMES[BX]   ; SAVE TIMES CURRENT ELEMENT IN AX AS TEMP
                MOV DX,PLAYERS[BX] ; SAVE PLAYERS CURRENT ELEMENT IN DX WILL BE USED IN CASE OF SWAPPING.
                CMP TIMES[BX+2],AX ; COMPARISON
                JG L3              ; ? CURRENT<NEXT : JMP L3
                ;SWAPPING
                XCHG AX,TIMES[BX+2]
                XCHG DX,PLAYERS[BX+2]
                MOV TIMES[BX],AX
                MOV PLAYERS[BX],DX
                
            L3:
                ADD BX,2           ; INC BX BY 2 (WORD ADDRESSING)
                LOOP L2            ; GO TO L2 AGAIN
                
                POP CX
                LOOP L1
                
       
       
                   
       MOV BX,0
       MOV SI,00H
       MOV DX,25 
       PRINT_PLAYERS:
            MOV AX,PLAYERS[BX]
            CALL   pthis
            
            DB  13, 10, 'PLAYER NUMBER ', 0
            
            
            CALL   print_num     ; print number in AX.
            INC BX
            INC BX
            DEC DX
            CMP DX,0
            JNZ PRINT_PLAYERS
       
       
       MOV BX,0
       MOV SI,00H
       MOV DX,25 
       PRINT_TIMES:
            MOV AX,TIMES[BX]
            CALL   pthis
            
            DB  13, 10, 'TIME TAKEN ', 0
            
            
            CALL   print_num     ; print number in AX.
            INC BX
            INC BX
            DEC DX
            CMP DX,0
            JNZ PRINT_TIMES

        

      
    EXIT: 
        MOV AH, 04CH 
        INT 21H
        
    DEFINE_SCAN_NUM
    DEFINE_PRINT_STRING
    DEFINE_PRINT_NUM
    DEFINE_PRINT_NUM_UNS  ; required for print_num.
    DEFINE_PTHIS 
    END MAIN     