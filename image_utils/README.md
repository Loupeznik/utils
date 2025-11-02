# Image Utilities

Collection of Python scripts for image manipulation and conversion.

## Installation

Install required dependencies:

```bash
pip install -r requirements.txt
```

## Scripts

### resize_image.py

Resize images (PNG, JPG, WEBP) by dimensions or percentage. Output format matches input format. Supports batch processing of multiple files or entire directories.

**Usage:**

```bash
./resize_image.py [input...] [options]
./resize_image.py -d <directory> [options]
```

**Options:**

- `-d, --directory DIRECTORY` - Process all images in directory
- `-w, --width WIDTH` - New width in pixels
- `-H, --height HEIGHT` - New height in pixels
- `-p, --percentage PERCENTAGE` - Resize percentage (e.g., 50 for 50%)
- `-o, --output OUTPUT` - Output file/directory path

**Examples:**

```bash
# Resize single PNG to 50% of original size
./resize_image.py input.png -p 50

# Resize JPG to width 800px, maintain aspect ratio
./resize_image.py input.jpg -w 800

# Resize multiple files at once
./resize_image.py file1.png file2.jpg file3.webp -p 50

# Resize all images in a directory
./resize_image.py -d /path/to/images -p 50

# Resize directory and save to output directory
./resize_image.py -d /path/to/images -w 800 -o /path/to/output

# Resize to exact dimensions
./resize_image.py input.png -w 800 -H 600
```

### convert_heic.py

Convert HEIC images to PNG or JPG format. Supports batch processing of multiple files or entire directories.

**Usage:**

```bash
./convert_heic.py [input...] [options]
./convert_heic.py -d <directory> [options]
```

**Options:**

- `-d, --directory DIRECTORY` - Process all HEIC files in directory
- `-f, --format {png|jpg}` - Output format (default: png)
- `-o, --output OUTPUT` - Output file/directory path

**Examples:**

```bash
# Convert single file to PNG (default)
./convert_heic.py input.heic

# Convert to JPG
./convert_heic.py input.heic -f jpg

# Convert multiple files at once
./convert_heic.py file1.heic file2.heic file3.heic -f jpg

# Convert all HEIC files in a directory
./convert_heic.py -d /path/to/images -f jpg

# Convert directory and save to output directory
./convert_heic.py -d /path/to/images -o /path/to/output -f jpg

# Convert with custom output path (single file only)
./convert_heic.py input.heic -f jpg -o output.jpg
```

## Notes

- All scripts include `--help` flag for detailed usage information
- Both scripts support batch processing of multiple files or entire directories
- Batch processing continues even if individual files fail, showing a summary at the end
- Scripts are designed to be simple and focused on specific tasks
- Error handling is included for common issues (missing files, invalid formats, etc.)
