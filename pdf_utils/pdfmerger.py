from PyPDF2 import PdfFileMerger, PdfFileReader
import os

newFile = PdfFileMerger()
files = []
output = 'output/'
if not os.path.exists(output):
    os.mkdir(output)

for filename in files:
    newFile.append(PdfFileReader(filename + '.pdf', 'rb'))
 
newFile.write(output + ".pdf")
