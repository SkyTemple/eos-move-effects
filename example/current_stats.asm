; 
; ------------------------------------------------------------------------------
; Current Stats
; Shows various things in the dungeon console & log
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
.create "./current_stats.bin", 0x02330134 ;Always loaded at this offset
	.org MoveStartAddress
	.area MaxSize ; Define the size of the area
		sub r13, r13, #0x40
		
		; Show in the dungeon console the contents of some of the registers
		
		mov r0,r13
		ldr r1,=stat
		mov r2, #9
		mov r3, r9
		bl SPrintF
		mov r0,r9
		mov r1,r13
		bl SendMessageWithStringLog ; Shows the content of r9
		mov r0,r13
		ldr r1,=stat
		mov r2, #4
		mov r3, r4
		bl SPrintF
		mov r0,r9
		mov r1,r13
		bl SendMessageWithStringLog ; Shows the content of r4
		mov r0,r13
		ldr r1,=stat
		mov r2, #8
		mov r3, r8
		bl SPrintF
		mov r0,r9
		mov r1,r13
		bl SendMessageWithStringLog ; Shows the content of r8
		mov r0,r13
		ldr r1,=stat
		mov r2, #7
		mov r3, r7
		bl SPrintF
		mov r0,r9
		mov r1,r13
		bl SendMessageWithStringLog ; Shows the content of r7
		
		mov r0,r13
		ldr r1,=stat_2
		ldr r2, =DungeonBaseStructurePtr
		ldr r2, [r2, #+0x0] ; Access to the dungeon base structure
		add r2, r2, #0x740
		add r2, r2, #0x8
		ldrb r3, [r2, #+0x1] ; Get the current floor
		ldrb r2, [r2, #+0x0] ; Get the current dungeon
		bl SPrintF
		mov r0,r9
		mov r1,r13
		bl SendMessageWithStringLog ; Shows the current dungeon and floor
		
	end:
		add r13, r13, #0x40
		mov r10, #1
		b MoveJumpAddress
		.pool
	stat: 
		.ascii "r%d: %08x"
		dcb 0
	stat_2: 
		.ascii "This is dungeon %d floor %d."
		dcb 0
	.endarea
.close
