#assignment7.s
#--------------------------------------------------------------
#  Assignment #: 7
#  Name: Your name
#  ASU email: Your ASU email
#  Course: CSE/EEE230
#  Description: It asks a user to enter an integer, and compute the
#               function value using it as:
#               function1(n) = n-5                      if n <= 3
#                            = 4*function1(n-1)-n*function1(n-3)  otherwise.
#               Then it prints the result.
#--------------------------------------------------------------
 
#data declarations: declares variables names used in program
             .data
enter:       .asciiz "Enter an integer:\n"
result:      .asciiz "The solution is: "
return:      .asciiz "\n"
 
#program code is contained below under .text
             .text
             .globl  main    # define a global function main
                       
############################################################################
#Procedure: main
#           It calls the function1
# parameters: none
# returned value: none
############################################################################
# the program begins execution at main()
main:                                                  
        # print "Enter an integer:\n"
        la      $a0, enter      # $a0 = address of enter
        li      $v0, 4          # $v0 = 4  --- this is to call print_string()
        syscall                 # call print_string()
       
        # read in the value
        li      $v0, 5          # $v0 = 5  --- read_int()
        syscall                
       
        move    $a1, $v0        # argument $a1 contains the integer entered
                                # by user
       
        addi    $sp, $sp, -4    # decrement stack pointer by 4
        sw      $ra, 0($sp)     # save the return address for main
       
        #This part is to call the procedure function1
        jal     function1       # call function1
 
        move    $t1, $v0        # returned value is stored in $t1
        
        lw      $ra, 0($sp)     # restore the return address of main
        addi    $sp, $sp, 4     # increment stack pointer by 4
       
       
        # print "The solution is: "
        la      $a0, result     # $a0 = address of result
        li      $v0, 4          # $v0 = 4  --- this is to call print_string()
        syscall                 # call print_string()
       
        # print the computed value
        move    $a0, $t1        # $a0 = returned value
        li      $v0, 1          # $v0 = 1 -- print_int()
        syscall                 # call print_int()
       
        # print "\n"
        la      $a0, return     # $a0 = address of return
        li      $v0, 4          # $v0 = 4  --- this is to call print_string()
        syscall                 # call print_string()
 
        jr      $ra             # return of the main procedure
       
#### the end of the main procedure #########################################
               
############################################################################
#Procedure: function1
#               It is defined by
#               function1(n) = n-5                      if n <= 3
#                            = 4*function1(n-2)-n*function1(n-3)  otherwise.
# parameters: $a1 = n (entered integer)
# returned value: $v0 = returned value from function1
# registers to be used: $t3, $t4, an $t5 will be used.
############################################################################
function1:
        addi    $sp, $sp, -4    # decrement stack pointer by 4
        sw      $ra, 0($sp)     # save the return address
                                # (it might call itself)
 
        addi    $sp, $sp, -4    # decrement stack pointer by 4
        sw      $a1, 0($sp)     # save the parameter value
                                # (it might call itself and value can change)     
       
        addi    $sp, $sp, -4    # decrement stack pointer by 4
        sw      $t3, 0($sp)     # in case $t3 was used by another procedure,
                                # save it
                               
        addi    $sp, $sp, -4    # decrement stack pointer by 4
        sw      $t4, 0($sp)     # in case $t4 was used by another procedure,
                                # save it
 
        addi    $sp, $sp, -4    # decrement stack pointer by 4
        sw      $t5, 0($sp)     # in case $t5 was used by another procedure,
                                # save it
 
        li      $t3, 4          # $t3=4 will be used to compare
       
        # if n < 4, go to basecase1
        blt     $a1, $t3, basecase1 
       
        #else - recursive case when n >= 4
        addi    $a1, $a1, -1    # $a1 = n-1
       
        jal     function1       # call itself recursively
       
        #at this point $v0 contains the returned value of function(n-1)
       
        li      $t4, 4
        mult    $t4, $v0        # 4 * returned value of function(n-1)
        mflo    $t4             # $t4 = 4*function1(n-1)
       
        addi    $a1, $a1, -2    # $a1 = n-3 since $a1 was n-1 before,
                                # just subtract 2 more
       
        jal     function1       # call itself recursively
       
        #at this point $v0 contains the returned value of function(n-3)
 
        add     $a1, $a1, 3     # get back the original n value
        mult    $a1, $v0        # n * returned value of function(n-3)
        mflo    $t5             # $t5 = n*function1(n-3)
 
       
        sub     $v0, $t4, $t5   # $v0 = 4*function1(n-2)-n*function(n-3)
 
        j       exit1           # jump to the label exit1 where it prepares
                                # to exit the function
 
basecase1: #this is for the base case when n <= 3
        addi    $v0, $a1, -5    # $v0 = n=5
       
        j       exit1           # jump to the label exit1 where it prepares
                                # to exit the function
       
 
exit1: 
# this is to restore the stack pointer before exiting the function
        lw      $t5, 0($sp)     # restore $t5 from another procedure
        addi    $sp, $sp, 4     # adjust stack pointer to pop
       
        lw      $t4, 0($sp)     # restore $t4 from another procedure
        addi    $sp, $sp, 4     # adjust stack pointer to pop
       
        lw      $t3, 0($sp)     # restore $t3 from another procedure
        addi    $sp, $sp, 4     # adjust stack pointer to pop
 
        lw      $a1, 0($sp)     # restore $a1 from another procedure
        addi    $sp, $sp, 4     # adjust stack pointer to pop
 
        lw      $ra, 0($sp)     # restore return address
        addi    $sp, $sp, 4     # adjust stack pointer to pop  
 
        jr      $ra             # exit function1 procedure
 
#### the end of the function1 procedure ###############################