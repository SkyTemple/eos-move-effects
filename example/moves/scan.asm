; 
; ------------------------------------------------------------------------------
; Scan
; Scans the target and provide information about its stats ------------------------------------------------------------------------------


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
.create "./scan.bin", 0x02330134 ;Always loaded at this offset
	.org MoveStartAddress
	.area MaxSize ; Define the size of the area
		sub r13, r13, #0x40
		mov r0,#0x0
		mov r1,r9
		mov r2,#0x0
		bl ChangeString ; Useless, StringID 0 should already contain the user name
		mov r0,#0x1
		mov r1,r4
		mov r2,#0x0
		bl ChangeString ; StringID 1 now contains the target name
		mov r0,r9
		ldr r1,=scan
		bl SendMessageWithStringLog ; Shows "[User] scanned [Target]!"
		
		mov r0,r13
		ldr r2, [r4, #+0xb4] ; Get target additional info structure
		ldrb r2, [r2, #+0xa] ; Get the level
		ldr r1,=stat_lvl
		bl SPrintF
		mov r0,r9
		mov r1,r13
		bl SendMessageWithStringLog ; Shows the level of the target
		
		mov r0,r13
		ldr r1, [r4, #+0xb4]
		ldrsh r3, [r1, #+0x12]
		ldrsh r2, [r1, #+0x16]
		add r3,r3,r2 ; Compute the Max HP
		ldrsh r2, [r1, #+0x10] ; Get the current HP
		ldr r1,=stat_hp
		bl SPrintF
		mov r0,r9
		mov r1,r13
		bl SendMessageWithStringLog ; Shows HP and Max HP of the target
		
		mov r0,r13
		ldr r2, [r4, #+0xb4]
		ldrb r2, [r2, #+0x1a] ; Get the attack
		ldr r1,=stat_atk
		bl SPrintF
		mov r0,r9
		mov r1,r13
		bl SendMessageWithStringLog ; Shows the attack of the target
		
		mov r0,r13
		ldr r2, [r4, #+0xb4]
		ldrb r2, [r2, #+0x1c] ; Get the defense
		ldr r1,=stat_def
		bl SPrintF
		mov r0,r9
		mov r1,r13
		bl SendMessageWithStringLog ; Shows the defense of the target
		
		mov r0,r13
		ldr r2, [r4, #+0xb4]
		ldrb r2, [r2, #+0x1b] ; Get the sp. attack
		ldr r1,=stat_spatk
		bl SPrintF
		mov r0,r9
		mov r1,r13
		bl SendMessageWithStringLog ; Shows the sp. attack of the target
		
		mov r0,r13
		ldr r2, [r4, #+0xb4]
		ldrb r2, [r2, #+0x1d] ; Get the sp. defense
		ldr r1,=stat_spdef
		bl SPrintF
		mov r0,r9
		mov r1,r13
		bl SendMessageWithStringLog ; Shows the sp. defense of the target
		add r13, r13, #0x40
	end:
		mov r10, #1
		b MoveJumpAddress
		.pool
	scan: 
		.ascii "[string:0] scanned [string:1]!"
		dcb 0
	stat_lvl: 
		.ascii "Level: %d"
		dcb 0
	stat_hp: 
		.ascii "HP: %d/%d"
		dcb 0
	stat_atk: 
		.ascii "Attack: %d"
		dcb 0
	stat_def: 
		.ascii "Defense: %d"
		dcb 0
	stat_spatk: 
		.ascii "Sp. Atk.: %d"
		dcb 0
	stat_spdef: 
		.ascii "Sp. Def.: %d"
		dcb 0
	.endarea
.close
