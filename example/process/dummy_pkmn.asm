; 
; ------------------------------------------------------------------------------
; Dummy Monster
; Creates a Dummy Monster Entry
; Param 1: ent_id
; Returns: nothing
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x810

; TODO: Currently only US versions are supported

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
		mla r0,r7,r2,r1
		ldr r1,=dummy_entry
		bl 0x0200330C
		b ProcJumpAddress
	dummy_entry:
		.dcb 1
		.fill 0x39, 0x0
		.ascii "Name"
		.fill 0x6, 0x0
		.pool
	.endarea
.close
