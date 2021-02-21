; 
; ------------------------------------------------------------------------------
; Hello World
; Always here
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
.create "./hello_world.bin", 0x0231BE50 ; Change to the actual offset as this directive doesn't accept labels
	.org ItemStartAddress
	.area MaxSize ; Define the size of the area
		mov r0,r8
		ldr r1,=hello
		bl SendMessageWithStringLog ; Shows hello world
		b ItemJumpAddress
		.pool
	hello: 
		.ascii "[string:0]: Hello world!"
		dcb 0
	.endarea
.close
