#################################################################
# Assignment #: 6
# Name: Maria Castro
# ASU email: Maria.F.Castro@asu.edu
# Course: CSE 230 MWF 1:30
# Description:  
#################################################################

.data

numbers: .word 9

prompt: .asciiz "Please enter an integer to specify how many times to repeat:\n"

prompt1: .asciiz "\nSpecify how many numbers should be stored in the array (at most 9):\n"

prompt2: .asciiz "Enter an integer: \n"

arrayreversed: .asciiz "The array has been reversed\n"

loopnumber: .asciiz "Loop "

arraycontent: .asciiz "The array content is:\n"

.text
.globl main
.globl readArray
.globl reverseArray
.globl printArray


main:
la $a0, prompt			# address of prompt is loaded into $a0
li $v0, 4			# 4 is loaded into $v0 to call print_string()
syscall				# print_string() is called

li $v0, 5			# 5 is loaded into $v0 to call read_int()
syscall				# read_int() is called

move $s0, $v0			# howMany ($s0) = $v0
li $t0, 0			# i ($t0) = 0

loop:
slt $t1, $t0, $s0		# set $t1 to 1 if $t0 < $s0
beq $t1, $0, loopend		# branch to loopend if $t1 = 0

la $a0, loopnumber		# address of loopnumber is loaded into $a0
li $v0, 4			# 4 is loaded into $v0 to call print_string()
syscall				# print_string() is called

addi $a0, $t0, 1		# a0 = $t0 + 1
li $v0, 1			# 1 is loaded into $v0 to call print_int()
syscall				# print_int() is called

addi $sp, $sp, -4		# stack pointer is moved down
sw $ra, 0($sp)			# return address for main is saved

la $a0, numbers

jal readArray			# readArray is called

lw $ra, 0($sp)			# return address for main is copied back
addi $sp, $sp, 4		# stack pointer is moved up
move $a1, $v0			# length ($a1) = ($v0) readArray(numbers)
la $a0, numbers

jal reverseArray		# reverseArray is called
jal printArray			# printArray is called
jal reverseArray		# reverseArray is called
jal printArray			# printArray is called

addi $t0, $t0, 1		# $t0 = $t0 + 1
j loop				# jump to loop

loopend:
jr $ra				# return from main

############################################################################
# Procedure readArray
# Description: Reads in elements and puts them into the array numbers
# parameters: $a0 = address of array 
# return value: $v0 = i
# registers to be used: $t0 - $t3
############################################################################
readArray:
addi $sp, $sp, -4		# stack pointer is moved down
sw $ra, 0($sp)			# return address for readArray is saved

move $t0, $a0
li $t1, 0			# ($t1) i = 0
la $a0, prompt1
li $v0, 4
syscall

li $v0, 5
syscall

move $t2, $v0

loop1:
bgt $t1, $t2, loop1end
bgt $t1, 9, loop1end

sll $t3, $t1, 2			# $t3 (offset) = $t1 * 4
add $t3, $t3, $t0		# $t3 = $t3 + $t0
lw $t3, 0($t3)			# $t3 = array[i]

la $a0, prompt2
li $v0, 4
syscall

li $v0, 5
syscall

move $t3, $v0
addi $t1, $t1, 1

j loop1

loop1end:
move $v0, $t1

lw $ra, 0($sp)			# return address for main is copied back
addi $sp, $sp, 4		# stack pointer is moved up
jr $ra

############################################################################
# Procedure reverseArray
# Description: Reverses the numbers array
# parameters: $a0 = address of array, $a1 = length
# return value: void
# registers to be used: $t0 - $t6
############################################################################
reverseArray:
li $t0, 0			# i = 0
li $t1, 0			# temp = 0

addi $t5, $a1, 1
li $t2, 2
div $t5, $t2
mflo $t3

loop2:
slt $t4, $t0, $t3
beq $t4, $0, loop2end

sll $t4, $t0, 2			# $t4 (offset) = $t0 * 4
add $t4, $t4, $a0		# $t4 = $t4 + $a0
lw $t4, 0($t4)			# $t4 = array[i]


addi $t0, $t0, 1

j loop2

loop2end:

la $a0, arrayreversed
li $v0, 4
syscall

jr $ra

############################################################################
# Procedure printArray
# Description: Prints the numbers array
# parameters: $a0 = address of array, $a1 = length
# return value: void
# registers to be used: $t0 - $t2
############################################################################
printArray:
move $t0, $a0
li $t1, 0

la $a0, arraycontent
li $v0, 4
syscall

loop3:
slt $t2, $t1, $a1
beq $t2, $0, loop3end

sll $t2, $t1, 2			# $t2 (offset) = $t1 * 4
add $t2, $t2, $t0		# $t2 = $t2 + $t0
lw $t2, 0($t2)			# $t2 = array[i]


move $a0, $t2
li $v0, 1
syscall

addi $t1, $t1, 1
j loop3

loop3end:
jr $ra