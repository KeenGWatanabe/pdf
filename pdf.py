# Import the required Module
import tabula
# Read a PDF File
# make sure your pdf file is in the same directory as your notebook
df = tabula.read_pdf("file.pdf", pages='all')[0]
# convert PDF into CSV
tabula.convert_into("file.pdf", "text.csv", output_format="csv", pages='all')
print(df)