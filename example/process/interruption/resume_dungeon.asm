; 
; ------------------------------------------------------------------------------
; Resume dungeon
; Must be called between "main_EnterDungeon(dungeon_id, fadeout);"
; and "main_EnterDungeon(-1, fadeout);"
; Param 1: floor number
; Param 2: 1 if party should not be healed, else 0
; Returns: nothing
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x810

; Uncomment the correct version

; For US
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel DungeonSetupStruct, 0x022AB4FC
.definelabel SetInterrupt, 0x022DBFB0-0xC00

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7A80
;.definelabel ProcJumpAddress, 0x022E7B88
;.definelabel DungeonSetupStruct, 0x022ABE3C
;.definelabel SetInterrupt, 0x022DC908-0xC00


; File creation
.create "./code_out.bin", 0x022E7248 ; Change to the actual offset as this directive doesn't accept labels
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area
		; Usable Variables: 
		; r7 = First Argument
		; r6 = Second Argument
		; Returns: 
		; r0 = User Defined Value
		; Registers r4 to r11 and r13 must remain unchanged after the execution of that code
		
		
		; Code here
		
		ldr r0,=DungeonSetupStruct
		strb r7,[r0,#+0x1]
		
		mov r0,r6
		bl SetInterrupt
		
		; Always branch at the end
		b ProcJumpAddress
		.pool
	.endarea
.close
