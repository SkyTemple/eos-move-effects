; 
; ------------------------------------------------------------------------------
; Sets a predefined name
; See Remove Party if you are using this on current party members
; Param 1: ent_id
; Returns: nothing
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm

; TODO: Currently only for the US

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
		ldr r1,=0x020B0A48
		ldr r1,[r1]
		mov r2,#0x44
		mla r1,r7,r2,r1
		add r0,r1,#0x3A
		ldr r1,=new_name
		mov r2,#10
		bl StrNCpy
		b ProcJumpAddress
		.pool
	new_name: ;Choose a name
		.ascii "NmW10Chars",0
	.endarea
.close
