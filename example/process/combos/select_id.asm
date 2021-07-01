; 
; ------------------------------------------------------------------------------
; Select Entry ID
; An example of combo processes
; Selects an entry for further manipulations
; Note: Combo processes must be called immediately one after the other
; Param 1: ent_id
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

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7A80
;.definelabel ProcJumpAddress, 0x022E7B88


; File creation
.create "./code_out.bin", 0x022E7248 ; Change to the actual offset as this directive doesn't accept labels
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area
		ldr r0,=MaxSize-4 ; Common Value
		str r7,[r0]
		b ProcJumpAddress
		.pool
	.endarea
.close
