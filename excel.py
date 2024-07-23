import tabula
import pandas as pd
pdf_file_path = './UDC.pdf'
excel_file_path = './UDC.xlsx'


def pdf_to_excel(pdf_file_path, excel_file_path):
    # Read PDF file
    tables = tabula.read_pdf(pdf_file_path, pages='all', guess = False)

    # Write each table to a separate sheet in the Excel file
    with pd.ExcelWriter(excel_file_path) as writer:
        for i, table in enumerate(tables):
            table.to_excel(writer, sheet_name=f'Sheet{i+1}')


pdf_to_excel('UDC.pdf', 'UDC.xlsx')