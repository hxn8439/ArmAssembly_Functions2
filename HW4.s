.global sumF32
.global prodF64
.global dotpF64
.global maxF32

.text

/*sumF32(const float x[], uint32_t count) */

sumF32:
	PUSH {R4} // PUSH R4 TO USE REGISTER
	MOV R4, #0 //STORE ZERO IN R4
	VMOV S0, R4 //VECTOR MOVE DATA FROM R4 TO A SINGLE PRECISION REGISTER S0
	
sumF32_loop_1:
	CMP R1, #0 // COMPARE R1 TO VALUE 0 
	BEQ sumF32_return //CONDITIONAL, IF EQUAL BRANCH TO SUMF32_RETURN.
	VLDR.F32 S1, [R0] //VECTOR LOAD REGISTER R0 TO SINGLE PRECISION S0 
	VADD.F32 S0, S0, S1 //VECTOR ADD SINGLE PRECISION S0 TO S0 AND STORE RESULT IN S0
	ADD R0, R0, #4 //ADD 4 TO R0 AND STORE RESULTS IN RO, THIS IS INCREMENT TO NEXT ELEMENT SPECIFICALLY FOR A FLOAT DATA
	SUB R1, R1, #1 //SUBTRACT 1 FROM R1 AND STOR BACK IN R1, THIS IS DECREMENT FOR COUNTER
	B sumF32_loop_1 //BRANCH THE LOOP
	
sumF32_return: //RETURN FUNCTION
	POP {R4} //POP REGISTER R4
	VMOV R0, S0 //VECTOR MOVE DATA FROM S0 TO R0, ONLY R0 IS USED SINCE ITS A 32 BIT REGISTER
	BX LR //BRANCH AND RETURN DATA 
	
/* prodF64(const double x[], uint32_t count) */	

prodF64:
	PUSH {R4} // PUSH R4 TO USE REGISTER
    MOV R4, #0       //SET R4 REGISTER TO VALUE ZERO
    VMOV D0, R4, R4  //MOVE DATA R4 TO DOUBLE PRECISION REGISTER R0, USE TO SET ZERO IN DOUBLE PRECISION REGISTER
    VMOV D1, R4, R4  //MOVE DATA R4 TO DOUBLE PRECISION REGISTER R1, USE TO SET ZERO IN DOUBLE PRECISION REGISTER 
    VLDR.F64 D0, [R0]//VECTOR LOAD REGISTER FROM FIRST ELEMENT IN DOUBLE ARRAY OF R0 TO REGISTER D1.
    ADD R0,R0, #8    //ADD VALUE 8 TO REGISTER R0, STORE BACK INTO R0, THIS INCREMENT THE NEXT ARRAY FOR A 64BIT
    SUB R1, R1, #1   //SUBTRACT 1 FROM R1 AND STOR BACK IN R1, THIS IS DECREMENT FOR COUNTER
    B prodF64_loop_1 //BRANCH THE LOOP

prodF64_loop_1:
    CMP R1, #0       //COMPARE R1 TO VALUE 0 
    BEQ prodF64_return  //CONDITIONAL, IF EQUAL BRANCH TO PRODF64_RETURN
    VLDR.F64 D1, [R0]//LOAD REGISTER FROM R0 TO DOUBLE PRESCISON REGISTER D1 
    ADD R0,R0, #8  //INCREMENT TO NEXT ELEMENT IN R0 BY ADD VALUE 8 TO REGISTER R0
    VMUL.F64 D0, D0, D1    //VECTOR MULTIPLY D0 & D1 REGISTERS AND STORE INTO D0
    SUB R1, R1, #1        //SUBTRACT 1 FROM R1 AND STORE BACK IN R1, THIS IS DECREMENT FOR COUNTER
    B prodF64_loop_1         //BRANCH THE LOOP

prodF64_return:
	POP {R4} //POP REGISTER R4
    VMOV R0, R1, D0 //VECTOR MOVE DATA FROM D0 TO R0, R0 AND r1 IS USED SINCE ITS A COMBINE 64 BIT REGISTERS
    BX LR //BRANCH AND RETURN DATA
	

/* dotpF64(const double x[], const double y[], uint32_t count)*/

dotpF64:
	PUSH {R4} // PUSH R4 TO USE REGISTER
	MOV R4, #0 //STORE ZERO IN R4
	VMOV D0, R4, R4 //MOVE DATA R4 TO DOUBLE PRECISION REGISTER R0, USE TO SET ZERO IN DOUBLE PRECISION REGISTER
	VMOV D1, R4, R4 //MOVE DATA R4 TO DOUBLE PRECISION REGISTER R1, USE TO SET ZERO IN DOUBLE PRECISION REGISTER
	VMOV D2, R4, R4 //MOVE DATA R4 TO DOUBLE PRECISION REGISTER R2, USE TO SET ZERO IN DOUBLE PRECISION REGISTER
	VMOV D3, R4, R4 //MOVE DATA R4 TO DOUBLE PRECISION REGISTER R3, USE TO SET ZERO IN DOUBLE PRECISION REGISTER

