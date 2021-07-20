; 
; ------------------------------------------------------------------------------
; A special warping effect
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x2598

; Uncomment the correct version

; TODO: Currently only for US

; For US
.include "lib/stdlib_us.asm"
.include "lib/dunlib_us.asm"
.definelabel MoveStartAddress, 0x02330134
.definelabel MoveJumpAddress, 0x023326CC

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C

.definelabel WaitOneFrame, 0x022E9FE0

; File creation
.create "./code_out.bin", 0x02330134 ; Change to the actual offset as this directive doesn't accept labels
	.org MoveStartAddress
	.area MaxSize ; Define the size of the area
		; Usable Variables: 
		; r6 = Move ID
		; r9 = User Monster Structure Pointer
		; r4 = Target Monster Structure Pointer
		; r8 = Move Data Structure Pointer (8 bytes: flags [4 bytes], move_id [2 bytes], pp_left [1 byte], boosts [1 byte])
		; r7 = ID of the item that called this move (0 if the move effect isn't from an item)
		; Returns: 
		; r10 (bool) = ???
		; Registers r4 to r9, r11 and r13 must remain unchanged after the execution of that code
		
		; Code here
		
		sub r13,r13,#0x4
		
		stmdb r13!,{r4,r5}
		
		ldrh r4,[r9,#+0x4]
		ldrh r5,[r9,#+0x6]
		
		ldr r0,[r9,#+0xc]
		ldr r1,[r9,#+0x10]
		
		stmdb r13!,{r0,r1}
		
	loop:
		mov r0,#0x62
		bl WaitOneFrame
		ldr r0,=0x0237C694
		ldrh r1,[r0,#+0x2]
		tst r1,#0x10
		movne r1,#1
		movne r2,#0
		bne mp
		tst r1,#0x20
		mvnne r1,#0
		movne r2,#0
		bne mp
		tst r1,#0x40
		movne r1,#0
		mvnne r2,#0
		bne mp
		tst r1,#0x80
		movne r1,#0
		movne r2,#1
		beq no_mp
	mp:
		add r0,r4,r1
		cmp r0,#0
		blt no_mp
		cmp r0,#0x38
		bge no_mp
		add r0,r5,r2
		cmp r0,#0
		blt no_mp
		cmp r0,#0x20
		bge no_mp
		add r4,r4,r1
		add r5,r5,r2
		mov r0,r9
		mov r3,#24
		mul r1,r1,r3
		mul r2,r2,r3
		bl MovePlayer
	no_mp:
		ldr r0,=0x0237C694
		ldrh r1,[r0,#+0x2]
		tst r1,#0x1
		beq loop
		
		ldmia r13!,{r0,r1}
		
		str r0,[r9,#+0xc]
		str r1,[r9,#+0x10]
		
		mov r0,#0x62
		bl WaitOneFrame
		
		strh r4,[r13,#+0x8]
		strh r5,[r13,#+0xA]
		
		ldmia r13!,{r4,r5}
		
		mov r0,r9
		mov r1,r9
		mov r2,#3
		mov r3,r13
		bl 0x02320D08
		
		add r13,r13,#0x4
		; Always branch at the end
		b MoveJumpAddress
	MovePlayer:
		stmdb r13!,{r4,r5,r14}
		mov r4,r1
		mov r5,r2
		mov r3,#0x18
		ldr r1,[r9,#+0xc]
		ldr r2,[r9,#+0x10]
		add r1,r1,r4,lsl #0x8
		add r2,r2,r5,lsl #0x8
		bl 0x022E1A84
		ldmia r13!,{r4,r5,r15}
		.pool
	.endarea
.close
