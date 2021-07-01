; 
; ------------------------------------------------------------------------------
; Put Recruitable to Team
; Overwrites one entry in storage team (a.k.a. Assembly), 
; and does not use the recruitable list.
; See Remove Party if you are using this on current party members
; Param 1: pkmn_id
; Param 2: origin_id+pkmn_level*256 (NB: Hard to pass 3 parameters in 2 values)
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
		ldr r0,=MaxSize-4 ; Get From Common Value
		ldr r0,[r0]
		stmdb r13!, {r4}
		mov r4,r0
		mov r1,r7
		and r2,r6,#0xFF
		mov r3,#0
		bl 0x02055B78
		mov r0,r4
		bl 0x020555A8
		mov r4,r0
		mov  r1,r6,lsr #0x8
		mov  r2,#0x0
		bl 0x020544C8
		mov  r0,r4
		bl 0x02053568
		ldmia r13!, {r4}
		b ProcJumpAddress
		.pool
	.endarea
.close
