# Import the required Module
import tabula
# Read a PDF File
# make sure your pdf file is in the same directory as your notebook
df = tabula.read_pdf("UDC Bank 202301.pdf", pages='all')[0]
# convert PDF into CSV
tabula.convert_into("UDC Bank 202301.pdf", "bank2301.csv", output_format="csv", pages='all')
print(df)