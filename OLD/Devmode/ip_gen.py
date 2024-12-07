import random
import socket
import struct

def generate_random_ip():
    ip = socket.inet_ntoa(struct.pack('>I', random.randint(1, 0xffffffff)))
    return f"192.168.{ip.split('.')[1]}.{ip.split('.')[2]}"

# Generate 10 random IPs
num_ips = 200
ip_list = [generate_random_ip() for _ in range(num_ips)]

# Save IPs to a text file
with open("ip_list.txt", "w") as file:
    for ip in ip_list:
        file.write(ip + "\n")

print(f"{num_ips} random IPs saved to ip_list.txt")
