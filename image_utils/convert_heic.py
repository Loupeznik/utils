#!/usr/bin/env python3

import argparse
import sys
from pathlib import Path
from PIL import Image
import pillow_heif


def convert_heic(input_path, output_path, output_format):
    try:
        pillow_heif.register_heif_opener()

        img = Image.open(input_path)

        if output_format.upper() == 'JPG':
            if img.mode in ('RGBA', 'LA', 'P'):
                img = img.convert('RGB')
            img.save(output_path, 'JPEG', quality=95)
        else:
            img.save(output_path, 'PNG')

        print(f"Converted {input_path.name} to {output_format.upper()}")
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
        description='Convert HEIC images to PNG or JPG',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog='''
Examples:
  %(prog)s input.heic                         # Convert to PNG (default)
  %(prog)s input.heic -f jpg                  # Convert to JPG
  %(prog)s input.heic -o output.png           # Convert to PNG with custom output path
  %(prog)s input.heic -f jpg -o output.jpg    # Convert to JPG with custom output path
        '''
    )

    parser.add_argument('input', type=str, help='Input HEIC file path')
    parser.add_argument('-f', '--format', type=str, choices=['png', 'jpg', 'PNG', 'JPG'],
                        default='png', help='Output format (default: png)')
    parser.add_argument('-o', '--output', type=str, help='Output file path (default: input.<format>)')

    args = parser.parse_args()

    input_path = Path(args.input)

    if not input_path.exists():
        print(f"Error: Input file does not exist: {input_path}")
        sys.exit(1)

    output_format = args.format.lower()

    if args.output:
        output_path = Path(args.output)
    else:
        output_path = input_path.parent / f"{input_path.stem}.{output_format}"

    success = convert_heic(input_path, output_path, output_format)

    sys.exit(0 if success else 1)


if __name__ == '__main__':
    main()
