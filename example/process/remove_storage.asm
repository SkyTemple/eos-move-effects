; 
; ------------------------------------------------------------------------------
; Remove Bag
; Remove storage items
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
		ldr r0,=0x020af6b8
		ldr r0,[r0]
		add r0,r0,#0x8A
		add r0,r0,#0x300
		mov r1,#0x7D0
		bl 0x0200326C
		b ProcJumpAddress
		.pool
	.endarea
.close
