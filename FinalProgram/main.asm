COMMENT @
Name: Xavid Ramirez
Course: CSCI 2333 - 01
Program Name: Program 2_A
Description:
@


TITLE MASM Template						(main.asm)

											;Included irvine 
INCLUDE Irvine32.inc

											;The data section will hold all the variables I will need in the program
.data
mySpace	BYTE	",  ",	 0
DisplayM	BYTE	"The triple values are in the following order x, y, z:",	0	; this is my text display

U	DWORD	2											;Holds value of U
V	DWORD	?											;Holds value of V
CommonDenom	DWORD	?									;Holds the value of GCD = greatest common divisor. 

X	DWORD	?											;Holds value of X
Y	DWORD	?											;Holds value of Y
Z	DWORD	?											;Holds value of Z

.code

main PROC												;Main Program begins here
	
	call	Clrscr										;Clearing the screen first

	mov	U,	2											;Putting 2 into U
	mov	eax,	U										;Putting Uinto eax, I could have skipped this but I decided to leave it in. 
	DO1:
			AND	eax,	1								;And eax and 1, if the value returns 1 then the value is odd else it is even
			jnz	else1									;jump if the value is not zero to else 1 which means the value is odd
			mov	V,	1									;if value is even then put 1 into V
			jmp	endif1									; jump to endif1 to avoid the else condition
		else1:											; the else condition if the value of U is odd
			mov	V,	2									; move 2 into V if U is odd
		endif1:											; end of if statment

			DO2:										; inner loop
				mov	eax,	U							;getting U ready to be passed into GCD
				mov	ebx,	V							;getting V ready to be passed into GCD
				call	GCD								;Calling GCD
				mov	eax,	CommonDenom					;gcd returns a value into commondenom so i put that into eax
				cmp	eax,	1							; compare and check if it is equal to 1
				jne	afterin1							; if the value of common denom which is in eax is not equal to 1 go to elsecondition
					mov	eax,	U						; preparing U to be passed into Tripple if, if condition was true
					mov	ebx,	V						; preparing V to be passed into triple.
					call	TRIPLE						;Call tripple
					
				afterin1:								; condition to skip over if statement
					INC	V								;increment V twice
					INC	V								; which is equal to V = V + 2
				
				condition:								;this is the condition section for the do while of the inner loop "While V < U"
					mov	ebx,	U						; put U into ebx
					mov	eax,	V						; put V into eax
					cmp	eax,	ebx						; compare U and V which are in ebx and eax
					jna	DO2								;if V is not above U then jump to the begining of the inner loop "DO2"
					jmp exitInLoop						;jump to exitInLoop if value of V is greater than U
			Loop DO2									;loop DO2 end

				exitInLoop:								;section to get out of inner loop
					INC	U								;incrementing U which is U = U + 1
					mov	eax, U
					
		cmp	eax,	10									;Compare eax which is U and 10
		jl	DO1											;if Uis less than 10 then jump to lable of first loop
		jmp ExitOutLoop									;if U is not less than 10 then jump out of the entire loop
	Loop DO1											;end labe for DO1 which is the first loop

	ExitOutLoop:										;where to jump out of loop


	call ReadInt										;I am calling readint just so you can see the display of values. 
	exit
main ENDP

;////////////////////////////////////////////////////
GCD PROC

		mov	ecx,	ebx									;setting b as counter of loop
	DO1:
		cmp	ebx,	0									;compare B and 0, B is ebx which is passed in as V
		je	exitthis									;Checks if is equal to 0
		CDQ												;convert double to quad in preparation for division
		DIV	ebx											;Divide by B 
		mov	eax,	edx									; put EDX which holds remainder in EAX
		xchg	eax,	ebx								;exchange value of B with eax
													
	Loop DO1											;End of DO1 Loop

	exitthis:
		mov	CommonDenom,	eax							;so put A into eax and that value put it into gcd variable
		ret												;return case

GCD	ENDP
;////////////////////////////////////////////////////
TRIPLE PROC
	;////process for x
	push	eax											;Push eax and store it sicne it holds original U value
	push	ebx											;Push ebx and store it since it holds original V value
	CDQ													;convert double to quad and prepair for multiplication
	mul	eax												;multiply eax with eax, or U * U
	mov	ecx,	eax										; put eax into ecx temporarily
	mov	eax,	ebx										; put ebx into eax
	CDQ													;convert double to quad in preparation for multiplication
	mul	ebx												;multiply eax and ebx so V*V
	xchg	eax,	ecx									;exchange ecx and eax so its not V*V - U*U rather its U*U - V*V
	sub	eax,	ecx										;subtracting Usquared and Vsquared
	mov	X,	eax											;move result into X
	;////end process for x

	pop	ebx												;pop ebx which was pushed last so it holds V
	pop	eax												;pop int eax which was pushed first so it holds U
	push	ebx											;push again to store it
	push	eax											;push again to store it for later use
	CDQ													;convert double to quad for multiplication
	mul	ebx												;multiply eax and ebx so U * V
	mov	ebx,	2										;put 2 into ebx since when i tried to multiply eax * 2 with imul it broke
	mul	ebx												;multiply eax and ebx
	mov	Y,	eax											;move the eax value into Y
	;///end process for y

	pop	ebx												;put V into ebx since it was pushed into it 
	pop	eax												;Put U into eax from stack
	CDQ													;convert double to quad for multiplication
	mul	eax												;multiply eax and eax or U * U
	mov	ecx,	eax										;put eax into ecx temporarily
	mov	eax,	ebx										;put ebx into eax
	CDQ													;convert double to quad
	mul	ebx												;multiply eax and ebx or V*V
	add	eax,	ecx										; and eax and ecx or V*V + U*U in this case its addition so I didnt switch them
	mov	Z,	eax											; move eax or result into Z
	;////end process for z

	mov	eax,	X										;move x into eax
	mov	ebx,	Y										;move Y into ebx
	cmp	eax,	ebx										;compare x and y
	jng	exitIf											;if x is less than y then jump to exitIf, else
	xchg	eax,	ebx									;exchange x and y

									;I realized i could make Tripple so much easier but since this worked i prefered not to tinker with it. 


	;I rather not explain this section, all it is is I am printing out the values and making them look pretty on screen.
	;all I did is printed a sentence and the values adfter it in coresponding order.

	exitIf:
		mov	edx,	OFFSET	DisplayM
		call WriteString

		mov	edx,	OFFSET	mySpace
		call WriteString
		mov	eax,	X
		call	WriteInt
		mov	edx,	OFFSET	mySpace
		call WriteString

		mov	eax,	Y
		call	WriteInt
		mov	edx,	OFFSET	mySpace
		call WriteString


		mov	eax,	Z
		call	WriteInt
		call	Crlf	

		ret

TRIPLE ENDP
;////////////////////////////////////////////////////
END main