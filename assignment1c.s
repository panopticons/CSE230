#################################################################
# Assignment #: 1
# Name: Maria Castro
# ASU email: Maria.F.Castro@asu.edu
# Course: CSE 230 MWF 1:30
# Description: This program prints "This is my first MIPS code.
#              I will eventually write more MIPS code."
#################################################################

# the data section below contains all variables used in the program

.data
message1: .asciiz "This is my first MIPS code.\n"		# message1 is string "This is my first MIPS code.\n"
message2: .asciiz "I will eventually write more MIPS code.\n"	# message2 is string "I will eventually write more MIPS code.\n"

# code starts after text section

.text
.globl main	# global function main is defined

# program execution begins
main:
la $a0, message1	# address of message1 is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called

la $a0, message2	# address of message2 is loaded into $a0
li $v0, 4		# 4 is loaded into $v0 to call print_string()
syscall			# print_string() is called again
jr $ra			# return, end of main