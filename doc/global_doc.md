# Terminology

### Function Parameters

All functions described in the docs works as follows: 
 - All use registers r0 to r3 to pass their first 4 parameters. 
 - Those registers may be overwritten during the function process, so save their contents if you need to before calling a function.
 - If the function needs more than 4 parameters, additional parameters are passed using the data provided at \[r13\] (address pointed by register r13, or stack pointer). Each additional parameter is 4 bytes, like the content of one register.
You should allocate some space to r13 using the instruction "sub r13, r13, SpaceYouNeed" and store the parameters. Don't forget to free the space you allocated using "add r13, r13, SpaceYouNeed".
 - Functions return values work the same as for parameters (r0 to r3 then \[r13\]).

# Libraries

### stdlib

This library contains basic functions used by the game.

All are defined in arm9, so they are usable anywhere.

### dunlib

This library contains the functions used in dungeons.

They are defined in overlay 29, so they are only usable in dungeon mode.


