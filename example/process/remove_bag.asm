; 
; ------------------------------------------------------------------------------
; Remove Bag
; Remove current bag items
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
		ldr r0,[r0, #+0x384]
		mov r1,#0x12C
		bl 0x02003288
		b ProcJumpAddress
		.pool
	.endarea
.close
