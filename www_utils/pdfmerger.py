from PyPDF2 import PdfFileMerger, PdfFileReader
from datetime import datetime
import os

year = datetime.now().year
newFile = PdfFileMerger()
files = []
output = 'output/'
if not os.path.exists(output):
    os.mkdir(output)

for filename in files:
    newFile.append(PdfFileReader('soubor_' + filename + '.pdf', 'rb'))
 
newFile.write(output + str(year) + ".pdf")
