.data
       	 output: .asciiz  "i = "
.text
main:
        addiu   $sp,$sp,-80
        sw      $31,76($sp)
        sw      $fp,72($sp)
        move    $fp,$sp
        
        li      $2,1                        # 0x1
        sw      $2,28($fp)
        li      $2,2                        # 0x2
        sw      $2,32($fp)
        li      $2,3                        # 0x3
        sw      $2,36($fp)
        li      $2,4                        # 0x4
        sw      $2,40($fp)
        li      $2,5                        # 0x5
        sw      $2,44($fp)
        
        li      $2,1                        # 0x1
        sw      $2,48($fp)
        li      $2,2                        # 0x2
        sw      $2,52($fp)
        li      $2,3                        # 0x3
        sw      $2,56($fp)
        li      $2,5                        # 0x5
        sw      $2,60($fp)
        li      $2,5                        # 0x5
        sw      $2,64($fp)
        
        sw      $0,24($fp)		# i = 0
        
while:
        lw      $2,24($fp)		# $2 => i
        nop
        
        sll     $2,$2,2      
        addiu   $3,$fp,24
        addu    $2,$3,$2
        lw      $3,4($2)
        lw      $2,24($fp)
        nop
        
        sll     $2,$2,2
        addiu   $4,$fp,24
        addu    $2,$4,$2
        lw      $2,24($2)
        nop
        
        bne     $3,$2,exit
        nop

        lw      $2,24($fp)
        nop
        addiu   $2,$2,1
        sw      $2,24($fp)
        j       while
        nop

exit:
        li $v0, 4
        la $a0, output
        syscall
        li $v0, 1
        lw $a0, 24($fp)
        syscall
        nop

        move    $2,$0
        move    $sp,$fp
        lw      $31,76($sp)
        lw      $fp,72($sp)
        addiu   $sp,$sp,80
        
        li $v0, 10
        syscall
        nop