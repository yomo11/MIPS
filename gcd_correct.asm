.data
result:.asciiz"The GCD is:"
inputa:.asciiz "The first number="
inputb:.asciiz "The second number="

.align 2
.globl main
.text
main:
	#input a
	li	$v0, 4			
       	la	$a0, inputa
       	syscall
       	li	$v0, 5
       	syscall
       	add	$a1, $v0, $zero
       	
       	#input b
       	li	$v0, 4
       	la	$a0, inputb
	syscall
	li	$v0, 5
	syscall
       	add	$a2, $v0, $zero
	
	#if a < b then swap
	#blt	$a1, $a2, swap
	slt	$t0, $a1, $a2
	bne	$t0, $zero, swap
	
#callinggcd
	addi	$sp, $sp, -8 		#a0 and a1
	sw	$a1, 4($sp)
	sw	$a2, 0($sp)
	jal	gcd
	lw	$a2, 0($sp)
	lw	$a1, 4($sp)
	addi	$sp, $sp, 4
	add	$s0, $v0, $zero
	sw	$s0, 0($sp)	


# output	
	li	$v0, 4
	la	$a0, result
	syscall
	li	$v0, 1
	add	$a0, $s0, $zero		# let $a0 = gcd result($s0)
	syscall
	
	li	$v0, 10
	syscall

	
swap:
	#addi	$sp, $sp, -8
	#sw	$ra, 4($sp)
	
	add	$t0, $a1, $zero
	add	$t1, $a2, $zero
	nop
	add	$a2, $t0, $zero
	add	$a1, $t1, $zero
	#lw	$ra, 4($sp)
	#addi	$sp, $sp, 8
	jr	$ra
	
gcd:
	addi	$sp, $sp, -8
	sw	$ra, 4($sp)

# recursive 1
	div	$a1, $a2		# reminder in $HI
	mfhi	$s0			# $s0 is $a1 % $a2
	sw	$s0, 0($sp)
	bne	$s0, $zero, recursive2
# Base Case
	add	$v0, $a2, $zero
	addi	$sp, $sp, 8
	jr	$ra

recursive2:
	add	$a1, $a2, $zero		# set $a1 = $a2
	lw	$s0, 0($sp)		# load reminder
	add	$a2, $s0, $zero
	jal	gcd
	
# Exit Recursive
	lw	$ra, 4($sp)		# load previous return address
	addi	$sp, $sp, 8
	jr	$ra