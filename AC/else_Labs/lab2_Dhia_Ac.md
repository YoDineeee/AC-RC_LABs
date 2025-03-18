## LAB2Report
**Name:** Mohamed Dhiaeddine Hassine 
**Group:** FAF-233
## Exercise1 – Variant 13
3)
  a)  0 + 0 + 0 + 1 * 2^4 + 1* 2^4 + 1* 2^5 + 1 * 2^6 + 1 * 2^7 = 248
  b) 0 + 1 * 2^1 + 0 + 1 * 2^3 + 0 + 0 + 1 * 2^6 + 1 * 2^7 = 202
  c) 0 + 0 + 0 + 0 + 1* 2^4 + 1 * 2^5 + 1 * 2^6 + 1 * 2^7 = 248

11)
 a) 1100 1111 0101 0111 = 12 + 15 + 5 + 7 = CF57
 b) 0101 1100 1010 1101 = 5 + 12 + 10 + 13 = 5CAD
 c) 1001 0011   1011 = 9 + 3 + 14 + 11 = 93EB


13) 
a)  E5B6AED7 = 14 + 5 + 11 + 6 + 10 + 14 + 13 + 7 =  1110 0101 1011 0110 1010 1110 1101 0111
b) 6ACDFA95 = 6 + 10 + 12 + 13 + 15 + 10 + 9 + 5 =  0110 1010 1100 1101 1111 1010 1001 0101
c)   F69BFC2A = 15 + 6 + 9 +11 + 15 + 12 + 2 + 10 = 1111 0110 1001 1011 1111 1100 0010 1010

 

 15)
  a)  3A = 3 * 16 + 10 = 58
  b)  1BF = 1* 16^2 + 11 * 16 + 15 = 447
  c)   4096 = 4 * 16^3 + 0 + 9 * 16 + 6 = 16534

## Exercise2
### a)
```python
number = int(input("Enter a natural number: "))
binary = bin(number)[2:]       
octal = oct(number)[2:]        
hexadecimal = hex(number)[2:].upper()

print("Binary   :", binary)
print("Octal    :", octal)
print("Hexadecimal:", hexadecimal)
```
### b)
```
def convert_to_base_q(num_str, p, q):
    try:
        num = int(num_str, p)
    except ValueError:
        raise ValueError(f"The provided number is not valid for base {p}")
    
    if num == 0:
        return "0"
    
    digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    result = ""
    
    while num > 0:
        remainder = num % q
        result = digits[remainder] + result
        num //= q
    
    return result

def main():
    try:
        p = int(input("Enter the base p of the input number (2-36): "))
        q = int(input("Enter the base q to convert to (2-36): "))
    except ValueError:
        print("Bases must be integers.")
        return
    
    if not (2 <= p <= 36):
        print("Base p must be between 2 and 36.")
        return
    if not (2 <= q <= 36):
        print("Base q must be between 2 and 36.")
        return
    
    num_str = input(f"Enter the number in base {p}: ").strip()
    
    try:
        converted = convert_to_base_q(num_str, p, q)
        print(f"The number {num_str} in base {p} is {converted} in base {q}.")
    except ValueError as e:
        print(e)

if __name__ == "__main__":
    main()```