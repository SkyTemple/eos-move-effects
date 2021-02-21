; 
; ------------------------------------------------------------------------------
; A template to code your own item effects
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0xCC4

; Uncomment the correct version

; For US
;.include "lib/stdlib_us.asm"
;.include "lib/dunlib_us.asm"
;.definelabel ItemStartAddress, 0x0231BE50
;.definelabel ItemJumpAddress, 0x0231CB14

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel ItemStartAddress, 0x0231C8B0
;.definelabel ItemJumpAddress, 0x0231D574


; File creation
.create "./code_out.bin", ItemStartAddress ; Change to the actual offset as this directive doesn't accept labels
	.org ItemStartAddress
	.area MaxSize ; Define the size of the area
		; Usable Variables: 
		; r9 (bool) = Thrown Item
		; r8 = User Monster Structure Pointer
		; r7 = Target Monster Structure Pointer
		; r6 = Item Data Structure Pointer (??? bytes: Unknown [4 bytes], item_id [2 bytes], ??? [??? bytes])
		; Registers r6 to r9, r11 and r13 must remain unchanged after the execution of that code
		
		; Code here
		
		; Always branch at the end
		b ItemJumpAddress
		.pool
	.endarea
.close
