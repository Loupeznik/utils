# Image Utilities

Collection of Python scripts for image manipulation and conversion.

## Installation

Install required dependencies:

```bash
pip install -r requirements.txt
```

## Scripts

### resize_image.py

Resize images (PNG, JPG, WEBP) by dimensions or percentage. Output format matches input format.

**Usage:**

```bash
./resize_image.py <input> [options]
```

**Options:**

- `-w, --width WIDTH` - New width in pixels
- `-H, --height HEIGHT` - New height in pixels
- `-p, --percentage PERCENTAGE` - Resize percentage (e.g., 50 for 50%)
- `-o, --output OUTPUT` - Output file path (default: input_resized.{ext})

**Examples:**

```bash
# Resize PNG to 50% of original size
./resize_image.py input.png -p 50

# Resize JPG to width 800px, maintain aspect ratio
./resize_image.py input.jpg -w 800

# Resize WEBP to height 600px, maintain aspect ratio
./resize_image.py input.webp -H 600

# Resize to exact dimensions
./resize_image.py input.png -w 800 -H 600

# Resize and save to custom output path
./resize_image.py input.jpg -p 75 -o output.jpg
```

### convert_heic.py

Convert HEIC images to PNG or JPG format.

**Usage:**

```bash
./convert_heic.py <input> [options]
```

**Options:**

- `-f, --format {png|jpg}` - Output format (default: png)
- `-o, --output OUTPUT` - Output file path (default: input.{format})

**Examples:**

```bash
# Convert to PNG (default)
./convert_heic.py input.heic

# Convert to JPG
./convert_heic.py input.heic -f jpg

# Convert to PNG with custom output path
./convert_heic.py input.heic -o output.png

# Convert to JPG with custom output path
./convert_heic.py input.heic -f jpg -o output.jpg
```

## Notes

- All scripts include `--help` flag for detailed usage information
- Scripts are designed to be simple and focused on specific tasks
- Error handling is included for common issues (missing files, invalid formats, etc.)
