# EoS Move/Item Effects 

This is a kind-of framework to code your own move and item effects for the game Pokémon Mystery Dungeon: Explorers of Sky.

Currently, only the US and EU versions are supported. 

This only provides support for creating ASM code for custom effects, not for injecting it into the rom.

Move/Item effects code injection may be available soon.


# Disclaimer

This provides absolutely NO WARRANTY in terms of results. 
This may not work, or even worse may break your ROM, so as a advice always make some backups of your ROM frequently.

# Getting Started

Move/Item effects ASM code can be assembled using armips (see https://github.com/Kingcom/armips).

## Run Example Effects

To run an example, you must copy it in the same directory as "template\_move.asm" or "template\_item.asm". 

The run "armips \[path\_to\_example\_script\]" (assuming you installed armips).

This should produce a binary file ("*.bin") that you can inject in the ROM.

The examples are assembled for the US version, but you can change it for the EU version by commenting lines for the US versions and uncommenting those for the EU version. You also have to change the offset defined in the ".create" line.

## Create your own effect

This requires some ARM9 asm knowledge. 

It is recommended to use the file "template\_move.asm" as a base for move effects, or "template\_item.asm" for item effects, as it prepares all the things needed to implement a valid move/item effect code. 

Copy this file, open the copy, and uncomment the lines for the version you want. 
Then, you can start coding your effect.

You can use the functions provided by the documentation in the "doc" folder. 

All the functions may overwrite registers r0 to r3, so be careful to save the content of those if you need them after executing a function. 

Also, it is recommended to use them as much as possible as they provide compatibility between the supported versions of the game, and possibly with the future supported versions.

# Credits

This is based on all the research that has been done on the game. 

Specific credits to UsernameFodder for their Dungeon RAM research notes. 

Credits to End45 for the move effects table location.

Credits to PsyCommando for the FileStreams manipulation functions.

And to all the people that have worked on hacking this game or will be in the future.

If you think you must be credited for some research work or improve your credits, or if you want to contribute by adding some functions and/or information in the docs, feel free to open an issue about it.
