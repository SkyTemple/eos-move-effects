; 
; ------------------------------------------------------------------------------
; A template to code your own Menus
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x61C

; Uncomment the correct version

; For US
;.include "lib/stdlib_us.asm"
;.definelabel MenuStartAddress, 0x022E6228
;.definelabel MenuJumpAddress, 0x022E68AC

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel MenuStartAddress, 0x0
;.definelabel MenuJumpAddress, 0x0


; File creation
.create "./code_out.bin", MenuStartAddress ; Change to the actual offset as this directive doesn't accept labels
	.org MenuStartAddress
	.area MaxSize ; Define the size of the area
		; Usable Variables: 
		; Registers r4 to r11 and r13 must remain unchanged after the execution of that code
		
		
		; Code here
		
		; Always branch at the end
		b MenuJumpAddress
		.pool
	.endarea
.close
