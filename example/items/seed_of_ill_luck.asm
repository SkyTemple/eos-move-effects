; 
; ------------------------------------------------------------------------------
; Seed of Ill luck
; Implements seed of ill luck from Shiren 1 DS 
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0xCC4

; Uncomment the correct version

; For US
.include "lib/stdlib_us.asm"
.include "lib/dunlib_us.asm"
.definelabel ItemStartAddress, 0x0231BE50
.definelabel ItemJumpAddress, 0x0231CB14

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel ItemStartAddress, 0x0231C8B0
;.definelabel ItemJumpAddress, 0x0231D574


; File creation
.create "./code_out.bin", 0x0231BE50 ; Change to the actual offset as this directive doesn't accept labels
	.org ItemStartAddress
	.area MaxSize ; Define the size of the area
		
		; Heal all move's PP by 10 points
		mov r0,r8
		mov r1,r7
		mov r2,#100
		bl 0x02302F88
		
		stmdb r13!,{r4}
		ldr r4,[r7,#+0xb4]
		
		mov r0,#0
		str r0,[r4,#+0x20]
		mov r0,#1
		strh r0,[r4,#+0xe]
		strh r0,[r4,#+0x10]
		
		ldrh r0,[r4,#+0x2]
		bl 0x02052934
		strh r0,[r4,#+0x12]
		
		ldrh r0,[r4,#+0x2]
		mov r1,#0
		bl 0x020529C4
		strb r0,[r4,#+0x1a]
		ldrh r0,[r4,#+0x2]
		mov r1,#1
		bl 0x020529C4
		strb r0,[r4,#+0x1b]
		ldrh r0,[r4,#+0x2]
		mov r1,#0
		bl 0x020529E4
		strb r0,[r4,#+0x1c]
		ldrh r0,[r4,#+0x2]
		mov r1,#1
		bl 0x020529E4
		strb r0,[r4,#+0x1d]
		
		mov r0,#100
		add r4,r4,#0x140
		strh r0,[r4,#+0xA]
		mov r0,#0
		strh r0,[r4,#+0xC]
		ldrh r0,[r4,#+0x6]
		cmp r0,#100
		movge r0,#100
		strgeh r0,[r4,#+0x6]
		movge r0,#0
		strgeh r0,[r4,#+0x8]
		
		ldmia r13!,{r4}
		
		; Always branch at the end
		b ItemJumpAddress
		.pool
	.endarea
.close
