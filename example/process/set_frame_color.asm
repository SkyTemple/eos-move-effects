; 
; ------------------------------------------------------------------------------
; Set Frame Color
; Set the color of the frame to the one specified in first parameter
; Param 1: border_color (0 for blue/male, 1 for pink/female)
; Returns: nothing
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x810

; For US
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel ChangeGlobalBorderColor, 0x02027A80

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7A80
;.definelabel ProcJumpAddress, 0x022E7B88
;.definelabel ChangeGlobalBorderColor, 0x02027D74


; File creation
.create "./code_out.bin", 0x022E7248 ; Change to the actual offset as this directive doesn't accept labels
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area
		mov r0,r7
		bl ChangeGlobalBorderColor
		
		b ProcJumpAddress
		.pool
	.endarea
.close
