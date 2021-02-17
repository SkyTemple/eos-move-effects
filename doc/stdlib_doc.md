# Terminology

# Structures

# Functions

## Input/Output

### r0: nb_char = SPrintF(r0: str, r1: format, ...)
See the C language documentation about 'sprintf'.
The first two additional parameters are passed using registers r2 and r3, 
the others are passed using the heap (starting from \[r13\], each parameter is 4 bytes).

## String Manipulation

### r0: dest = StrCpy(r0: dest, r1: src)
See the C language documentation about 'strcpy'.

### r0: dest = StrNCpy(r0: dest, r1: src, r2: n)
See the C language documentation about 'strncpy'.

## Math

### r0: q, r1: r = EuclidianDivision(r0: n, r1: d)

