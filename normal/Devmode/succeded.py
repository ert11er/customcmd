import sys

# Read input from command line
user_input = ' '.join(sys.argv[1:])

# Append the input to the existing file "succeeded_ips.txt"
with open("succeeded_ips.txt", "a") as file:
    file.write(user_input + "\n")  # Add a newline after each input
