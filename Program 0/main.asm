COMMENT @
Name: Xavid Ramirez
Course: CSCI 2333 - 01
Program Name: Program 0
Description:
@


TITLE MASM Template						(main.asm)

											;Included irvine 
INCLUDE Irvine32.inc

											;The data section will hold all the variables I will need in the program
.data
myMessage1	BYTE	"Please Enter some Integers: " ,0dh,0ah,0
myMessage2	BYTE	"Here are the entered values: " ,0dh,0ah,0
myMessage3	BYTE	"This is the total: " ,0dh,0ah,0
											
											;This is where i store text for printing out what each variable is. 
myMessageA	BYTE	"A1: " ,0
myMessageB	BYTE	"B1: " ,0
myMessageC	BYTE	"C1: " ,0
myMessageD	BYTE	"D1: " ,0

											;These are the variables that will hold the integers. 
A1 DWORD ?
B1 DWORD ?
C1 DWORD ?
D1 DWORD ?

.code

main PROC
	
	call	Clrscr

	
	mov	edx,	OFFSET	myMessage1			;Printing out the enter message
	call	WriteString

	call	ReadInt							;calling readint and putting a value into A1
	mov	A1,	eax

	call	ReadInt							;calling readint and putting a value into B1
	mov	B1,	eax
		
	call	ReadInt							;calling readint and putting a value into C1
	mov	C1,	eax

	call	ReadInt							;calling readint and putting a value into D1
	mov	D1,	eax


	mov	edx,	OFFSET	myMessage2			;specify that i am priting out each value

	mov	edx,	OFFSET	myMessageA			;Printing out A1
	call	WriteString
	mov	eax,	A1							
	call	WriteInt

	call Crlf								;New line

	mov	edx,	OFFSET	myMessageB			;Printing out B
	call	WriteString
	mov	eax,	B1							
	call	WriteInt

	call Crlf								;New line

	mov	edx,	OFFSET	myMessageC			;Printing out C
	call	WriteString
	mov	eax,	C1							
	call	WriteInt

	call Crlf								;New line

	mov	edx,	OFFSET	myMessageD			;Printing out D
	call	WriteString
	mov	eax,	D1							
	call	WriteInt

	call Crlf								;New line
	call Crlf								;New line


	mov	eax,	A1							;Move A1 to eax so it is ready to be subracted from

	sub	eax,	B1							;subtract eax which holds A1 and B1 and put it in eax

	
	add	eax,	C1							;Add the result of the subtraction of A1 and B1 which is in eax
											;and add C1 to it and place result in eax.

	sub	eax,	D1							;subtract value in eax with D1 and put result in eax

	mov	edx,	OFFSET	myMessage3			;specify that I am priting out the total. 
	call	WriteString

	call	WriteInt						;Print out the solution to the expression.


	call ReadInt
	mov	eax,	A1

	exit
main ENDP

END main