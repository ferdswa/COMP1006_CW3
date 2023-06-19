        B main

value   DEFW 0 ; Store the read number here
enterI  DEFB "Please enter your integer: ",0
newline DEFB "\n",0
errorM  DEFB "\nYou have entered a character instead of an integer!\n",0

        ALIGN
main    
        MOV R5,#10
        MOV R7,#0
        ADR R0,enterI
        SWI 3
        B ibc
intbuilder
        SWI 4
        MLA R0,R7,R5,R0
        MOV R7,R0
ibc
        SWI 1
        CMP R0,#10
        BEQ finished
        CMP R0,#48
        BLT error
        SUB R0,R0,#48
        CMP R0,#10
        BGE error
        B intbuilder
error
        ADR R0,errorM
        SWI 3
        B main
finished
        STR R7,value
        ADR R0,newline
        SWI 3
        LDR R0,value
        SWI 4
        SWI 2