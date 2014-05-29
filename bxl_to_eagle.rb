# You'll need: git@github.com:lithium3141/HuffmanCoding.git
require './coder.rb'
# require 'file'

puts "This shouldn't be all that hard..."

# Load the file
filename = "./MCP4822-X_P.bxl" # 296091648
file = open(filename,"rb")

# Pull off the first 4 bytes as the length of the original file
original_length = file.read(4)
length_array = original_length.bytes.map { |n| n.to_s(16) }
puts "The first four bytes (in hex) are: #{length_array}"
puts "That's the original files length (in bytes): #{original_length.unpack('L>').first}" # L is 32 bit, > is Big endian


##===============
## Let's output the first four bytes in HEX just to make sure we're on the right track:
# og_hex_length = []
# original_length.each do |byte|
# 	og_hex_length << byte.to_s(16)
# end	
# puts "First four converted into hex: #{og_hex_length}"
##===============

##===============
## To check the bxl file format, let's try validating the size of the original file based on the EAGLE
## file output by the REAL bxl reader software:
# expected_file = "./2014-05-28_10-36-23_Library.scr"
# correct_file = File.new(expected_file,"r")
# whole_correct_file = correct_file.read.bytes.to_a
# puts "Expected file length: #{whole_correct_file.length}" # OOPS! This is 3301 which is way off.
## What this tells us is that the first four bytes of the bxl file is NOT the full length of the output
## but it is probably the full length of the decoded file that has CHUNKS of CAD files IN it!
##
## So, we need to just try reading the whole damn thing. Whatever.
##===============

# Read the rest of the file (We already seeked paste the first 4 bytes!)
whole_file = file.read.bytes.to_a
# puts "Whole file: #{whole_file}"

# Convert each byte in the file into binary:
# "a".bytes.to_a.first.to_s(2).rjust(8, '0') # This will be: "01100001" which is 'a' converted to binary
whole_file_binary = []
whole_file.each do |byte|
	whole_file_binary << byte.to_s(2).rjust(8, '0')
end	
puts "Whole compressed file size: #{whole_file_binary.length}"
puts "First file byte in binary: #{whole_file_binary.first}"

# Make a string of all the bytes... man this is gonna be long...

full_encoded_file = whole_file_binary.join('')
# puts "Whole damn compressed file as a big long binary string!: #{full_encoded_file}"

# Decode it using this HuffmanCoder and hope the system doesn't run out of memory!
puts "Attempting extraction... This takes a while..."
extracted_file = HuffmanCoder.decode(full_encoded_file.to_s)
puts "Full extracted file: #{extracted_file.plaintext.to_s}"
puts "Full extracted file size: #{extracted_file.plaintext.to_s.length}"



# Oops that didn't work:
# encoded = HuffmanCoder.encode("ab")
# 0 1 01100001 1 01100010 01
# 0 is parent node
# 1 is leaf node followed by 8 bits of ascii
# puts "Encoded: #{encoded.to_s}"
# puts "Encoded: #{encoded.ciphertext.to_s}"

# encoded = '0100100000101100001101' # This represents the "a a" string encoded into individual bits
# decoded = HuffmanCoder.decode(encoded.to_s)
# puts "Decoded: #{decoded.plaintext.to_s}"



exit

