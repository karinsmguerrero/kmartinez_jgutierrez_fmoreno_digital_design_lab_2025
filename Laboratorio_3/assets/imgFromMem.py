from PIL import Image

def mem_to_image(mem_filepath, width, height, mode, output_filepath):
    """
    Builds an image from a .mem file.

    Args:
        mem_filepath: Path to the .mem file.
        width: Width of the image.
        height: Height of the image.
        mode: Color mode (e.g., "RGB", "L" for grayscale).
        output_filepath: Path to save the output image.
    """
    with open(mem_filepath, "r") as f:
        mem_data = f.read()
    print(mem_data[0:6])
    img = Image.frombytes(mode, (width, height), mem_data)
    img.save(output_filepath)

# Example usage:
#mem_to_image("ImageMemoryFile/MemoryFile.mem", 90, 90, "RGB", "output_image.png")

import binascii
from PIL import Image

def hex_to_image(hex_data, width, height, output_path):
    """
    Converts hexadecimal data to an image file.

    Args:
        hex_data: A string containing hexadecimal representation of image data.
        width: The width of the image in pixels.
        height: The height of the image in pixels.
        output_path: The path to save the output image file.
    """
    try:
        # Clean the hex data
        hex_data = hex_data.replace(" ", "").replace("\n", "")

        # Convert hex to bytes
        image_bytes = binascii.unhexlify(hex_data)

        # Create a PIL Image object from the bytes
        img = Image.frombytes("RGB", (width, height), image_bytes)

        # Save the image
        img.save(output_path)
        print(f"Image saved to {output_path}")

    except binascii.Error as e:
        print(f"Error decoding hex data: {e}")
    except Exception as e:
         print(f"An error occurred: {e}")

# Example usage:
hex_string = "FFD8FFE000104A46494600010100000100010000FFE100584578696600004D4D002A000008001001000003000000010008000000010F0000000400000001000000011200000300000001000100001A0100050000000100000036280100030000000100010000876900040000000100000046882500020000000100000106C63600020000000100000116828A0005000000010000001E02020004000000010000002602170004000000010000002E829800030000000100010000829A0005000000010000003E00000000FFC00011080001000103012200021101031101FFC4001E000000000000000000000000000000000000101FFC4003710000201030101010101010000000000000102030405060708090A0B100002010204040304070504040001020F000102031104052131FFDA000C03010002110311003F00D28114010A"
image_width = 90
image_height = 90
output_file_path = "output_image2.png"
with open("ImageMemoryFile/MemoryFile.mem", "r") as f:
    mem_data = f.read()
hex_to_image(mem_data, image_width, image_height, output_file_path)
