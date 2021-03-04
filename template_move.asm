; 
; ------------------------------------------------------------------------------
; A template to code your own move effects
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x2598

; Uncomment the correct version

; For US
;.include "lib/stdlib_us.asm"
;.include "lib/dunlib_us.asm"
;.definelabel MoveStartAddress, 0x02330134
;.definelabel MoveJumpAddress, 0x023326CC

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C


; File creation
.create "./code_out.bin", MoveStartAddress ; Change to the actual offset as this directive doesn't accept labels
	.org MoveStartAddress
	.area MaxSize ; Define the size of the area
		; Usable Variables: 
		; r6 = Move ID
		; r9 = User Monster Structure Pointer
		; r4 = Target Monster Structure Pointer
		; r8 = Move Data Structure Pointer (8 bytes: flags [4 bytes], move_id [2 bytes], pp_left [1 byte], boosts [1 byte])
		; r7 = ID of the item that called this move (0 if the move effect isn't from an item)
		; Returns: 
		; r10 (bool) = ???
		; Registers r4 to r9, r11 and r13 must remain unchanged after the execution of that code
		
		
		; Code here
		
		; Always branch at the end
		b MoveJumpAddress
		.pool
	.endarea
.close
