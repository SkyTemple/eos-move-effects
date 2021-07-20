; 
; ------------------------------------------------------------------------------
; Heals the team outside of dungeons
; Returns: nothing
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x810

; Uncomment the correct version

; For US
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel RefillTeam, 0x02057D58

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7A80
;.definelabel ProcJumpAddress, 0x022E7B88
;.definelabel RefillTeam, 0x020580D4


; File creation
.create "./code_out.bin", 0x022E7248 ; Change to the actual offset as this directive doesn't accept labels
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area
		; Usable Variables: 
		; r7 = First Argument
		; r6 = Second Argument
		; Returns: 
		; r0 = User Defined Value
		; Registers r4 to r11 and r13 must remain unchanged after the execution of that code
		
		
		; Code here
		
		bl RefillTeam
		
		; Always branch at the end
		b ProcJumpAddress
		.pool
	.endarea
.close
