COMMENT @
Name: Xavid Ramirez
Course: CSCI 2333 - 01
Program Name: Program 2_B
Description:
@


TITLE MASM Template						(main.asm)

											;Included irvine 
INCLUDE Irvine32.inc

											;The data section will hold all the variables I will need in the program
.data
firstMessage	BYTE	"Enter 10 numbers into the array: " ,0dh,0ah,0				;This will prompt user to enter 10 numbers
secondMessage	BYTE	"Here are the inputed values: " ,0dh,0ah,0					;This will prompt user that the following values are what they inputed. 
thirdMessage	BYTE	"Here is their average: " ,0dh,0ah,0						;prompt users that the following answer is the average.

intArray	DWORD	?,?,?,?,?,?,?,?,?,?												;10 value array uninitialized places
ListSize	=	($	-	intArray)	/	4											;size of array, I used 4 to divide because it is  a dword
total	DWORD	?																	;will hold the total of the added values of the array
average	DWORD	?																	;will hold average

ptrA	DWORD	intArray															;this pointer points to the intarray

.code

main PROC
	
	call	Clrscr

	
		mov	edx,	OFFSET	firstMessage		;Printing out the enter message
		call	WriteString

		mov	ecx,	10							;ecx is counter

	FillArray:									;this loop will asist with user inputing data into the array

		call	ReadInt
		mov	[ptrA],	eax							;put data in array in place of offset

		add	ptrA,	4							;increment pointer place

	Loop FillArray

		mov	ptrA,OFFSET	intArray				;offset ptrA to intarray
		mov edx,	[ptrA]						;copy first position of intarray into edx
		mov ecx,	9							;set loop counter to 9 since first there is no addition, we just move first value to edx

	AddArray:									;this loop adds the contents of the array to eachother

		add	ptrA,	4							;increment ptrA by 4 which is qword size
		add	eax,	[ptrA]						;add whatever is in eax and ptrA position of array

	Loop AddArray
	
		mov	total,	eax							; let total hold the sum of all values of array temporarily

	mov	edx,	OFFSET	secondMessage			;Printing out the list message
	call	WriteString

	mov	ptrA,OFFSET	intArray					;offset ptrA to intArray
	mov	ecx,	10								; set loop counter to 10

	displayArray:								;this loop displays the contents of the array

		mov	eax,	[ptrA]						;put array value into eax
		call	WriteInt
		add	ptrA,	4							;increment offset place
		call	Crlf							;new line

	Loop displayArray

	mov	edx,	OFFSET	thirdMessage			;Printing out the list message
	call	WriteString

		mov	edx,	0000						;making sure edx has no garbage that will make quotent wrong
		mov	eax,	total						;put total into eax so we can prepare to divide EDX:EAX by ecx
		mov	ecx,	ListSize					; Put listsize into ecx

		div	ecx									;divide EDX:EAX by ECX
		mov	average,	eax						;store average that is in eax into the average variable

	call	WriteInt							;print out average
	call	ReadInt								;called readint again so I could see the output but it does nothing when you hit enter but exit the program

	exit
main ENDP

END main