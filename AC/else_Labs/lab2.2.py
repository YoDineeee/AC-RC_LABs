def convert_to_base_q(num_str, p, q):
    
   
    try:
        num = int(num_str, p)
    except ValueError:
        raise ValueError(f"The provided number is not valid for base {p}")
    
    # Special case for 0
    if num == 0:
        return "0"
    
    digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    result = ""
    
    # Convert the integer to the target base q.
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
    
    # Read the number in base p as a string.
    num_str = input(f"Enter the number in base {p}: ").strip()
    
    try:
        converted = convert_to_base_q(num_str, p, q)
        print(f"The number {num_str} in base {p} is {converted} in base {q}.")
    except ValueError as e:
        print(e)

if __name__ == "__main__":
    main()