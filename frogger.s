		AREA PROGRAM, CODE
        EXPORT __main
			
__main
		bl  game
		b   stop
		
game
		mov  r4, #0x20000000	; main address
		mov  r5, #0x0		    ; game counter
		mov  r0, r4
		bl   resetGame
		b    gameLoop

gameLoop
		ldr   r6, [r4, #0x24]
		ldr   r7, [r4, #0x18]
		cmp   r6, #0x0		; Player Lost
		beq   game
		cmp   r7, #0x0		; Player Won
		beq   game
		mov   r0, r4
		mov   r1, r5
		bl    moveCreep
		mov   r5, r0
		mov   r0, r4
		bl    movePlayer
		mov   r0, r4
		bl    checkGame
		bl    delay
		b     gameLoop

	;	parameters : r0 - relative address
checkGame
		sub  sp, sp, #0x8
		str  lr, [sp, #0x4]
		str  r4, [sp]
		mov  r4, r0
		ldr  r1, [r4, #0x20]
		cmp  r1, #0x0
		beq  checkGameAux
		cmp  r1, #0x7
		beq  checkLast
		blo  checkCollision
		mov  r1, r0
		mov  r0, r4
		cmp  r1, #0x1
		bleq looseLife
		b    checkGameAux
		
checkGameAux
		ldr   r4, [sp]
		ldr   lr, [sp, #0x4]
		add   sp, sp, #0x8
		mov   pc, lr

		;	parameters : r0 - game address
checkCollision
		sub sp, sp, #0x18
		str lr, [sp, #0x14]
		str r8, [sp, #0x10]
		str r7, [sp, #0xc]
		str r6, [sp, #0x8]
		str r5, [sp, #0x4]
		str r4, [sp]
		mov r4, r0
		ldr r5, [r0, #0x1c]
		ldr r6, [r0, #0x20]
		mov r7, #0x0
		mov r8, #0x0
		b   checkCollisionLoop
		
checkCollisionLoop
		cmp  r8, #0x1
		beq  checkCollisionReturn
		cmp  r7, r6
		bls  checkCollisionReturn
		lsl  r0, r5, #0x2
		ldr  r0, [r4, r0]
		mov  r1, #0x1
		lsl  r1, r1, r5
		and  r8, r0, r1
		add  r7, r7, #0x1
		b    checkCollisionLoop
		
checkCollisionReturn
		mov r8, r0
		ldr r4, [sp]
		ldr r5, [sp, #0x4]
		ldr r6, [sp, #0x8]
		ldr r7, [sp, #0xc]
		ldr r8, [sp, #0x10]
		ldr lr, [sp, #0x4]
		add sp, sp, #0x18
		mov pc, lr
		
checkLast
		sub   sp, sp, #0x4
		str   lr, [sp]
		ldr   r1, [r0, #0x1c]	; r1 = posición y
		mov   r2, #0x1
		lsl   r1, r2, r1
		ldr   r2, [r0, #0x18]
		and   r3, r2, r1 
		cmp   r3, #0x0
		blne  removeExit
		moveq r3, #0x1
		mov   r0, r3
		ldr   lr, [sp]
		add   sp, sp, #0x4
		mov   pc, lr
		
removeExit
		sub  sp, sp, #0x4
		str  lr, [sp]
		sub  r2, r2, r1
		str  r2, [r0, #0x18]
		bl   resetFrog
		mov  r3, #0x0
		ldr  lr, [sp]
		add  sp, sp, #0x4
		mov  pc, lr
		
looseLife
		sub sp, sp, #0x4
		str lr, [sp]
		ldr r1, [r0, #0x24]
		sub r1, r1, #0x0
		str r1, [r0, #0x24]
		bl  resetFrog
		ldr lr, [sp]
		add sp, sp, #0x4
		mov pc, lr

delay
		mov r0, #0x0
		mov r1, #0xd0000
		
delayLoop
		cmp   r0, r1
		addne r0, r0, #0x1
		bne   delayLoop
		mov   pc, lr
		
resetGame
        sub  sp, sp, #0x4
		str  lr, [sp]
		bl   resetPlayer
		bl   resetCreep
		ldr  lr, [sp]
		add  sp, sp, #0x4
		mov  pc, lr
		
resetPlayer
		mov  r1, #0x5
		str  r1, [r0, #0x24]
		mov  r1, #0x0
		str  r1, [r0, #0x28]
		b    resetFrog
		
resetFrog
		mov r1, #0x0
		str r1, [r0, #0x1c]
		mov r1, #0x7
		str r1, [r0, #0x20]
		mov pc, lr
	
	;	parameter 	: r0 - Truck Memory Array Address.
	;	description : Clear the trucks from the screen. Apply 0 to all the registers involved.	
resetCreep
		mov	 r1, #0x0
		b	 resetCreepLoop
	
resetCreepLoop
		cmp r1, #0x5
		bhi resetCreepReturn
		lsl	r2, r1, #0x2
		mov r3, #0x0
		str r3, [r0, r2]
		add r1, r1, #0x1
		b   resetCreepLoop

resetCreepReturn
		mov r3, #0x4924
		str r3, [r0, #0x18]
		mov pc, lr
		
		;	parameters : r0 - player address
movePlayer
		ldr   r1, [r0, #0x28]
		cmp   r1, #0x1
		ldreq r1, [r0, #0x1c]
		beq   moveDown
		cmp   r1, #0x2
		ldreq r1, [r0, #0x1c]
		beq   moveUp
		cmp   r1, #0x3
		ldreq r1, [r0, #0x20]
		beq   moveLeft
		cmp   r1, #0x4
		ldreq r1, [r0, #0x20]
		beq   moveRight

moveDown
		cmp   r1, #0x0
		subhi r1, r1, #0x1
		str   r1, [r0, #0x1c]
		mov   pc, lr

moveUp
		cmp   r1, #0x7
		addlo r1, r1, #0x1
		str   r1, [r0, #0x1c]
		mov   pc, lr
		
moveLeft
		cmp   r1, #0x0
		subhi r1, r1, #0x1
		str   r1, [r0, #0x20]
		mov   pc, lr
		
moveRight
		cmp   r1, #0x15
		addlo r1, r1, #0x1
		str   r1, [r0, #0x20]
		mov   pc, lr
		
	;	parameter 	: r0 - Truck Memory Array Address.
	;               : r1 - Move Counter
	;	description : Clear the trucks from the screen. Apply 0 to all the registers involved.	
moveCreep
		sub  sp, sp, #0x10
		str  lr, [sp, #0xc]
		str  r6, [sp, #0x8]
		str  r5, [sp, #0x4]
		str  r4, [sp]
		mov  r6, #0x0
		mov  r4, r0
		mov  r5, r1
		b	 moveCreepLoop
		
moveCreepLoop
		cmp  r6, #0x5
		bhi  moveCreepReturn
		lsl  r3, r6, #0x2
		ldr  r0, [r4, r3]
		mov  r1, r5
		and  r12, r6, #0x1
		cmp  r12, #0x0
		bleq moveCreepLeft
		cmp  r12, #0x1
		bleq moveCreepRight
		str  r0, [r4, r3]
		add	 r6, r6, #0x1
		b 	 moveCreepLoop
		
moveCreepReturn
		add   r5, r5, #0x1
		cmp   r5, #0x8
		moveq r5, #0x0
		mov   r0, r5
		ldr   r4, [sp]
		ldr   r5, [sp, #0x4]
		ldr   r6, [sp, #0x8]
		ldr   lr, [sp, #0xc]
		add   sp, sp, #0x10
		mov   pc, lr
	
moveCreepLeft
		lsl   r0, r0, #0x1
		cmp   r1, #0x2
		addls r0, #0x1
		mov   r2, #0xffff
		and   r0, r0, r2
		mov   pc, lr
		
moveCreepRight
		lsr   r0, r0, #0x1
		cmp   r1, #0x2
		addls r0, #0x8000
		mov   pc, lr
		
stop    
		B stop ; stop program

        END