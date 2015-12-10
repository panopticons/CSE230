#  assignment6.s
################################################################
#  Assignment #: 6
#  Name: Your name
#  ASU email: Your ASU email
#  Course: CSE/EEE230
#  Description: It asks a user to specify how many times to repeat,
#  then call readArray, reverseArray, and printArray procedures.
################################################################
 
#data declarations: declare variable names used in program
                .data
numbers:        .space 36 # set aside 4 bytes * 9 = 36 bytes, 1 word = 4 bytes
 
enter1:         .asciiz "Enter an integer:\n"
toRepeat:            .asciiz "Please enter an integer to specify how many times to repeat:\n"
howManyNumbers:         .asciiz "Specify how many numbers should be stored in the array (at most 9):\n"
loopMsg:             .asciiz "Loop "
 
arrayContains:  .asciiz "The array content is:\n"
arrayReversed:   .asciiz "The array has been reversed\n"
return:         .asciiz "\n"
 
#program code is contained below under .text
                .text
                .globl  main    # define a global function main
 
############################################################################
#Procedure: main
#           It calls readyArray, reverseArray, and printArray procedures
# parameters: none
# returned value: none
############################################################################               
# the program begins execution at main()
main:  
        la      $a1, numbers    # $a1 = addr of numbers
 
        # print "Specify how many times to repeat"
        la      $a0, toRepeat   # $a0 = address of toRepeat
        li      $v0, 4          # $v0 = 4 
        syscall
 
        # read in the value
        li      $v0, 5          # $v0 = 5  --- read_int()
        syscall
 
        move    $s0, $v0        # $s0 = how many times to repeat
        li      $s1, 0          # #s1 = 0;
 
Loop4:
        slt   $t0, $s1, $s0   # $t0=1 if i < howMany
        beq     $t0, $zero, End
 
        #printf("Loop %d\n", i+1);
        la      $a0, loopMsg    # $a0 = address of loopMsg
        li      $v0, 4          # $v0 = 4
        syscall
 
        # print i+1
        add     $t1, $s1, 1     # $t1 = i+1
        move    $a0, $t1        # $a0 = i+1
        li      $v0, 1          # $v0 = 1 -- print_int()
        syscall                 # call print_int()
 
        # print "\n"
        la      $a0, return     # $a0 = address of return
        li      $v0, 4          # $v0 = 4  --- this is to call print_string()
        syscall                 # call print_string()
 
 
        # call readArray procedure
        addi    $sp, $sp, -4    # decrement the stack pointer
        sw      $ra, 0($sp)     # save the return address for main
       
        #This part is to call the readArray procedure
        jal     readArray       # call readArray
 
        add    $s3, $v0, $zero              # $s3 = length
 
        move   $a2, $s3         # $a2 = length
 
        lw      $ra, 0($sp)     # load the return address for main
        addi    $sp, $sp, 4     # increment the stack pointer
 
        # call reverseArray procedure
        addi    $sp, $sp, -4    # decrement the stack pointer
        sw      $ra, 0($sp)     # save the return address for main
 
        jal     reverseArray       # call reverseArray
 
        lw      $ra, 0($sp)     # load the return address for main
        addi    $sp, $sp, 4     # increment the stack pointer
 
        # call printArray procedure
        addi    $sp, $sp, -4    # decrement the stack pointer
        sw      $ra, 0($sp)     # save the return address for main
 
        jal     printArray       # call printArray
 
        lw      $ra, 0($sp)     # load the return address for main
        addi    $sp, $sp, 4     # increment the stack pointer
 
        # call reverseArray procedure
        addi    $sp, $sp, -4    # decrement the stack pointer
        sw      $ra, 0($sp)     # save the return address for main
 
        jal     reverseArray       # call reverseArray
 
        lw      $ra, 0($sp)     # load the return address for main
        addi    $sp, $sp, 4     # increment the stack pointer
 
        # call printArray procedure
        addi    $sp, $sp, -4    # decrement the stack pointer
        sw      $ra, 0($sp)     # save the return address for main
       
        jal     printArray       # call printArray
 
        lw      $ra, 0($sp)     # load the return address for main
        addi    $sp, $sp, 4     # increment the stack pointer
 
        addi    $s1, $s1, 1     # i = i+1
 
        j Loop4
 
End:
        jr      $ra             # return of the main procedure
       
#### the end of the main procedure #######################################
       
##############################################################################
# Procedure readArray:
#       It asks a user to enter numbers, and store them in the argument array
# parameters: a1 = addr of array
# return value: length of the array
# register(s) to be used: $s2, $s3 (saved registers)
##############################################################################
readArray:
        addi    $sp, $sp, -4    # decrement the stack pointer
        sw      $s2, 0($sp)    
 
        addi    $sp, $sp, -4    # decrement the stack pointer
        sw      $s3, 0($sp)    
 
        # print "Specify how many integers to read:\n"
        la      $a0, howManyNumbers # $a0 = address of howManyNumbers
        li      $v0, 4          # $v0 = 4  --- this is to call print_string()
        syscall                 # call print_string()
 
        # read in the value
        li      $v0, 5          # $v0 = 5  --- read_int()
        syscall
        #read value is in $v0 at this point
        move    $s3, $v0        # $s3 = length
 
        li      $s2, 0          # $s2 = i, i = 0
                
