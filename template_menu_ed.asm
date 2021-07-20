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
;.include "lib/stdlib_us.asm"
;.definelabel MenuEdStartAddress, 0x022E6A2C
;.definelabel MenuEdJumpAddress, 0x022E6E58

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel MenuEdStartAddress, 0x0
;.definelabel MenuEdJumpAddress, 0x0


; File creation
.create "./code_out.bin", MenuEdStartAddress ; Change to the actual offset as this directive doesn't accept labels
	.org MenuEdStartAddress
	.area MaxSize ; Define the size of the area
		; Usable Variables: 
		; Registers r4 to r11 and r13 must remain unchanged after the execution of that code
		
		
		; Code here
		
		; Always branch at the end
		b MenuEdJumpAddress
		.pool
	.endarea
.close
