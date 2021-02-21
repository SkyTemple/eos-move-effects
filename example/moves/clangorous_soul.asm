; 
; ------------------------------------------------------------------------------
; Clangorous Soul
; A move effect similar to the effect of gen 8 move Clangorous Soul
; Raises all stats but deals 1/3 Max HP damage to the User
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
.create "./clangorous_soul.bin", 0x02330134 ;Always loaded at this offset
	.org MoveStartAddress
	.area MaxSize ; Define the size of the area
		sub r13,r13,#0x40
		mov r0, #1
		str r0, [r13]
		str r0, [r13, #+0x4]
		mov r0, r9
		mov r1, r9
		mov r2, #0
		mov r3, #2
		bl AttackStatUp ; Raise attack by 2 stages
		mov r0, #1
		str r0, [r13]
		str r0, [r13, #+0x4]
		mov r0, r9
		mov r1, r9
		mov r2, #0
		mov r3, #2
		bl DefenseStatUp ; Raise defense by 2 stages
		mov r0, #1
		str r0, [r13]
		str r0, [r13, #+0x4]
		mov r0, r9
		mov r1, r9
		mov r2, #1
		mov r3, #2
		bl AttackStatUp ; Raise sp. attack by 2 stages
		mov r0, #1
		str r0, [r13]
		str r0, [r13, #+0x4]
		mov r0, r9
		mov r1, r9
		mov r2, #1
		mov r3, #2
		bl DefenseStatUp ; Raise sp. defense by 2 stages
		mov r0, #1
		mov r0, r9
		mov r1, r9
		mov r2, #0
		bl FocusStatUp ; Raise accuracy
		mov r0, r9
		mov r1, r9
		mov r2, #1
		bl FocusStatUp ; Raise evasiveness
		mov r0, #1
		str r0, [r13]
		mov r0, r9
		mov r1, r9
		mov r2, #2
		mov r3, #20
		bl SpeedStatUp ; Raise speed by 2 stages during 20 turns
		
		ldrh r3, [r8, #+0x4]
		mov r0, #0
		mov r1, #1
		mov r2, #0x23C ; Seems to be the value that is the most used when calling this
		str r3, [r13, #+0x0]
		str r0, [r13, #+0x4]
		str r2, [r13, #+0x8]
		mov r3, #0
		str r3, [r13, #+0xc]
		str r1, [r13, #+0x10]
		str r0, [r13, #+0x14]
		
		ldr r0, [r9, #+0xb4]
		ldrsh r1, [r0, #+0x12]
		ldrsh r0, [r0, #+0x16]
		add r0, r0, r1 ; Compute the user's Max HP
		mov r1, #3
		bl EuclidianDivision ; Divide by 3
		cmp r1, #0
		addne r0, r0, #1 ; Round to upper bound
		mov r1, r0
		mov r0, r9
		mov r2, #0
		mov r3, #0
		bl ConstDamage ; Deals 1/3 of Max HP damage to the user
	end:
		add r13,r13,#0x40
		mov r10, #1
		b MoveJumpAddress
		.pool
	.endarea
.close