loop1:
        bge     $s2, $s3, exit1 # if i >= length, go to Exit1      
        li      $t9, 9
        bge     $s2, $t9, exit1 # if i >= 9, go to Exit1
       
        sll     $t3, $s2, 2     # temp register $t2 = i*4              
        add     $t4, $a1, $t3   # $t3 = address of numbers[i]
                                #     = address of numbers+(i*4)
        # print "Enter an integer:\n"
        la      $a0, enter1      # $a0 = address of enter
        li      $v0, 4          # $v0 = 4  --- this is to call print_string()
        syscall                 # call print_string()
       
        # read in the value
        li      $v0, 5          # $v0 = 5  --- read_int()
        syscall         
        #read value is in $v0 at this point
        
        sw      $v0, 0($t4)     # numbers[i] = $v0,
                                # read value is store in the array
               
        addi    $s2, $s2, 1     # i = i + 1
               
        j       loop1
       
exit1:       
        move    $v0, $s2
        #restore values of saved registers for calling procedures
        lw      $s3, 0($sp)   
        addi    $sp, $sp, 4
 
        lw      $s2, 0($sp)   
        addi    $sp, $sp, 4
 
        jr      $ra             # exst readArray procedure
       
#### the end of the readArray procedure #################################
       
#########################################################################
# Procedure reverseArray:
# Description: The reverseArray rearranges the content of the array
# into its reversed order.
# parameters: a1 = addr of array, a2 = length
# return value: none
# register(s) to be used: $s2, $s3, $s4 (saved registers)
#########################################################################
reverseArray:
        addi    $sp, $sp, -4    # decrement the stack pointer
        sw      $s2, 0($sp)
 
        addi    $sp, $sp, -4    # decrement the stack pointer
        sw      $s3, 0($sp)
 
        addi    $sp, $sp, -4    # decrement the stack pointer
        sw      $s4, 0($sp)
 
        move    $s3, $a2        # $s3 = length
        addi    $s4, $s3, 1     # $s4 = length+1
        li      $t2, 2
        div     $s4, $t2
        mflo    $s4             # $s4  = midpoint = (length+1)/2
 
        li      $s2, 0          # $s2 = i, i = 0
 
loop2:
        bge     $s2, $s4, exit2 # if i >= midpoint, go to Exit2
 
        sll     $t3, $s2, 2     # $t3 = i*4
        add     $t4, $a1, $t3   # $t4 = address of array[i]
                                #     = address of array+(i*4)
        lw      $t1, 0($t4)     # $t1 = array[i]
 
        sub     $t5, $s3, $s2   # $t5 = length-i
        addi    $t5, $t5, -1    # $t5 = length-i-1
 
        sll     $t6, $t5, 2     # #t6 = (length-i-1)*4
        add     $t7, $a1, $t6   # $t7 = address of array[length-i-1]
        lw      $t2, 0($t7)     # $t2 = array[length-i-1]
 
        sw      $t2, 0($t4)     # array[i] = $t7
        sw      $t1, 0($t7)     # array[length-i-1] = $t1
 
        addi    $s2, $s2, 1     # i = i + 1
 
        j       loop2
 
exit2:
        # print "array reversed\n"
        la      $a0, arrayReversed # $a0 = address of arrayReversed
        li      $v0, 4          # $v0 = 4  --- this is to call print_string()
        syscall                 # call print_string()
 
        #restore values of saved registers for calling procedures
        lw      $s4, 0($sp)
        addi    $sp, $sp, 4
 
        lw      $s3, 0($sp)
        addi    $sp, $sp, 4
 
        lw      $s2, 0($sp)
        addi    $sp, $sp, 4
 
        jr      $ra             # exit reversedArray procedure
 
#### the end of the reverseArray procedure ##########################
 
##############################################################################
# Procedure printArray:
#       It prints out each number in the parameter array
# parameters: a1 = addr of array, a2 = length
# return value: none
# register(s) to be used: $s2, $s3 (saved registers)
##############################################################################
printArray:
        addi    $sp, $sp, -4    # decrement the stack pointer
        sw      $s2, 0($sp)   
 
        addi    $sp, $sp, -4    # decrement the stack pointer
        sw      $s3, 0($sp)   
 
        # print "The array content isi:\n"
        la      $a0, arrayContains     # $a0 = address of arrayContains
        li      $v0, 4          # $v0 = 4  --- this is to call print_string()
        syscall                 # call print_string()
 
        move    $s3, $a2        # $s3 = length
 
        li      $s2, 0          # $s2 = i, i = 0
 
loop3:
        bge     $s2, $s3, exit3 # if i >= length, go to Exit3
 
        sll     $t3, $s2, 2     # temp register $t2 = i*4
        add     $t4, $a1, $t3   # $t3 = address of numbers[i]
                                #     = address of numbers+(i*4)
 
        lw      $v0, 0($t4)     # $v0 = numbers[i],
 
               # print the integer
               add $a0, $v0, $zero         # $a0 = numbers[i]
               li  $v0, 1               # $v0 = 1  --- this is to call print_int()
               syscall                 # call print_int()
 
        # print "\n"
        la      $a0, return     # $a0 = address of return
        li      $v0, 4          # $v0 = 4  --- this is to call print_string()
        syscall                 # call print_string()
 
        addi    $s2, $s2, 1     # i = i + 1
 
        j       loop3
 
exit3:
        #restore values of saved registers for calling procedures
        lw      $s3, 0($sp)    
        addi    $sp, $sp, 4
 
        lw      $s2, 0($sp)    
        addi    $sp, $sp, 4
 
        jr      $ra             # exst printArray procedure
 
#### the end of the printArray procedure #################################