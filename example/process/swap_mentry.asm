; 
; ------------------------------------------------------------------------------
; Swap Monster Entry
; Swaps two monster data entries
; See Remove Party if you are using this on current party members
; Param 1: ent_id_1
; Param 2: ent_id_2
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
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400


; File creation
.create "./code_out.bin", 0x022E7248 ; Change to the actual offset as this directive doesn't accept labels
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area
		sub r13,r13,#0x44
		ldr r1,=0x020B0A48
		ldr r1,[r1]
		mov r0,r13
		mov r2,#0x44
		mla r1,r7,r2,r1
		bl 0x0200330C
		ldr r1,=0x020B0A48
		ldr r1,[r1]
		mov r2,#0x44
		mla r0,r7,r2,r1
		mla r1,r6,r2,r1
		bl 0x0200330C
		ldr r1,=0x020B0A48
		ldr r1,[r1]
		mov r2,#0x44
		mla r0,r6,r2,r1
		mov r1,r13
		bl 0x0200330C
		add r13,r13,#0x44
		
		b ProcJumpAddress
		.pool
	.endarea
.close
