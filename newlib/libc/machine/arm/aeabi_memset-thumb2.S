/*
 * Copyright (c) 2015 ARM Ltd
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. The name of the company may not be used to endorse or promote
 *    products derived from this software without specific prior written
 *    permission.
 *
 * THIS SOFTWARE IS PROVIDED BY ARM LTD ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL ARM LTD BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "arm_asm.h"

	.thumb
	.syntax unified
	.global __aeabi_memset
	.type	__aeabi_memset, %function
	.fnstart
	.cfi_sections .debug_frame
	.cfi_startproc
	ASM_ALIAS __aeabi_memset4 __aeabi_memset
	ASM_ALIAS __aeabi_memset8 __aeabi_memset
__aeabi_memset:
	prologue 4 6
	lsls	r4, r0, #30
	beq	10f
	subs	r4, r1, #1
	cmp	r1, #0
	beq	9f
	uxtb	r5, r2
	mov	r3, r0
	b	2f
1:
	subs	r1, r4, #1
	cbz	r4, 9f
	mov	r4, r1
2:
	strb	r5, [r3], #1
	lsls	r1, r3, #30
	bne	1b
3:
	cmp	r4, #3
	bls	7f
	uxtb	r5, r2
	orr	r5, r5, r5, lsl #8
	cmp	r4, #15
	orr	r5, r5, r5, lsl #16
	bls	5f
	mov	r6, r4
	add	r1, r3, #16
4:
	subs	r6, r6, #16
	cmp	r6, #15
	str	r5, [r1, #-16]
	str	r5, [r1, #-12]
	str	r5, [r1, #-8]
	str	r5, [r1, #-4]
	add	r1, r1, #16
	bhi	4b
	sub	r1, r4, #16
	bic	r1, r1, #15
	and	r4, r4, #15
	adds	r1, r1, #16
	cmp	r4, #3
	add	r3, r3, r1
	bls	7f
5:
	mov	r6, r3
	mov	r1, r4
6:
	subs	r1, r1, #4
	cmp	r1, #3
	str	r5, [r6], #4
	bhi	6b
	subs	r1, r4, #4
	bic	r1, r1, #3
	adds	r1, r1, #4
	add	r3, r3, r1
	and	r4, r4, #3
7:
	cbz	r4, 9f
	uxtb	r2, r2
	add	r4, r4, r3
8:
	strb	r2, [r3], #1
	cmp	r3, r4
	bne	8b
9:
	.cfi_remember_state
	epilogue 4 6
10:
	.cfi_restore_state
	mov	r4, r1
	mov	r3, r0
	b	3b
	.cfi_endproc
	.cantunwind
	.fnend
	.size __aeabi_memset, . - __aeabi_memset
