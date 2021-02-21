; 
; ------------------------------------------------------------------------------
; Deal Damage Cringe
; A move effect which consists in a normal damaging move followed by 20% chance of target cringing
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x2598

; Uncomment the correct version

; For US
.include "lib/stdlib_us.asm"
.include "lib/dunlib_us.asm"
.definelabel MoveStartAddress, 0x02330134
.definelabel MoveJumpAddress, 0x023326CC

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C


; Don't forget to change the offset for the EU version
.create "./deal_damage.bin", 0x02330134 ;Always loaded at this offset
	.org MoveStartAddress
	.area MaxSize ; Define the size of the area
		sub r13,r13,#0x40
		str r7, [r13]
		mov r0, r9
		mov r1, r4
		mov r2, r8
		mov r3, #0x100
		bl DealDamage
		cmp r0, #0x0 ; Compare if the move damaged the opponent
		beq end
		mov r0, r9
		mov r1, r4
		mov r2, #20 ; 20% chance of cringing
		bl RandomChanceUT
		cmp r0, #0x0 ; Compare if the chance passed
		beq end
		mov r0, r9
		mov r1, r4
		mov r2, #1
		mov r3, #0
		bl Cringe
	end:
		add r13,r13,#0x40
		mov r10, #1
		b MoveJumpAddress
		.pool
	.endarea
.close
