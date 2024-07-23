# Import the required Module
import tabula
import pandas as pd
# Read a PDF File
# make sure your pdf file is in the same directory as your notebook
df = tabula.read_pdf("UDC.pdf", pages='all', guess = False)[0]
# convert PDF into CSV
tabula.convert_into("UDC.pdf", "text.csv", output_format="csv", pages='all', guess = False)
print(df)