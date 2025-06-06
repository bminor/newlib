/* Copyright (c) 2017  SiFive Inc. All rights reserved.

   This copyrighted material is made available to anyone wishing to use,
   modify, copy, or redistribute it subject to the terms and conditions
   of the FreeBSD License.   This program is distributed in the hope that
   it will be useful, but WITHOUT ANY WARRANTY expressed or implied,
   including the implied warranties of MERCHANTABILITY or FITNESS FOR
   A PARTICULAR PURPOSE.  A copy of this license is available at
   http://www.opensource.org/licenses.
*/

#include <sys/asm.h>

/* int setjmp (jmp_buf);  */
  .globl  setjmp
  .type   setjmp, @function
setjmp:
	REG_S ra,  0*SZREG(a0)
  #if __riscv_xlen == 32 && (__riscv_zilsd) && (__riscv_misaligned_fast)
	  sd    s0,  1*SZREG(a0)
  #else
	  REG_S s0,  1*SZREG(a0)
	  REG_S s1,  2*SZREG(a0)
  #endif

#ifndef __riscv_abi_rve
  #if __riscv_xlen == 32 && (__riscv_zilsd) && (__riscv_misaligned_fast)
	  sd    s2,  3*SZREG(a0)
	  sd    s4,  5*SZREG(a0)
	  sd    s6,  7*SZREG(a0)
	  sd    s8,  9*SZREG(a0)
	  sd    s10,11*SZREG(a0)
  #else
	  REG_S s2,  3*SZREG(a0)
	  REG_S s3,  4*SZREG(a0)
	  REG_S s4,  5*SZREG(a0)
	  REG_S s5,  6*SZREG(a0)
	  REG_S s6,  7*SZREG(a0)
	  REG_S s7,  8*SZREG(a0)
	  REG_S s8,  9*SZREG(a0)
	  REG_S s9, 10*SZREG(a0)
	  REG_S s10,11*SZREG(a0)
	  REG_S s11,12*SZREG(a0)
  #endif
  REG_S sp, 13*SZREG(a0)
#else
	REG_S sp, 3*SZREG(a0)
#endif

#ifndef __riscv_float_abi_soft
	FREG_S fs0, 14*SZREG+ 0*SZFREG(a0)
	FREG_S fs1, 14*SZREG+ 1*SZFREG(a0)
	FREG_S fs2, 14*SZREG+ 2*SZFREG(a0)
	FREG_S fs3, 14*SZREG+ 3*SZFREG(a0)
	FREG_S fs4, 14*SZREG+ 4*SZFREG(a0)
	FREG_S fs5, 14*SZREG+ 5*SZFREG(a0)
	FREG_S fs6, 14*SZREG+ 6*SZFREG(a0)
	FREG_S fs7, 14*SZREG+ 7*SZFREG(a0)
	FREG_S fs8, 14*SZREG+ 8*SZFREG(a0)
	FREG_S fs9, 14*SZREG+ 9*SZFREG(a0)
	FREG_S fs10,14*SZREG+10*SZFREG(a0)
	FREG_S fs11,14*SZREG+11*SZFREG(a0)
#endif

	li    a0, 0
	ret
	.size	setjmp, .-setjmp

/* volatile void longjmp (jmp_buf, int);  */
  .globl  longjmp
  .type   longjmp, @function
longjmp:
	REG_L ra,  0*SZREG(a0)
  #if __riscv_xlen == 32 && (__riscv_zilsd) && (__riscv_misaligned_fast)
    ld s0, 1*SZREG(a0)
  #else
    REG_L s0,  1*SZREG(a0)
    REG_L s1,  2*SZREG(a0)
  #endif
#ifndef __riscv_abi_rve
  #if __riscv_xlen == 32 && (__riscv_zilsd) && (__riscv_misaligned_fast)
	  ld    s2,  3*SZREG(a0)
	  ld    s4,  5*SZREG(a0)
	  ld    s6,  7*SZREG(a0)
	  ld    s8,  9*SZREG(a0)
	  ld    s10,11*SZREG(a0)
  #else
	  REG_L s2,  3*SZREG(a0)
	  REG_L s3,  4*SZREG(a0)
	  REG_L s4,  5*SZREG(a0)
	  REG_L s5,  6*SZREG(a0)
	  REG_L s6,  7*SZREG(a0)
	  REG_L s7,  8*SZREG(a0)
	  REG_L s8,  9*SZREG(a0)
	  REG_L s9, 10*SZREG(a0)
	  REG_L s10,11*SZREG(a0)
	  REG_L s11,12*SZREG(a0)
  #endif
	REG_L sp, 13*SZREG(a0)
#else
	REG_L sp, 3*SZREG(a0)
#endif

#ifndef __riscv_float_abi_soft
	FREG_L fs0, 14*SZREG+ 0*SZFREG(a0)
	FREG_L fs1, 14*SZREG+ 1*SZFREG(a0)
	FREG_L fs2, 14*SZREG+ 2*SZFREG(a0)
	FREG_L fs3, 14*SZREG+ 3*SZFREG(a0)
	FREG_L fs4, 14*SZREG+ 4*SZFREG(a0)
	FREG_L fs5, 14*SZREG+ 5*SZFREG(a0)
	FREG_L fs6, 14*SZREG+ 6*SZFREG(a0)
	FREG_L fs7, 14*SZREG+ 7*SZFREG(a0)
	FREG_L fs8, 14*SZREG+ 8*SZFREG(a0)
	FREG_L fs9, 14*SZREG+ 9*SZFREG(a0)
	FREG_L fs10,14*SZREG+10*SZFREG(a0)
	FREG_L fs11,14*SZREG+11*SZFREG(a0)
#endif

	seqz a0, a1
	add  a0, a0, a1   # a0 = (a1 == 0) ? 1 : a1
	ret
	.size	longjmp, .-longjmp
