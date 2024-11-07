from flask import Flask, request, jsonify
from flask_cors import CORS  # Importando CORS
import joblib
import scipy
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer

app = Flask(__name__)
CORS(app)  # Permite CORS para todas as rotas

# Carregar o modelo treinado e o vetorizador
model = joblib.load('modelo_treinado.pkl')
vectorizer = joblib.load('vectorizer.pkl')

@app.route('/analisar-sentimento', methods=['POST'])
def predict():
    data = request.get_json(force=True)
    
    # Verifique se a chave 'COMENTARIO' está no JSON
    if 'COMENTARIO' not in data:
        return jsonify({'error': 'Comentário não fornecido.'}), 400
    
    comentario = data['COMENTARIO']
    
    # Pré-processar o comentário
    comentario_tfidf = vectorizer.transform([comentario])
    
    # Adicionar a análise de sentimento
    analyzer = SentimentIntensityAnalyzer()
    sentimento = analyzer.polarity_scores(comentario)['compound']
    comentario_tfidf = scipy.sparse.hstack((comentario_tfidf, [[sentimento]]))
    
    # Fazer a previsão
    nota_pred = model.predict(comentario_tfidf)
    
    return jsonify(AVALIACAO=int(nota_pred[0]))

if __name__ == '__main__':
    app.run(debug=True)
