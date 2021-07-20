; 
; ------------------------------------------------------------------------------
; A template to code your own Menus
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x63C

; Uncomment the correct version

; For US
.include "lib/stdlib_us.asm"
.definelabel MenuStartAddress, 0x022E6228
.definelabel MenuJumpAddress, 0x022E68AC

.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcMaxSize, 0x810

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel MenuStartAddress, 0x0
;.definelabel MenuJumpAddress, 0x0


; File creation
.create "./code_out.bin", 0x022E6228 ; Change to the actual offset as this directive doesn't accept labels
	.org MenuStartAddress
	.area MaxSize ; Define the size of the area
		; Usable Variables: 
		; Registers r4 to r11 and r13 must remain unchanged after the execution of that code
		
		
		; Code here
		ldr r3,=ProcStartAddress+ProcMaxSize-4
		ldr r3,[r3]
		ldr r1,=0x020B0A48
		ldr r1,[r1]
		mov r2,#0x44
		mla r1,r3,r2,r1
		add r1,r1,#0x3A
		ldr r0,=string
		mov r2,#10
		bl StrNCpy
		mov r0, #2
		ldr r1,=string
		mov r2, r1
		bl #0x20367b4
		
		; Always branch at the end
		b MenuJumpAddress
		.pool
	string:
		.fill 0xC, 0x0
	.endarea
.close
