; 324888155, 50%
; 209632108, 50%
.ORIG X4064
Div: ;R3=R0%R1   R2=R0/R1
ST R4, R4_SAVE_DIV
ST R5, R5_SAVE_DIV
ST R6, R6_SAVE_DIV ;were using the R6 as a flag
ST R7, R7_SAVE_DIV

ADD R6,R6,#1
AND R3,R3,#0 ;R3=R0%R1

ADD R4, R4, R0
    BRzp IF_R4_NOTNEGATIVE_DIV
NOT R4,R4 ;R0 NEGATIVVVVE
ADD R4,R4,#1 ;CHANGE IT TO POSITIVE
NOT R6,R6 ;R6= -R6 (with next line)
ADD R6,R6,#1 ; :)
    IF_R4_NOTNEGATIVE_DIV:
ADD R5, R5, R1
    BRz IF_R5_ZERO_ERROR_DIV
    BRp IF_R5_POSITIVE_DIV
NOT R6,R6 ;R6= -R6 (with next line)
ADD R6,R6,#1 ; :)
BR R5_ALREADY_N_DIV
    IF_R5_POSITIVE_DIV:

NOT R5,R5 ;R1 POSITIVE
ADD R5,R5,#1 ;CHANGE IT TO NEGATIVE
R5_ALREADY_N_DIV:
AND R2,R2,#0    ;we know that we have to put it at the first line but if there is two ":" in a row we get an error ;btw R2= R0/R1
    LOOP_DIV:
    ADD R2,R2,#1 ;we use it like a counter
    ADD R4,R4,R5    ;R4=R4-R5
    BRzp LOOP_DIV
ADD R2,R2,#-1 ; there is extra 1 :)
NOT R5,R5 ;R1 NEGATIVE
ADD R5,R5,#1 ;CHANGE IT TO POSITIVE
ADD R3,R4,R5 ;R3=R4+R5
ADD R6,R6,#0
    BRp R6_IS_POSITIVE
NOT R2,R2 ;R2 POSITIVE
ADD R2,R2,#1 ;CHANGE IT TO NEGATIVE
    R6_IS_POSITIVE:
    BR FINISH_DIV ;its not an error
    IF_R5_ZERO_ERROR_DIV:
    LD R2, MINUS_1_DIV ;puts -1 in R2
    LD R3, MINUS_1_DIV ;puts -1 in R3
    FINISH_DIV:
LD R4, R4_SAVE_DIV
LD R5, R5_SAVE_DIV
LD R6, R6_SAVE_DIV
LD R7, R7_SAVE_DIV
RET

MINUS_1_DIV .fill #-1
R4_SAVE_DIV .fill #0
R5_SAVE_DIV .fill #0
R6_SAVE_DIV .fill #0
R7_SAVE_DIV .fill #0
.END