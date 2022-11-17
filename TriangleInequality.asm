; 324888155, 50%
; 209632108, 50%
.ORIG X4190
TriangleInequality: 

ST R4, R4_SAVE_TRI
ST R5, R5_SAVE_TRI
ST R6, R6_SAVE_TRI 
ST R7, R7_SAVE_TRI
AND R3 ,R3 ,#0

; negativity check ;
ADD R0 ,R0 ,#0
BRn NEGATIVE_ERROR_TRI
ADD R1 ,R1, #0
BRn NEGATIVE_ERROR_TRI
ADD R2 ,R2,#0
BRn NEGATIVE_ERROR_TRI
; ends here ;

ADD R4, R0 ,#0
NOT R4,R4
ADD R4 ,R4,#1  ; R4= -R0

ADD R7, R1,R2
ADD R7,R7, R4 ;R7= R1+R2 +R4
BRn DONE_TRI ;there is error R1+R2 < R0


ADD R5, R1 ,#0
NOT R5,R5
ADD R5 ,R5,#1  ; R5= -R1

ADD R7, R0, R2
ADD R7,R7, R5 ;R7= R0+R2 +R5
BRn DONE_TRI ;there is error R0+R2 < R1


ADD R6, R2 ,#0
NOT R6,R6
ADD R6 ,R6,#1  ; R6= -R1

ADD R7, R0, R1
ADD R7,R7, R6 ;R7= R0+R1 +R6
BRn DONE_TRI ;there is error R0+R1 < R2

;if all good we get to here;
ADD R3, R3,#1
BR DONE_TRI

NEGATIVE_ERROR_TRI:
ADD R3,R3,#-1

DONE_TRI:


LD R4, R4_SAVE_TRI
LD R5, R5_SAVE_TRI
LD R6, R6_SAVE_TRI
LD R7, R7_SAVE_TRI

RET

R4_SAVE_TRI .fill #0
R5_SAVE_TRI .fill #0
R6_SAVE_TRI .fill #0
R7_SAVE_TRI .fill #0
	

.END