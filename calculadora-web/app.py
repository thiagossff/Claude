"""
Aplicativo de Calculadora Web
Desenvolvido com Flask
"""

from flask import Flask, render_template, request, jsonify

app = Flask(__name__)


@app.route('/')
def index():
    """Página principal da calculadora."""
    return render_template('index.html')


@app.route('/calcular', methods=['POST'])
def calcular():
    """
    Endpoint para realizar cálculos.
    Recebe uma expressão matemática e retorna o resultado.
    """
    try:
        data = request.get_json()
        expressao = data.get('expressao', '')

        # Validar a expressão para evitar execução de código malicioso
        caracteres_permitidos = set('0123456789+-*/.() ')
        if not all(c in caracteres_permitidos for c in expressao):
            return jsonify({'erro': 'Expressão inválida'}), 400

        # Calcular o resultado
        resultado = eval(expressao)

        return jsonify({'resultado': resultado})

    except ZeroDivisionError:
        return jsonify({'erro': 'Divisão por zero'}), 400
    except Exception as e:
        return jsonify({'erro': 'Erro no cálculo'}), 400


if __name__ == '__main__':
    print("=" * 50)
    print("🧮 Calculadora Web iniciada!")
    print("📍 Acesse: http://localhost:5000")
    print("=" * 50)
    app.run(host='0.0.0.0', port=5000, debug=True)
