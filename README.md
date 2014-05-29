bxl_to_eagle
============

Note: This code DOES NOT WORK!

This was an attempt at decoding the bxl files from Ultra Librarian.

I read somewhere that bxl files are Huffman encoded and that the first 4 bytes are the length of the original uncompressed file. But from what I understand that's not enough information to actually decode these files.

To actually decode Huffman encoded files we need the actual Huffman, binary probability tree holding all the characters from the original file. I do not know if the probability trees are stored in the bxl file themselves or if the Ultra Librarian is using a single probability tree for all of it's bxl files.

In either case, at the present, we don't actually have enough information to extract bxl files ourselves.

The next step would be to reverse engineer Ultra Librarian a bit and see if we can figure out where it's getting the Huffman tree from. Once we have that, we'd have to modify the coder.rb or build our own decoder to read in the tree.

coder.rb
========

By the way, I yanked the coder.rb from https://github.com/lithium3141/HuffmanCoding

I also modified it slightly to deal with ASCII-8BIT formatted inputs instead of UTF-8. I also put a simple error check in case the returned byte didn't make sense in the charactor set...



