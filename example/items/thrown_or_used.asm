; 
; ------------------------------------------------------------------------------
; Thrown or used
; An effect to show the possibilities with thrown or used items
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
.create "./thrown_or_used.bin", 0x0231BE50 ; Change to the actual offset as this directive doesn't accept labels
	.org ItemStartAddress
	.area MaxSize ; Define the size of the area
		cmp r9, #0 ; Test if this was thrown or used
		beq no_throw ; Branch to no_throw if it was used
		; So it is possible to have an item that acts quite differently
		; depending on if it was thrown or used
	throw:
		mov r0,r8
		ldr r1,=thr_str
		bl SendMessageWithStringLog ; Shows threw
		b ItemJumpAddress
	no_throw:
		mov r0,r8
		ldr r1,=use_str
		bl SendMessageWithStringLog ; Shows used
		b ItemJumpAddress
		.pool
	thr_str: 
		.ascii "[string:0]: I threw this item!"
		dcb 0
	use_str:
		.ascii "[string:0]: I used this item!"
		dcb 0
	.endarea
.close
