; 
; ------------------------------------------------------------------------------
; A template to code your own move effects
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x2598

; Uncomment the correct version

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
		
		stmdb r13!,{r4,r5}
		sub r13,r13,#0x10
		
		mvn r4,#1
	outer_loop:
		mvn r5,#1
	inner_loop:
		ldrh r0,[r9,#+0x4]
		ldrh r1,[r9,#+0x6]
		add r0,r0,r4
		add r1,r1,r5
		strh r0, [r13,#+0xA]
		strh r1, [r13,#+0xC]
		mov r0,#64
		strh r0, [r13,#+0x8]
		mov r0,#0
		strh r0, [r13,#+0x4]
		mov r0,#0xA
		strh r0, [r13,#+0x2]
		ldr r0,[r9,#+0xB4]
		ldrh r0,[r0,#+0x2]
		strh r0, [r13]
		
		mov r0,r13
		mov r1,#1
		bl 0x022FD084
		
		add r5,r5,#1
		cmp r5,#3
		blt inner_loop
		add r4,r4,#1
		cmp r4,#3
		blt outer_loop
		
		add r13,r13,#0x10
		ldmia r13!,{r4,r5}
		
		; Always branch at the end
		b MoveJumpAddress
		.pool
	.endarea
.close
