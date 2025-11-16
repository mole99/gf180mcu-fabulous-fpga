#!/usr/bin/env python

import argparse

def bit_to_hex(input_path, output_path, bytes_per_word=1):

    with open(input_path, 'rb') as file_in:
        with open(output_path, 'w') as file_out:
            data = file_in.read(bytes_per_word)
            while data:
                number = int.from_bytes(data, "big")
                
                file_out.write(f"{number:0{bytes_per_word*2}x}\n")

                data = file_in.read(bytes_per_word)

if __name__ == "__main__":

    parser = argparse.ArgumentParser(description="ikjMatrix multiplication")
    parser.add_argument("input", help="binary input file")
    parser.add_argument("output", help="ascii output file")
    parser.add_argument("--bytes-per-word", type=int, default=1, help="number of bytes for one word")
    args = parser.parse_args()

    bit_to_hex(args.input, args.output, args.bytes_per_word)
