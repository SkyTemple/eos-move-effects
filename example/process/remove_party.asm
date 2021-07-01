; 
; ------------------------------------------------------------------------------
; Remove Party
; Remove all party members
; Must be called before any process that involves messing
; with current team members
; Don't forget to call a process that sets a default team afterwards
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
		stmdb  r13!,{r9,r10}
		ldr r1,=0x020B0A48
		ldr r1,[r1]
		add  r0,r1,#0x9000
		ldr r9,[r0, #+0x84c]
		mov r10,#0
		mov r0,#0
	loop_beg_erase:
		strb r0,[r9, #+0x0]
		add  r10,r10,#0x1
		cmp r10,#0x4
		add r9,r9,#0x68
		blt loop_beg_erase
		ldmia  r13!,{r9,r10}
		b ProcJumpAddress
		.pool
	.endarea
.close
