#!/usr/bin/env python3

import argparse
import sys
from pathlib import Path
from PIL import Image


def resize_image(input_path, output_path, width=None, height=None, percentage=None):
    try:
        img = Image.open(input_path)

        if img.format not in ['PNG', 'JPEG', 'WEBP']:
            print(f"Error: Unsupported image format: {img.format}")
            print("Supported formats: PNG, JPG, WEBP")
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

        output_format = img.format
        if output_format == 'JPEG' and resized_img.mode in ('RGBA', 'LA', 'P'):
            resized_img = resized_img.convert('RGB')

        save_kwargs = {}
        if output_format == 'JPEG':
            save_kwargs['quality'] = 95
        elif output_format == 'WEBP':
            save_kwargs['quality'] = 95

        resized_img.save(output_path, output_format, **save_kwargs)

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
        description='Resize images (PNG, JPG, WEBP) by dimensions or percentage',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog='''
Examples:
  %(prog)s input.png -p 50                         # Resize single file to 50%% of original size
  %(prog)s input.jpg -w 800                        # Resize to width 800px, maintain aspect ratio
  %(prog)s file1.png file2.jpg -p 50               # Resize multiple files
  %(prog)s -d /path/to/images -p 50                # Resize all images in directory
  %(prog)s -d /path/to/images -w 800 -o /out/dir   # Resize directory to output directory
        '''
    )

    parser.add_argument('input', type=str, nargs='*', help='Input image file path(s)')
    parser.add_argument('-d', '--directory', type=str, help='Process all images in directory')
    parser.add_argument('-w', '--width', type=int, help='New width in pixels')
    parser.add_argument('-H', '--height', type=int, help='New height in pixels')
    parser.add_argument('-p', '--percentage', type=float, help='Resize percentage (e.g., 50 for 50%%)')
    parser.add_argument('-o', '--output', type=str, help='Output file/directory path')

    args = parser.parse_args()

    if args.percentage and (args.width or args.height):
        print("Error: Cannot specify both percentage and dimensions")
        sys.exit(1)

    if not (args.percentage or args.width or args.height):
        print("Error: Must specify either --percentage, --width, or --height")
        parser.print_help()
        sys.exit(1)

    input_files = []
    output_dir = None

    if args.directory:
        dir_path = Path(args.directory)
        if not dir_path.exists() or not dir_path.is_dir():
            print(f"Error: Directory does not exist: {dir_path}")
            sys.exit(1)

        for ext in ['*.png', '*.jpg', '*.jpeg', '*.webp', '*.PNG', '*.JPG', '*.JPEG', '*.WEBP']:
            input_files.extend(dir_path.glob(ext))

        if not input_files:
            print(f"No valid image files found in directory: {dir_path}")
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
                output_path = output_dir / f"{input_path.stem}_resized{input_path.suffix}"
            else:
                output_path = Path(args.output)
        else:
            output_path = input_path.parent / f"{input_path.stem}_resized{input_path.suffix}"

        if args.percentage:
            success = resize_image(input_path, output_path, percentage=args.percentage)
        else:
            success = resize_image(input_path, output_path, width=args.width, height=args.height)

        if success:
            success_count += 1
        else:
            fail_count += 1

        print()

    print(f"Summary: {success_count} succeeded, {fail_count} failed")
    sys.exit(0 if fail_count == 0 else 1)


if __name__ == '__main__':
    main()
