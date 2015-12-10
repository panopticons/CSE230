 
#assignment4.s

################################################################

#  Assignment #: 4

#  Name: Your name

#  ASU email: Your ASU email

#  Course: CSE230/EEE230

#  Description: A customer can specify how many months to rent

#  a one or two bedroom apartment, and it computes its total rent.

################################################################

 

#data declarations:

                .data

enterMonths:    .asciiz "Please enter a number of months to rent an apartment:\n"

howManyBedrooms: .asciiz "Would you like to rent an apartment of one bedroom or two bedrooms?\nPlease enter 1 or 2:\n"

msgTotalRent:   .asciiz "Your total rent: "

msgDollars:     .asciiz " dollars for "

msgMonths:      .asciiz " months\n"

msgSorry:       .asciiz "Sorry, we have only one or two bedroom apartments.\n"

return:         .asciiz "\n"

 

#program code is contained below under .text

                .text

                .globl  main    # define a global function main

 

# the program begins execution at main()

main:

        # ask to enter months

        la      $a0, enterMonths # $a0 = address of enterMonths

        li      $v0, 4          # $v0 = 4  --- this is to call print_string()

        syscall                 # call print_string()

 

 

        # read in the first value

        li      $v0, 5          # $v0 = 5  --- read_int()

        syscall

 

        add     $s2, $v0, $zero # $s2 contains the number of months

 

        # ask one or two bedroom apt

        la      $a0, howManyBedrooms # $a0 = address of howManyBedrooms

        li      $v0, 4          # $v0 = 4  --- this is to call print_string()

        syscall                 # call print_string()

 

 

        # read in the second value

        li      $v0, 5          # $v0 = 5  --- read_int()

        syscall

 

        add     $s1, $v0, $zero # $s1 contains 1 or 2 bedrooms

 

        li      $t1, 1

        li      $t2, 2

        slt     $t0, $s1, $t1    # $t0=1 if numberofRooms < 1

        bne     $t0, $zero, Sorry

   

        slt     $t0, $t2, $s1    # $t0=1 if numbersOfRooms > 2

        bne     $t0, $zero, Sorry

 

        j       Else

 

Sorry:

        la      $a0, msgSorry   # $a0 = address of msgSorry

        li      $v0, 4          # $v0 = 4  --- this is to call print_string()

        syscall                 # call print_string()

 

        j       End

 

Else:

        #if (numberOfRooms==1 && months > 0 && months < 6)

        bne     $s1, $t1, Compare2   # if $s1!=1, go to Compare2

        ble     $s2, $zero, Compare2 #if months <= 0, go to Compare2

        li      $t3, 6

        bge     $s2, $t3, Compare2   #if months >= 6, go to Compare2

        li      $t4, 600             

        mult    $s2, $t4

        mflo    $s3                  #$s3 = rent = 600*months

        j       Exit1

 

Compare2:

        #if (numberOfRooms==1 && months >= 6)

        bne     $s1, $t1, Compare3   # if $s1!=1, go to Compare3

        li      $t3, 6

        blt     $s2, $t3, Compare3   #if months >= 6, go to Compare3

        li      $t4, 600             

        mult    $s2, $t4

        mflo    $s3                  #$s3 = rent = 600*months

        addi    $s3, $s3, -200       #$s3 = rent = 600*months-200

        j       Exit1

 

Compare3:

        #if (numberOfRooms==2 &&  months > 0 && months < 6)

        bne     $s1, $t2, Compare4   # if $s1!=2, go to Compare4

        ble     $s2, $zero, Compare4 #if months <= 0, go to Compare4

        li      $t3, 6

        bge     $s2, $t3, Compare4   #if months >= 6, go to Compare4

        li      $t4, 900             

        mult    $s2, $t4

        mflo    $s3                  #$s3 = rent = 900*months

        j       Exit1

 

Compare4:

        #if (numberOfRooms==2 && months >= 6)

        bne     $s1, $t2, Compare5   # if $s1!=2, go to Compare5

        li      $t3, 6

        blt     $s2, $t3, Compare5   #if months >= 6, go to Compare5

        li      $t4, 900

        mult    $s2, $t4

        mflo    $s3                  #$s3 = rent = 900*months

        addi    $s3, $s3, -300       #$s3 = rent = 900*months-300

        j       Exit1

 

Compare5:

        #else

        li      $s3, 0               # $s4=discount=0

        j       Exit1

 

Exit1:

        la      $a0, msgTotalRent # $a0 = address of msgDollars

        li      $v0, 4          # $v0 = 4  --- this is to call print_string()

        syscall                 # call print_string()

 

        #print the total rent

        add     $a0, $s3, $zero # $a0 = $s3 = total rent

        li      $v0, 1          # $v0 = 1  --- this is to call print_int()

        syscall                 # call print_int()

 

        la      $a0, msgDollars # $a0 = address of msgDollars

        li      $v0, 4          # $v0 = 4  --- this is to call print_string()

        syscall                 # call print_string()

 

        #print months

        add     $a0, $s2, $zero # $a0 = $s2 = months

        li      $v0, 1          # $v0 = 1  --- this is to call print_int()

        syscall                 # call print_int()

 

        la      $a0, msgMonths  # $a0 = address of msgMonths

        li      $v0, 4          # $v0 = 4  --- this is to call print_string()

        syscall                 # call print_string()

 

End:

        jr      $ra             # return