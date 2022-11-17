; 324888155, 50%
; 209632108, 50%
.ORIG X412C
CheckOverflow:	; 1 if there is overflow

ST R3, R3_SAVE_EXP
ST R4, R4_SAVE_EXP
ST R5, R5_SAVE_EXP

ADD R4,R1,#0
AND R2,R2,#0

ADD R3,R0,#0
BRp R3_isP_COF
BRn R3_isN_COF
BR R3_isZ_COF

R3_isP_COF:
ADD R4, R4, #0
BRnz R3p_R4nz
;R4 and R3 is P
ADD R5,R3,R4
BRp R5_isP_COF ;were good :)

BR R4p_R3p_R5n  ;overfloww

R3_isN_COF:
ADD R4, R4, #0
BRzp R3n_R4zp
;R4 and R3 is N
ADD R5,R3,R4
BRn R5_isN_COF ;were good :)

R4p_R3p_R5n:

ADD R2,R2,#1 ;OVERFLOWW :0 


R3n_R4zp
ADD R3,R3,#0 ;so we can use two CC in a row
R3p_R4nz
ADD R3,R3,#0 ;so we can use two CC in a row
R5_isN_COF
ADD R3,R3,#0 ;so we can use two CC in a row
R5_isP_COF
ADD R3,R3,#0 ;so we can use two CC in a row
R3_isZ_COF

RET
R3_SAVE_EXP .fill #0
R4_SAVE_EXP .fill #0
R5_SAVE_EXP .fill #0
.END