import pdfplumber
import pandas
import zipfile
import os

pdfPath = "anexoI.pdf"
zipPath = "Teste_Victor_Hugo_Rodrigues_Guimaraes.zip"
csvPath = "tablescsv.csv"
dados = []

with pdfplumber.open(pdfPath) as pdf:
    for pages in pdf.pages:
        table = pages.extract_table()
        
        if not table:
               continue
        
        for tables in table:
            dados.extend(table)

df = pandas.DataFrame(dados)

df.columns = df.iloc[0]
df = df[1:]
df = df.rename(columns={"OD": "Seg. Odontológica", "AMB": "Seg. Ambulatorial"})

df.to_csv(csvPath, index=False, encoding="utf-8")

with zipfile.ZipFile(zipPath, 'w', zipfile.ZIP_DEFLATED) as zipf:
    zipf.write(csvPath)  

os.remove(csvPath)