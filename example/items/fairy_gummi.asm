; 
; ------------------------------------------------------------------------------
; 
; A Fairy-type specialized gummi
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0xCC4

; Uncomment the correct version

; For US
.include "lib/stdlib_us.asm"
.include "lib/dunlib_us.asm"
.definelabel ItemStartAddress, 0x0231BE50
.definelabel ItemJumpAddress, 0x0231CB14

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel ItemStartAddress, 0x0231C8B0
;.definelabel ItemJumpAddress, 0x0231D574


; File creation
.create "./fairy_gummi.bin", 0x0231BE50 ; Change to the actual offset as this directive doesn't accept labels
	.org ItemStartAddress
	.area MaxSize ; Define the size of the area
		mov r0, r8
		mov r3, #1
		mov r1, r7
		mov r2, #0x12 ; Needs to implement the AddTypes patch
		bl ProcessGummiType

		; Always branch at the end
		b ItemJumpAddress
		.pool
	.endarea
.close
