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
  %(prog)s input.heic                              # Convert to PNG (default)
  %(prog)s input.heic -f jpg                       # Convert to JPG
  %(prog)s file1.heic file2.heic -f jpg            # Convert multiple files
  %(prog)s -d /path/to/images -f jpg               # Convert all HEIC files in directory
  %(prog)s -d /path/to/images -o /out/dir -f jpg   # Convert directory to output directory
        '''
    )

    parser.add_argument('input', type=str, nargs='*', help='Input HEIC file path(s)')
    parser.add_argument('-d', '--directory', type=str, help='Process all HEIC files in directory')
    parser.add_argument('-f', '--format', type=str, choices=['png', 'jpg', 'PNG', 'JPG'],
                        default='png', help='Output format (default: png)')
    parser.add_argument('-o', '--output', type=str, help='Output file/directory path')

    args = parser.parse_args()

    output_format = args.format.lower()
    input_files = []
    output_dir = None

    if args.directory:
        dir_path = Path(args.directory)
        if not dir_path.exists() or not dir_path.is_dir():
            print(f"Error: Directory does not exist: {dir_path}")
            sys.exit(1)

        for ext in ['*.heic', '*.HEIC']:
            input_files.extend(dir_path.glob(ext))

        if not input_files:
            print(f"No HEIC files found in directory: {dir_path}")
            sys.exit(1)

        if args.output:
            output_dir = Path(args.output)
            output_dir.mkdir(parents=True, exist_ok=True)

    elif args.input:
        input_files = [Path(f) for f in args.input]
        for f in input_files:
            if not f.exists():
                print(f"Error: File does not exist: {f}")
                sys.exit(1)
    else:
        print("Error: Must specify input file(s) or --directory")
        parser.print_help()
        sys.exit(1)

    if args.output and not args.directory and len(input_files) > 1:
        print("Error: Cannot specify single output path for multiple input files")
        sys.exit(1)

    success_count = 0
    fail_count = 0

    print(f"Processing {len(input_files)} file(s)...\n")

    for input_path in input_files:
        print(f"Processing: {input_path.name}")

        if args.output:
            if output_dir:
                output_path = output_dir / f"{input_path.stem}.{output_format}"
            else:
                output_path = Path(args.output)
        else:
            output_path = input_path.parent / f"{input_path.stem}.{output_format}"

        success = convert_heic(input_path, output_path, output_format)

        if success:
            success_count += 1
        else:
            fail_count += 1

        print()

    print(f"Summary: {success_count} succeeded, {fail_count} failed")
    sys.exit(0 if fail_count == 0 else 1)


if __name__ == '__main__':
    main()
