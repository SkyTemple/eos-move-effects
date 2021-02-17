# EoS Move Effects 

This is a kind-of framework to code your own move effects for the game Pokémon Mystery Dungeon: Explorers of Sky.
Currently, only the US and EU versions are supported. 
This only provides support for creating ASM code for custom effects, not for injecting it into the rom.
Move effects code injection may be available soon.

# Getting Started

Move effects ASM code can be assembled using armips (see https://github.com/Kingcom/armips).

## Run Example Effects

To run an example, you must copy it in the same directory as "template.asm". 
The run "armips \[path\_to\_example\_script\]" (assuming you installed armips).
This should produce a binary file ("*.bin") that you can inject in the ROM.
The examples are assembled for the US version, but you can change it for the EU version by commenting lines for the US versions and uncommenting those for the EU version. You also have to change the offset defined in the ".create" line.

## Create your own effect

This requires some ARM9 asm knowledge. 
It is recommended to use the file "template.asm" as a base, as it prepares all the things needed to implement a valid move effect code. 
Copy this file, open the copy, and uncomment the lines for the version you want. 
Then, you can start coding your effect.
You can use the functions provided by the documentation in the "doc" folder. 
All the functions may overwrite registers r0 to r3, so be careful to save the content of those if you need them after executing a function. 
Also, it is recommended to use them as much as possible as they provide compatibility between the supported versions of the game, and possibly with the future supported versions.
