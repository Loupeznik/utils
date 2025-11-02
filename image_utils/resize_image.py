#!/usr/bin/env python3

import argparse
import sys
from pathlib import Path
from PIL import Image


def resize_image(input_path, output_path, width=None, height=None, percentage=None):
    try:
        img = Image.open(input_path)

        if img.format != 'PNG':
            print(f"Error: Input file is not a PNG image (format: {img.format})")
            return False

        original_width, original_height = img.size

        if percentage:
            new_width = int(original_width * (percentage / 100))
            new_height = int(original_height * (percentage / 100))
        elif width and height:
            new_width = width
            new_height = height
        elif width:
            new_width = width
            new_height = int(original_height * (width / original_width))
        elif height:
            new_width = int(original_width * (height / original_height))
            new_height = height
        else:
            print("Error: Must specify either width, height, or percentage")
            return False

        resized_img = img.resize((new_width, new_height), Image.Resampling.LANCZOS)
        resized_img.save(output_path, 'PNG')

        print(f"Image resized from {original_width}x{original_height} to {new_width}x{new_height}")
        print(f"Saved to: {output_path}")
        return True

    except FileNotFoundError:
        print(f"Error: Input file not found: {input_path}")
        return False
    except Exception as e:
        print(f"Error: {str(e)}")
        return False


def main():
    parser = argparse.ArgumentParser(
        description='Resize PNG images by dimensions or percentage',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog='''
Examples:
  %(prog)s input.png -p 50                    # Resize to 50%% of original size
  %(prog)s input.png -w 800                   # Resize to width 800px, maintain aspect ratio
  %(prog)s input.png -h 600                   # Resize to height 600px, maintain aspect ratio
  %(prog)s input.png -w 800 -h 600            # Resize to exact dimensions
  %(prog)s input.png -p 75 -o output.png      # Resize to 75%% and save to output.png
        '''
    )

    parser.add_argument('input', type=str, help='Input PNG file path')
    parser.add_argument('-w', '--width', type=int, help='New width in pixels')
    parser.add_argument('-H', '--height', type=int, help='New height in pixels')
    parser.add_argument('-p', '--percentage', type=float, help='Resize percentage (e.g., 50 for 50%%)')
    parser.add_argument('-o', '--output', type=str, help='Output file path (default: input_resized.png)')

    args = parser.parse_args()

    input_path = Path(args.input)

    if not input_path.exists():
        print(f"Error: Input file does not exist: {input_path}")
        sys.exit(1)

    if args.output:
        output_path = Path(args.output)
    else:
        output_path = input_path.parent / f"{input_path.stem}_resized{input_path.suffix}"

    if args.percentage:
        if args.width or args.height:
            print("Error: Cannot specify both percentage and dimensions")
            sys.exit(1)
        success = resize_image(input_path, output_path, percentage=args.percentage)
    elif args.width or args.height:
        success = resize_image(input_path, output_path, width=args.width, height=args.height)
    else:
        print("Error: Must specify either --percentage, --width, or --height")
        parser.print_help()
        sys.exit(1)

    sys.exit(0 if success else 1)


if __name__ == '__main__':
    main()
