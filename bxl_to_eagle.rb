# I took the coder.rb from: git@github.com:lithium3141/HuffmanCoding.git
#
# Thanks to lithium3141 for "letting me" borrow their code...
#
# Honestly, this probably isn't the right way to do Huffman decoding for bxl files.
# I read over on DangerousPrototypes in a comment that the first 4 bytes of the bxl
# file is the file length of the original file, before it was compressed into a bxl.
#
# I have no idea if this is true. I doubt this huffman decoding code will work
# correctly given the actual format of bxl files.
#
require './coder.rb'

# Load the file
filename = "./MCP4822-X_P.bxl" # original file length: 296091648
file = open(filename,"rb")

# Pull off the first 4 bytes as the length of the original file
original_length = file.read(4)
length_array = original_length.bytes.map { |n| n.to_s(16) }
puts "The first four bytes (in hex) are: #{length_array}"
puts "That's the original files length (in bytes): #{original_length.unpack('L>').first}" # L is 32 bit, > is Big endian
puts

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

