################################################################ 
#  Ben Lufuta
#  Project2: Shipping
#  Date: 10/23/2023
###############################################################	
.include "macros.asm" # Include the macro file

	.data

# Strings that will be used to print output to the console for the user.
Greeting:    	  .asciiz    "Welcome to Ben Lufuta Shipping\n"  # ascii string for greeting
PromptVolume:     .asciiz    "Please enter package volume in cubic inches between 1 and 8000: "   # ascii string for prompting  the volume of the package
PromptWeight:     .asciiz    "Please enter package weight in pounds between 1 and 100: "  # ascii string for prompting the  weight of  the package
DisplayOptions:   .asciiz     "\n 1) Ground 5-10 business days  \n 2) Super  saver air  2-4  business days   \n 3) Next day air    \nPlease select your shipping speed. Enter 1, 2 , or 3: "
AnotherShipping:  .asciiz    "\nDo you want to ship another package? Enter 1 for Yes or 0 for No:  "
InvoiceMessage:   .asciiz    "Shipping Invoice"
PackageVolume:    .asciiz    "\nPackage volume in cubic inches: "
PackageWeight:	  .asciiz    "\nPackage weight in pounds: "
ShipVia:	  .asciiz    "\nShip via: "
Ground:		  .asciiz    "Ground"
SSA:		  .asciiz    "Super Saver Air"
NDA:		  .asciiz    "Next Day Air"

Cost:		  .asciiz    "\nCost: $"
GoodbyeMessage:   .asciiz   "Goodbye."

lowestRange:		.word 1
volHighRange:		.word 8000
weightHighRange:	.word 100
optionHighRange:	.word 3

	.text # Text segment

main:    #start of main method
	
			
loopGreeting:

	lw $s0, lowestRange 		#load register $s0 with 1
	lw $s1, volHighRange		#load register $s1 with 8000
	lw $s2, weightHighRange		#load register $s2 with 100
	lw $s3, optionHighRange		#load register $s3 with 3

	printString(Greeting)        # Display Greeting to the user  
         
loopVolume:
	printString(PromptVolume)    # Prompt user for  volume 
	readInt             	     # receive the volume from the user
         move    $s4,    $v0         # save the value received from the user  n  register  $s4
	
	slt $t0, $s4, $s0	     #If $s4 is less than $s0 then set $t0 to 1, otherwise 0	
	sgt $t1, $s4, $s1	     #If $s4 is greater than $s1 then set $t0 to 1, otherwise 0
	
	or $t0, $t0, $t1	     #Set $t0 to bitwise OR of $t0 and $t1
	
	bnez $t0, loopVolume 	     #If the result of $t0 is not equal to zero, then ask for the volume again
				     #Because it means that the entered number is less than 1 or greater than 8000
	
	

loopWeight:
	printString(PromptWeight)   # Prompt user for  weight
        readInt             	    # receive the weight from the user 
        
        move    $s5,    $v0         # save the value received from the user  n  register  $s5
	
	slt $t0, $s5, $s0	    #If $s5 is less than $s0 then set $t0 to 1, otherwise 0
	sgt $t1, $s5, $s2	    #If $s5 is greater than $s1 then set $t0 to 1, otherwise 0
	
	or $t0, $t0, $t1	    #Set $t0 to bitwise OR of $t0 and $t1
	
	bnez $t0, loopWeight	    #If the result of $t0 is not equal to zero, then ask for the volume again
				    #Because it means that the entered number is less than 1 or greater than 100
	
loopChoice:
	printString(DisplayOptions) 
	readInt             	    # receive the weight from the user 
        
        move    $s6,    $v0         # save the value received from the user  in  register  $s6
	
	slt $t0, $s6, $s0	    #If $s6 is less than $s0 then set $t0 to 1, otherwise 0
	sgt $t1, $s6, $s3	    #If $s6 is greater than $s1 then set $t0 to 1, otherwise 0
	
	or $t0, $t0, $t1	    #Set $t0 to bitwise OR of $t0 and $t1
	
	bnez $t0, loopChoice	    #If the result of $t0 is not equal to zero, then ask for the volume again
				    #Because it means that the entered number is less than 1 or greater than 100
				    
	
	beq $s6, 1, shippingInvoice1 #Proceed with this branch if the use choice is equal to 1
	beq $s6, 2, shippingInvoice2 #Proceed with this branch if the use choice is equal to 2
	beq $s6, 3, shippingInvoice3 #Proceed with this branch if the use choice is equal to 3
	
	
shippingInvoice1:

	printString(InvoiceMessage) #Print the invoice message.

	sle $t3, $s4, 1000	#If $s4 is less or equal to 1000 then set $t3 to 1, otherwise 0
	sle $t4, $s5, 60	##If $s5 is less or equal to 60 then set $t3 to 1, otherwise 0
	
	and $t2, $t3, $t4	#Set $t2 to bitwise AND of $t3 and $t4
	
	beqz $t2, grndShipOptionTwo	#Execute this branch if the result of $t2 is equal to zero
	
	bnez $t2, grndShipOptionOne	#Execute this branch if the result of $t2 is not equal to zero
	
	j loopShipAgain
	
