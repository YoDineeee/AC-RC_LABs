#.  1) Program  to  calculate  the  binary,  octal,  and  hexadecimal  equivalent  of  a given natural number entered from the keyboard.

number = int(input("Enter a natural number: "))
binary = bin(number)[2:]       
octal = oct(number)[2:]        
hexadecimal = hex(number)[2:].upper()  


print("Binary   :", binary)
print("Octal    :", octal)
print("Hexadecimal:", hexadecimal)



