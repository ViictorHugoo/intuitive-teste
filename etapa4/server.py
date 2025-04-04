from flask import Flask, request, jsonify
import pandas as pd
from fuzzywuzzy import fuzz
import os

app = Flask(__name__)

file_path = os.path.join(os.path.dirname(__file__), 'Relatorio_cadop.csv')
df = pd.read_csv(file_path, encoding='utf-8', delimiter=';')

@app.route('/buscar', methods=['GET'])
def buscar_operadoras():
    termo = request.args.get('termo', '')
    limite = int(request.args.get('limite', 10))
    
    if not termo:
        return jsonify({"error": "O parâmetro 'termo' é obrigatório"}), 400
    
    def calcular_relevancia(row):
        texto_busca = f"{row['Razao_Social'] or ''} {row['Nome_Fantasia'] or ''} {row['Cidade'] or ''} {row['UF'] or ''} {row['Registro_ANS'] or ''} {row['Representante'] or ''} {row['Regiao_de_Comercializacao'] or ''}"
        	
        return fuzz.token_set_ratio(termo.lower(), texto_busca.lower())
    
    df['Relevancia'] = df.apply(calcular_relevancia, axis=1)
    resultados = df.sort_values('Relevancia', ascending=False).head(limite)
    
    resposta = resultados[[
        'Registro_ANS',
        'CNPJ',
        'Razao_Social',
        'Nome_Fantasia',
        'Modalidade',
        'Cidade',
        'UF',
        'Data_Registro_ANS',
        'Relevancia'
    ]].to_dict(orient='records')
    
    response = jsonify(resposta)
    response.headers.add('Access-Control-Allow-Origin', 'http://localhost:8080')
    response.headers.add('Access-Control-Allow-Headers', 'Content-Type')
    return response

if __name__ == '__main__':
    app.run(debug=True, port=5000)