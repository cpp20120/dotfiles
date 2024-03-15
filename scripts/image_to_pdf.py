from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter
from PIL import Image
import os


def convert_images_to_pdf(images_path, output_pdf):
    c = canvas.Canvas(output_pdf, pagesize=letter)

    images = [img for img in os.listdir(
        images_path) if img.endswith(".jpg") or img.endswith(".png")]

    for image_name in images:
        img_path = os.path.join(images_path, image_name)
        img = Image.open(img_path)
        c.setPageSize((img.width, img.height))
        c.drawImage(img_path, 0, 0, width=img.width, height=img.height)
        c.showPage()

    c.save()


# Path to the directory with images
images_directory = "path_to_images_directory"
# Output PDF file name
output_pdf_file = "output.pdf"

convert_images_to_pdf(images_directory, output_pdf_file)
