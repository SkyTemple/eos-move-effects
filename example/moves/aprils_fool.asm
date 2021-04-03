; 
; ------------------------------------------------------------------------------
; Speeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeen
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

; TODO: Currently only for the US version
.definelabel ChangeMusic, 0x022EAE14
.definelabel CopyArray, 0x0200330C
.definelabel IsDefinedPointer, 0x02325620
.definelabel WaitOneFrame, 0x022E9FE0
.definelabel EditAnimAttributes, 0x023049A8

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C


; File creation
.create "./aprils_fool.bin", 0x02330134 ; Change to the actual offset as this directive doesn't accept labels
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
		
		stmdb r13!,{r5,r6,r7}
		ldr r1,=DungeonBaseStructurePtr
		ldr r1,[r1]
		ldr r2,=0x2cb06
		ldrh r10,[r1,r2]
		mvn r0, #0
		bl ChangeMusic
		
		ldr r0,=save_colvec
		ldr r2,=DungeonBaseStructurePtr
		ldr r2,[r2]
		add r1,r2,#0x1e0
		mov r2, #0x400
		bl CopyArray
		
		sub r13,r13,#0x64
		
		mov  r6,#0x0
	save_loop:
		ldr r0,=DungeonBaseStructurePtr
		ldr r0,[r0]
		add  r0,r0,r6,lsl #0x2
		add  r0,r0,#0x12000
		ldr r7,[r0, #+0xb78]
		mov  r0,r7
		bl IsDefinedPointer
		cmp r0,#0x0
		beq end_save
		ldrb r0,[r7,#+0xb0]
		ldr r1,=save_directions
		strb r0,[r1,r6]
	end_save:
		add  r6,r6,#0x1
		cmp r6,#0x14
		blt save_loop
		
		mov  r5,#0x0
		b chk_fade
	
	beg_fade:
		mov  r0,#0x42
		bl WaitOneFrame
		mov r1,0x1e0
		ldr r2,=DungeonBaseStructurePtr
		ldr r2,[r2]
	inner_loop_fade:
		ldrb r0,[r2,r1]
		subs r0,r0,#3
		movlt r0,#0
		strb r0,[r2,r1]
		add r1,r1,#1
		cmp r1,0x5e0
		blt inner_loop_fade
	chk_fade:
		add r5,r5,#1
		cmp r5,#80
		moveq r0, #1
		bleq ChangeMusic
		cmp r5,#100
		blt beg_fade
		
		
		mov  r5,#0x0
	beg_loop:
		mov  r6,#0x0
	speen_loop:
		ldr r0,=DungeonBaseStructurePtr
		ldr r0,[r0]
		add  r0,r0,r6,lsl #0x2
		add  r0,r0,#0x12000
		ldr r7,[r0, #+0xb78]
		mov  r0,r7
		bl IsDefinedPointer
		cmp r0,#0x0
		beq end_speen
		mov r0,r7
		mov r1,#0xC
		mov r2,r5,lsr 0x2
		add r2,r2,r6
		and r2,r2,#0x7
		rsb r2,r2,#0x7
		bl EditAnimAttributes
	end_speen:
		add  r6,r6,#0x1
		cmp r6,#0x14
		blt speen_loop
		
		mov  r0,#0x42
		bl WaitOneFrame
		
		mov r6,r5
		cmp r6,#0x200
		bge part2
	part1:
		cmp r6,#0x40
		movlt r6,#0
		blt set_color1
		cmp r6,#0x50
		sublt r6,r6,#0x40
		movlt r6,r6,lsl 0x4
		blt set_color1
		rsbs r6,r6,#0x1C0
		movls r6,#0
		ldr r0,=0xB21
		mul r6,r0,r6
		mov r6,r6,lsr #0xC
		b set_color1
	part2:
		sub r6,r6,#0x200
		cmp r6,#0x170
		bge part3
		cmp r6,#0x10
		movlt r6,r6,lsl 0x4
		blt set_color2
		rsbs r6,r6,#0x130
		movls r6,#0
		ldr r0,=0xE38
		mul r6,r0,r6
		mov r6,r6,lsr #0xC
		b set_color2
	part3:
		sub r6,r6,#0x170
		cmp r6,#0x5
		movlt r6, #0
		blt set_color3
		sub r6,r6,#0x5
		cmp r6,#0x10
		movlt r6,r6,lsl 0x4
		blt set_color3
		cmp r6, #0x35
		bge part3_1
		rsbs r6,r6,#0x30
		movls r6,#0
		mov r6,r6,lsl 0x3
		b set_color3
	part3_1:
		sub r6,r6,#0x35
		cmp r6,#0x10
		movlt r6,r6,lsl 0x4
		blt set_color3
		cmp r6, #0x40
		bge part4
		rsbs r6,r6,#0x30
		movls r6,#0
		mov r6,r6,lsl 0x3
		b set_color3
	part4:
		sub r6,r6,#0x40
		cmp r6,#0x10
		movlt r6,r6,lsl 0x4
		blt set_color4
		cmp r6, #0x35
		bge part4_1
		rsbs r6,r6,#0x30
		movls r6,#0
		mov r6,r6,lsl 0x3
		b set_color4
	part4_1:
		sub r6,r6,#0x35
		cmp r6,#0x10
		movlt r6,r6,lsl 0x4
		blt set_color4
		cmp r6, #0x32
		bge part5
		rsbs r6,r6,#0x30
		movls r6,#0
		mov r6,r6,lsl 0x3
		b set_color4
	part5:
		sub r6,r6,#0x32
		cmp r6,#0x10
		movlt r6,r6,lsl 0x4
		blt set_color5
		cmp r6, #0x35
		bge part5_1
		rsbs r6,r6,#0x30
		movls r6,#0
		mov r6,r6,lsl 0x3
		b set_color5
	part5_1:
		sub r6,r6,#0x35
		cmp r6, #0xA0
		bge part6
		and r6, r6, #0x1F
		cmp r6,#0x10
		movlt r6,r6,lsl 0x4
		blt set_color5
		rsbs r6,r6,#0x20
		movls r6,#0
		mov r6,r6,lsl 0x4
		b set_color5
	part6:
		subs r6,r6,#0xB0
		movls r6,#0
		cmp r6,#0x10
		movlt r6,r6,lsl 0x4
		blt set_color6
		cmp r6, #0x35
		bge part6_1
		rsbs r6,r6,#0x30
		movls r6,#0
		mov r6,r6,lsl 0x3
		b set_color6
	part6_1:
		sub r6,r6,#0x35
		cmp r6,#0x10
		movlt r6,r6,lsl 0x4
		blt set_color6
		cmp r6, #0x32
		bge part7
		rsbs r6,r6,#0x30
		movls r6,#0
		mov r6,r6,lsl 0x3
		b set_color6
	part7:
		subs r6,r6,#0x32
		movls r6,#0
		cmp r6,#0x10
		movlt r6,r6,lsl 0x4
		blt set_color7
		cmp r6, #0x35
		bge part7_1
		rsbs r6,r6,#0x30
		movls r6,#0
		mov r6,r6,lsl 0x3
		b set_color7
	part7_1:
		sub r6,r6,#0x35
		cmp r6,#0x10
		movlt r6,r6,lsl 0x4
		blt set_color7
		cmp r6, #0x33
		bge part8
		rsbs r6,r6,#0x30
		movls r6,#0
		mov r6,r6,lsl 0x3
		b set_color7
	part8:
		sub r6,r6,#0x33
		cmp r6,#0x10
		movlt r6,r6,lsl 0x4
		blt set_color8
		cmp r6, #0x33
		bge part8_1
		rsbs r6,r6,#0x30
		movls r6,#0
		mov r6,r6,lsl 0x3
		b set_color8
	part8_1:
		sub r6,r6,#0x33
		cmp r6, #0x100
		bge part9
		mov r0, r6, lsr #0x5
		and r6, r6, #0x1F
		cmp r6,#0x10
		movlt r6,r6,lsl 0x4
		blt choose_color_8
		rsbs r6,r6,#0x20
		movls r6,#0
		mov r6,r6,lsl 0x4
	choose_color_8:
		cmp r0,#8
		addls  r15,r15,r0,lsl #0x2
		b set_color9
		b set_color1
		b set_color2
		b set_color3
		b set_color4
		b set_color5
		b set_color6
		b set_color7
		b set_color8
	part9:
		sub r6,r6,#0x100
		cmp r6,#0x10
		movlt r6,r6,lsl 0x4
		blt set_color9
		rsbs r6,r6,#0x90
		movls r6,#0
		mov r6,r6,lsl #0x1
		b set_color9
	set_color1:
		mov r0,r6
		mov r1,r6,lsr #0x1
		mov r2,r6,lsr #0x1
		b next_frame
	set_color2:
		mov r0,r6,lsr #0x1
		mov r1,r6,lsr #0x1
		mov r2,r6
		b next_frame
	set_color3:
		mov r0,r6,lsr #0x1
		mov r1,r6
		mov r2,r6,lsr #0x1
		b next_frame
	set_color4:
		mov r0,r6
		mov r1,r6,lsr #0x1
		mov r2,r6
		b next_frame
	set_color5:
		mov r0,r6,lsr #0x1
		mov r1,r6
		mov r2,r6
		b next_frame
	set_color6:
		mov r0,r6
		mov r1,r6
		mov r2,r6,lsr #0x1
		b next_frame
	set_color7:
		add r0,r6,r6,lsr #0x1
		mov r0,r0,lsr #0x1
		mov r1,r6,lsr #0x2
		mov r2,r6,lsr #0x1
		b next_frame
	set_color8:
		add r0,r6,r6,lsr #0x1
		mov r0,r0,lsr #0x1
		mov r1,r6,lsr #0x1
		mov r2,r6,lsr #0x2
		b next_frame
	set_color9:
		mov r0,r6
		mov r1,r6
		mov r2,r6
		b next_frame
	next_frame:
		
		bl SetColor
		
		add  r5,r5,#0x1
		cmp r5,#0x800
		blt beg_loop
		
		mov r6,#0
	load_loop:
		ldr r0,=DungeonBaseStructurePtr
		ldr r0,[r0]
		add  r0,r0,r6,lsl #0x2
		add  r0,r0,#0x12000
		ldr r7,[r0, #+0xb78]
		mov  r0,r7
		bl IsDefinedPointer
		cmp r0,#0x0
		beq end_load
		ldr r1,=save_directions
		mov r0,r7
		ldrb r2,[r1,r6]
		mov r1,#0xC
		bl EditAnimAttributes
	end_load:
		add  r6,r6,#0x1
		cmp r6,#0x14
		blt load_loop
		
		
		mov r0, r9
		ldr r1, =str_e
		bl SendMessageWithStringLog
		
		ldr r1,=save_colvec
		ldr r2,=DungeonBaseStructurePtr
		ldr r2,[r2]
		add r0,r2,#0x1e0
		mov r2, #0x400
		bl CopyArray
		
		mov r0, r10
		bl ChangeMusic
	end:
		add r13,r13,#0x64
		ldmia r13!,{r5,r6,r7}
		mov r10,#1
		; Always branch at the end
		b MoveJumpAddress
	SetColor: ;r0: R, r1: G, r2: B
		stmdb r13!,{r4,r5,r6,r14}
		mov r4,r0
		mov r5,r1
		mov r6,r2
		mov r1,0x1e0
		ldr r2,=DungeonBaseStructurePtr
		ldr r2,[r2]
	inner_loop:
		and r0,r1,#0x3
		mov r3,#0
		cmp r0,#0
		moveq r3,r4
		cmp r0,#1
		moveq r3,r5
		cmp r0,#2
		moveq r3,r6
		sub r0,r1,#0x1e0
		mov r0,r0,lsr #0x2
		mul r0,r3,r0
		mov r0,r0,lsr #0x8
		strb r0,[r2,r1]
		add r1,r1,#1
		cmp r1,0x5e0
		blt inner_loop
		ldmia r13!,{r4,r5,r6,r15}
		.pool
	save_directions:
		.fill 0x14,0x0
	save_colvec:
		.fill 0x400,0x0
	str_e:
		.ascii "But nothing happened!"
		dcb 0
	.endarea
.close
