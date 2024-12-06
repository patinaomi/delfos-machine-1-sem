from flask import Flask, request, jsonify
import joblib
import pandas as pd

app = Flask(__name__)

# Carregar o modelo treinado
model = joblib.load('indicacaoSolucao.pkl')

@app.route('/indicacaoSolucao', methods=['POST'])
def indicacao_solucao():
    data = request.get_json(force=True)
    
    # Transformar os dados recebidos em um DataFrame
    df = pd.DataFrame(data, index=[0])  # Supondo que você envia um dicionário como entrada
    
    # Fazer a previsão
    prediction = model.predict(df)
    
    return jsonify({'Produto Sugerido': prediction[0]})

if __name__ == '__main__':
    app.run(debug=True, port=6000)
