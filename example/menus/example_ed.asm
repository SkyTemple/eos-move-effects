; 
; ------------------------------------------------------------------------------
; A template to code your own Menus (part 2)
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x3C0

; Uncomment the correct version

; For US
.include "lib/stdlib_us.asm"
.definelabel MenuEdStartAddress, 0x022E6A2C
.definelabel MenuEdJumpAddress, 0x022E6E58

.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcMaxSize, 0x810

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel MenuEdStartAddress, 0x0
;.definelabel MenuEdJumpAddress, 0x0


; File creation
.create "./code_out.bin", 0x022E6A2C ; Change to the actual offset as this directive doesn't accept labels
	.org MenuEdStartAddress
	.area MaxSize ; Define the size of the area
		; Usable Variables: 
		; Registers r4 to r11 and r13 must remain unchanged after the execution of that code
		
		
		; Code here
		
		ldr r0, =0x02324C9C
		ldrb r0, [r0]
		cmp r0, #0
		beq set_str
		ldr r1, =0x02324F94
		mov r0, #1
		ldr r1, [r1]
		str r1, [r6]
		b MenuEdJumpAddress
	set_str:
		stmdb r13!, {r4,r5}
		ldr r5,=ProcStartAddress+ProcMaxSize-4
		ldr r5,[r5]
		ldr r1,=0x020B0A48
		ldr r1,[r1]
		mov r2,#0x44
		mla r4,r5,r2,r1
		add r0,r4,#0x3A
		ldr r1,=0x020AFDF0
		ldr r1,[r1]
		add r1,r1,#0xFC
		mov r2,#10
		bl StrNCpy
		mov r0,r5
		bl 0x020563BC
		bl 0x0205638C
		cmp r0,#0
		beq no_team
		add r0,r0,#0x5E
		add r1,r4,#0x3A
		mov r2,#10
		bl StrNCpy
	no_team:
		mov r0,#0
		ldmia r13!, {r4,r5}
		; Always branch at the end
		b MenuEdJumpAddress
		.pool
	.endarea
.close