dotpF64_loop_1:
	CMP R2, #0 //COMPARE R2 TO VALUE 0 
	BEQ dotpF64_return //CONDITIONAL, IF EQUAL BRANCH TO DOTPRODF64_RETURN
	VLDR.F64 D1, [R0] //LOAD REGISTER FROM R0 TO DOUBLE PRESCISON REGISTER D1 
	VLDR.F64 D2, [R1] //LOAD REGISTER FROM R1 TO DOUBLE PRESCISON REGISTER D2 
	VMUL.F64 D3, D1, D2 //VECTOR MULTIPLY D1, D2 AND STORE IN D3.
	VADD.F64 D0, D0, D3 //VECTOR ADD D3 TO D0 
	ADD R0, R0, #8 //ADD VALUE 8 TO REGISTER R0, STORE BACK INTO R0, THIS INCREMENT THE NEXT DOUBLE ARRAY FOR A 64BIT
	ADD R1, R1, #8 //ADD VALUE 8 TO REGISTER R1, STORE BACK INTO R1, THIS INCREMENT THE NEXT DOUBLE ARRAY FOR A 64BIT
	SUB R2, R2, #1 //SUBTRACT 1 FROM R2 AND STORE BACK IN R2, THIS IS DECREMENT FOR COUNTER
	B dotpF64_loop_1 //BRANCH THE LOOP

dotpF64_return:
	POP {R4} //POP REGISTER R4
	VMOV R0, R1, D0 //VECTOR MOVE DATA FROM D0 TO R0, R0 AND r1 IS USED SINCE ITS A COMBINE 64 BIT REGISTERS
	BX LR //BRANCH AND RETURN DATA


/* maxF32(const float x[], uint32_t count) */

maxF32:
	PUSH {R4, R5}  		//PUSH R4 TO USE REGISTER
	CMP R1, #0         //COMPARE R1 TO VALUE 0 
	BEQ maxF32_return //CONDITIONAL, IF EQUAL BRANCH TO maxF32_RETURN
	MOV R4, R0         // MOVE R0 DATA TO R4 REGISTER
	MOV R0, #0         // MOVE VALUE 0 TO R0 REGISTER
	MOV R5, #0         // MOVE VALUE 0 TO R5 REGISTER
	VMOV S0, R0       //MOVE DATA R0 TO S0, USE TO SET ZERO IN SINGLE PRECISION REGISTER
	VMOV S1, R0       //MOVE DATA R0 TO S1, USE TO SET ZERO IN SINGLE PRECISION REGISTER
	VMOV S2, R0       //MOVE DATA R0 TO S2, USE TO SET ZERO IN SINGLE PRECISION REGISTER
//	B maxF32_loop_1    BRANCH TO LOOP
	
maxF32_loop_1:
	CMP R1, #0         //COMPARE R2 TO VALUE 0 
	BEQ maxF32_return    //CONDITIONAL, IF EQUAL BRANCH maxF32_return
	VLDR.F32 S0, [R4]  //LOAD REGISTER FROM R4 TO SINGLE PRESCISON REGISTER S0
	ADD R4, R4, #4     //ADD VALUE 4 TO REGISTER R4, STORE BACK INTO R4, THIS INCREMENT THE NEXT FLOAT ARRAY FOR A 32BIT
	VLDR.F32 S1, [R4]  //LOAD REGISTER FROM R4 TO SINGLE PRESCISON REGISTER S1
	SUB R1, R1, #1     //SUBTRACT VALUE 1 FROM R1 AND STORE BACK IN R1, THIS IS DECREMENT FOR COUNTER
	VCMP.F32 S0, S1    // VECTOR COMPARE S0 TO S1 
	BMI maxF32_hit  //BRANCH IF NEGATIVE, WHEN (S1 > S0), BRANCH TO maxF32_HIT 
	B maxF32_loop_1      //BRANCH TO LOOP
	
maxF32_hit:
	VMOV R5, S1  //VECTOR MOVE S1 TO R5, IT UPDATES THE R5 REGISTER WITH GREATEST VALUE
	B maxF32_loop_1    //BRANCH TO LOOP
	
maxF32_return:
	POP {R4, R5}
	MOV R0, R5  //MOVE R5 TO R0 
	BX LR      //BRANCH AND RETURN DATA


