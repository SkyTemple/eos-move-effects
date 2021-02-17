; 
; ------------------------------------------------------------------------------
; Hello World
; Well we always have to start somewhere...
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
.create "./hello_world.bin", 0x02330134 ;Always loaded at this offset
	.org MoveStartAddress
	.area MaxSize ; Define the size of the area
		mov r0,r9
		ldr r1,=hello
		bl SendMessageWithStringLog ; Shows hello world
		b MoveJumpAddress
		.pool
	hello: 
		.ascii "[string:0]: Hello world!"
		dcb 0
	.endarea
.close