shippingInvoice2:

	printString(InvoiceMessage)  #Print the invoice message.
	
	sle $t3, $s4, 1000	#If $s4 is less or equal to 1000 then set $t3 to 1, otherwise 0
	sle $t4, $s5, 40	#If $s5 is less or equal to 40 then set $t3 to 1, otherwise 0
	
	and $t2, $t3, $t4	#Set $t2 to bitwise AND of $t3 and $t4
	
	beqz $t2, superSaveShipOptionTwo     #Execute this branch if the result of $t2 is equal to zero
	
	bnez $t2, superSaveShipOptionOne    #Execute this branch if the result of $t2 is not equal to zero

shippingInvoice3:
		
	printString(InvoiceMessage)  #Print the invoice message.
	
	sle $t3, $s4, 1000	#If $s4 is less or equal to 1000 then set $t3 to 1, otherwise 0
	sle $t4, $s5, 30	#If $s5 is less or equal to 40 then set $t3 to 1, otherwise 0
	
	and $t2, $t3, $t4	#Set $t2 to bitwise AND of $t3 and $t4
	
	beqz $t2, nextDayShipOptionTwo    #Execute this branch if the result of $t2 is equal to zero
	
	bnez $t2, nextDayShipOptionOne    #Execute this branch if the result of $t2 is not equal to zero

grndShipOptionOne:
	li $s1, 8  #Remove the previous value in $s1, and load it now with 8
	printString(PackageVolume)
	printInt($s4) #Pring the package volume
	printString(PackageWeight)
	printInt($s5) #Print the package weight
	printString(ShipVia)
	printString(Ground) #Print the shipping method chosen
	printString(Cost)
	printInt($s1) #Pring cost
	j loopShipAgain #If we get here, jump all the way to loopShipAgain and then proceed.
	
grndShipOptionTwo:
	li $s1, 12 #Remove the previous value in $s1, and load it now with 12
	printString(PackageVolume)
	printInt($s4) #Pring the package volume
	printString(PackageWeight)
	printInt($s5) #Print the package weight
	printString(ShipVia)
	printString(Ground) #Print the shipping method chosen
	printString(Cost)
	printInt($s1) #Pring cost
	j loopShipAgain #If we get here, jump all the way to loopShipAgain and then proceed.
	
superSaveShipOptionOne:
	li $s1, 12  #Remove the previous value in $s1, and load it now with 12
	printString(PackageVolume)
	printInt($s4) #Pring the package volume
	printString(PackageWeight)
	printInt($s5) #Print the package weight
	printString(ShipVia)
	printString(SSA) #Print the shipping method chosen
	printString(Cost)
	printInt($s1) #Pring cost
	j loopShipAgain #If we get here, jump all the way to loopShipAgain and then proceed.
	
superSaveShipOptionTwo:
	li $s1, 16 #Remove the previous value in $s1, and load it now with 16
	printString(PackageVolume)
	printInt($s4) #Pring the package volume
	printString(PackageWeight)
	printInt($s5) #Print the package weight
	printString(ShipVia)
	printString(SSA) #Print the shipping method chosen
	printString(Cost)
	printInt($s1) #Pring cost
	j loopShipAgain #If we get here, jump all the way to loopShipAgain and then proceed.
	
nextDayShipOptionOne:
	li $s1, 15 #Remove the previous value in $s1, and load it now with 15
	printString(PackageVolume)
	printInt($s4) #Pring the package volume
	printString(PackageWeight)
	printInt($s5) #Print the package weight
	printString(ShipVia)
	printString(NDA) #Print the shipping method chosen
	printString(Cost)
	printInt($s1) #Pring cost
	j loopShipAgain #If we get here, jump all the way to loopShipAgain and then proceed.
	
nextDayShipOptionTwo:
	li $s1, 25  #Remove the previous value in $s1, and load it now with 25
	printString(PackageVolume)
	printInt($s4) #Pring the package volume
	printString(PackageWeight)
	printInt($s5) #Print the package weight
	printString(ShipVia)
	printString(NDA) #Print the shipping method chosen
	printString(Cost)
	printInt($s1) #Pring cost
	j loopShipAgain #If we get here, jump all the way to loopShipAgain and then proceed.

loopShipAgain:
	   printString(AnotherShipping) #Prompt user if he/she wants to ship anothe package or not
	   readInt             	       # receive the weight from the user 
	   
           move    $s7,    $v0         # save the value received from the user  to  register  $s7 
	   
	   blt $s7, 0, loopShipAgain #If the entered choice is less than 0, go all the way back to loopShipAgain and then proceed again.
           bgt $s7, 1, loopShipAgain #If the entered choice is greater than 1, go all the way back to loopShipAgain and then proceed again.
           
	   beq   $s7, 1, loopGreeting #If the entered number is equal to 1, then go all the way back to the beginning of the program.
	   			      #Otherwise, print a goodbye message and then end the program.
           printString(GoodbyeMessage)
           beq  $s7, 0, done
              
           
#If we get to the lines below, then end program.
done:   	
li    $v0,    10
syscall   
        
