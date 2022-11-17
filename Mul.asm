; 324888155, 50%
; 209632108, 50%
.ORIG X4000
Mul: ;R2=R1*R0

ST R3, R3_SAVE_MUL
ST R4, R4_SAVE_MUL
ST R7, R7_SAVE_MUL
AND R2, R2, #0

ADD R3 ,R0 ,#0                        ;R3=R0
    BRz ZERO0_SKIP_MUL                ;IF R0=0 skip
ADD R4 ,R1 ,#0                        ;R4=R1
    BRz ZERO1_SKIP_MUL                ;IF R1=0 skip
    BRp IF_R1_NOT_NEGATIVE            ;IF R1 NOT NEGATIVE
NOT R4,R4                             ;R1 NEGATIVVVVE
ADD R4,R4,#1                          ;CHANGE IT TO POSITIVE
NOT R3,R3                             ;R3= -R3 (with next line)
ADD R3,R3,#1                          ; :)
    IF_R1_NOT_NEGATIVE:
    ADD R2 ,R2 ,#0
LOOP_MUL:                       ;puts R3 in R2 and Add R3 to itslf R2-1 times
    ADD R4 ,R4 ,#0
    BRnz END_LOOP_MUL
    ADD R2, R2, R3                   ;R2=R2+R3
    ADD R4, R4,#-1 
    BR LOOP_MUL

END_LOOP_MUL:
ADD R2 ,R2 ,#0
ZERO0_SKIP_MUL:
ADD R2 ,R2 ,#0
ZERO1_SKIP_MUL:

LD R3, R3_SAVE_MUL
LD R4, R4_SAVE_MUL
LD R7, R7_SAVE_MUL
RET
R3_SAVE_MUL .fill #0
R4_SAVE_MUL .fill #0
R7_SAVE_MUL .fill #0
.END