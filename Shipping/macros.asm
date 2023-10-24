# macros

# end program macro
        .macro    done # macro name done
        li    $v0,    10
        syscall
        .end_macro

# print string
        .macro    printString(%String) # macro namame
        li    $v0,    4 # print string system call
        la    $a0,    %String    # put string into print string system call
        syscall
        .end_macro

# # Read the string. 
    
	.macro    readString # macro name
	li $v0, 8
	syscall # read string
        .end_macro


# print integer
        .macro    printInt(%integer) # print integer
        li    $v0,    1    # print integer system call command
        move    $a0,    %integer # move the integer into the system call data
        syscall    # print the integer
        .end_macro


# Read integer
        .macro    readInt # macro name
        li    $v0,    5 # read integer command
        syscall # read integer
        .end_macro
        
