local libnet = require("../libnet")

print("(get channel) 0 : id 6")
local testId = 6
local result = libnet.getChannel(testId)
assert(result == "0006", "Test failed")

print("(get channel) 1 : id 16")
local testId = 16
local result = libnet.getChannel(testId)
assert(result == "0010", "Test failed")

print("(get channel) 2 : id 256")
local testId = 256
local result = libnet.getChannel(testId)
assert(result == "0100", "Test failed")

print("(get channel) 3 : id 4096")
local testId = 4096
local result = libnet.getChannel(testId)
assert(result == "1000", "Test failed")

print("(get channel) 4 : id 65535")
local testId = 65535
local result = libnet.getChannel(testId)
assert(result == "ffff", "Test failed")

print("(get channel) 5 : id 0")
local testId = 0
local result = libnet.getChannel(testId)
assert(result == "0000", "Test failed")

print("(get channel) 6 : id 46685")
local testId = 46685
local result = libnet.getChannel(testId)
assert(result == "b6fd", "Test failed")

print("Tests passed")