import sys

try:
    # Read input from command line
    user_input = ' '.join(sys.argv[1:])
    
    if not user_input:
        print("Error: No input provided")
        sys.exit(1)
        
    # Append the input to the existing file "succeeded_ips.txt"
    with open("succeeded_ips.txt", "a") as file:
        file.write(user_input + "\n")  # Add a newline after each input
except IOError as e:
    print(f"Error writing to file: {e}")
    sys.exit(1)
except Exception as e:
    print(f"Unexpected error: {e}")
    sys.exit(1)
