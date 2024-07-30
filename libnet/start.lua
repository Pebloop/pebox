local libnet = require('libnet')

print('Enter the ip address: ')
local ip = io.read()
print('Enter the port number: ')
local port = io.read()
print(libnet.getReadableAddress(port, ip))