#################################################################
# Assignment #: 4
# Name: Maria Castro
# ASU email: Maria.F.Castro@asu.edu
# Course: CSE 230 MWF 1:30
# Description: This program reads in a number of months to rent 
# an apartment and a number of rooms that apartment must have. A
# total rent is calculated by the numbers supplied by the user.  
#################################################################

.data
prompt: .asciiz "Please enter a number of months to rent an apartment:\n"

prompt1: .asciiz "Would you like to rent an apartment of one bedroom or two bedrooms?\nPlease enter 1 or 2:\n"

sorry: .asciiz "Sorry, we have only one or two bedroom apartments.\n"

totalrent: .asciiz "Your total rent: "
totalrent1: .asciiz " dollars for "
totalrent2: .asciiz " months.\n"

.text
.globl main			# global function main is declared

main:
la $a0, prompt			# address of prompt is loaded into $a0
li $v0, 4			# 4 is loaded into $v0 to call print_string()
syscall				# print_string() is called

li, $v0, 5			# 5 is loaded into $v0 to call read_int()
syscall				# read_int() is called

move $s1, $v0			# $v0 is moved to $s1 - number of months

la $a0, prompt1			# address of prompt1 is loaded into $a0
li $v0, 4			# 4 is loaded into $v0 to call print_string()
syscall				# print_string() is called

li, $v0, 5			# 5 is loaded into $v0 to call read_int()
syscall				# read_int() is called

li $s3, 1			# load 1 into $s3 for comparison
slti $t1, $v0, 1		# $t1 is given the value of 1 if $v0 less than 1
beq $t1, $s3, case1		# if $t1 is 1 then the statement branches to case1 
bgt $v0, 2, case1		# the statement also branches to case1 if $v0 is greater than 2

move $s2, $v0			# $v0 is moved to $s2 - number of rooms
j case2				# jump to case2

case1:	la $a0, sorry		# address of sorry is loaded into $a0
	li $v0, 4		# 4 is loaded into $v0 to call print_string()
	syscall			# print_string() is called
	jr $ra

case2:	bne $s2, 1, case3	# if $s2 is not equal to 1, go to else1
 	slt $t4, $0, $s1	# $t4 is set to 1 if
	bne $t4, 1, case3	# if $t4 is not equal to 1, go to else1
	slt $t4, $s1, 6		
	bne $t4, 1, case3	# if $t4 is not equal to 1, go to else1
	li $t5, 600		
	mult $t5, $s1
	mflo $s0
	j end			# jump to end

case3:	li $t0, 5
	bne $s2, 1, case4
	slt $t4, $t0, $s1
	bne $t4, 1, case4
	li $t1, 600
	mult $t1, $s1
	mflo $s0
	j end 

case4:	bne $s2, 2, case5
	slt $t4, $0, $s1
	bne $t4, 1, case5
	slt $t4, $s1, 6
	bne $t4, 1, case5
	li $t5, 900
	mult $t5, $s1
	mflo $s0	
	j end			# jump to end

case5:	li $t0, 5
	bne $s2, 2, case6
	slt $t4, $t0, $s1
	bne $t4, 1, case6
	li $t1, 600
	mult $t1, $s1
	mflo $s0
	j end 	

case6:
	li $s0, 0
	j end			# jump to end

end:
la $a0, totalrent		# address of totalrent is loaded into $a0
li $v0, 4			# 4 is loaded into $v0 to call print_string()
syscall				# print_string() is called

add $a0, $s0, $0		# $a0 = totalRent
li $v0, 1			# 1 is loaded into $v0 to call print_int()
syscall				# print_int() is called

la $a0, totalrent1		# address of totalrent1 is loaded into $a0
li $v0, 4			# 4 is loaded into $v0 to call print_string()
syscall				# print_string() is called

add $a0, $t0, $0		# $a0 = number of rooms
li $v0, 1			# 1 is loaded into $v0 to call print_int()
syscall				# print_int() is called

la $a0, totalrent2		# address of totalrent2 is loaded into $a0
li $v0, 4			# 4 is loaded into $v0 to call print_string()
syscall				# print_string() is called

jr $ra				# end main
