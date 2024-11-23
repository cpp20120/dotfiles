import os
import img2pdf
import sys

if len(sys.argv) != 2:
    print("Usage: python convert_images_to_pdf.py <directory_path>")
    sys.exit(1)

directory_path = sys.argv[1]

if not os.path.isdir(directory_path):
    print(f"Error: The specified directory '{directory_path}' does not exist.")
    sys.exit(1)

image_files = [os.path.join(directory_path, i) for i in os.listdir(directory_path) if any(i.lower().endswith(ext) for ext in (".jpg", ".png"))]

if not image_files:
    print(f"No JPEG or PNG images found in the directory '{directory_path}'.")
    sys.exit(1)

pdf_data = img2pdf.convert(image_files)

output_pdf_path = "output.pdf"

with open(output_pdf_path, "wb") as file:
    file.write(pdf_data)

print(f"Images converted to PDF. Output PDF saved as '{output_pdf_path}'.")
