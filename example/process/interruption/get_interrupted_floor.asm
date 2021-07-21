; 
; ------------------------------------------------------------------------------
; Get the floor on which the dungeon was interrupted
; e.g. if dungeon was interrupted when going to floor 3, returns 3
; Returns: floor_id, 0 if dungeon was ended by something else than
; interruption or completion
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
.definelabel interrupted_floor, 0x022DBFB0-0xC00

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7A80
;.definelabel ProcJumpAddress, 0x022E7B88
;.definelabel DungeonSetupStruct, 0x022ABE3C
;.definelabel interrupted_floor, 0x022DC908-0xC00


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
		
		ldr r0,=interrupted_floor
		ldr r0,[r0]
		
		; Always branch at the end
		b ProcJumpAddress
		.pool
	.endarea
.close
