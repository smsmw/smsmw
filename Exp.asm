; 324888155, 50%
; 209632108, 50%
.ORIG X40C8
Exp: ;R2 = R0^R1
ST R3, R3_SAVE_EXP
ST R4, R4_SAVE_EXP
ST R5, R5_SAVE_EXP
ST R6, R6_SAVE_EXP
ST R7, R7_SAVE_EXP

ADD R5,R1,#0
AND R2,R2,#0
ADD R4,R0,#0

    BRnp R4_IS_NOT_ZERO_EXP  ;the first check (1)
    ADD R5,R5,#0
    BRnz R5_IS_NOT_POSITIZE_EXP
    R4_IS_NOT_ZERO_EXP:      ; ends here (1)
    ADD R5,R5,#0
    BRn R5_IS_NEGATIVE_EXP ;the second check (2)
    ADD R4,R4,#0
    BRn R4_IS_NEGATIVE_EXP ;ends here (2)

LD R1, R1_SAVE_EXP

AND R1, R1,#0 ;change R1 to R0
ADD R1,R0,#0 ;so we can use the Mul
LD R3 ,Mul_PTR ;R3=x4000


    ADD R5,R5,#-1 
    BRz IF_R5_Z
    ADD R5,R5,#0
    BRn IF_R5_N

    LOOP_EXP:  ; multiplies R0 with itself R1 times
    JSRR R3  ;PC=R3
    AND R0,R0,#0
    ADD R0,R2,#0 ;R0=R2
    ADD R5,R5,#-1
    BRp LOOP_EXP
    BR SKIP_ZERO_ONE_EXP

    IF_R5_Z:
    ADD R2,R0,#0
    BR SKIP_ZERO_EXP
    IF_R5_N:
    ADD R2,R2,#1
    SKIP_ZERO_EXP:
    ADD R2,R2,#0
    SKIP_ZERO_ONE_EXP:

ST R1, R1_SAVE_EXP

BR SKIP_ERRORS_EXP

    R4_IS_NEGATIVE_EXP:
    ADD R2,R2,#0
    R5_IS_NEGATIVE_EXP:
    ADD R2,R2,#0
    R5_IS_NOT_POSITIZE_EXP:
    ADD R2,R2,#-1

SKIP_ERRORS_EXP:
LD R3, R3_SAVE_EXP
LD R4, R4_SAVE_EXP
LD R5, R4_SAVE_EXP
LD R6, R4_SAVE_EXP
LD R7, R4_SAVE_EXP
RET

R0_SAVE_EXP .fill #0
R1_SAVE_EXP .fill #0
R3_SAVE_EXP .fill #0
R4_SAVE_EXP .fill #0
R5_SAVE_EXP .fill #0
R6_SAVE_EXP .fill #0
R7_SAVE_EXP .fill #0
Mul_PTR .FILL x4000
.END