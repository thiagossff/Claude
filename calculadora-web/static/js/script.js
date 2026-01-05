// Variáveis globais
let expressaoAtual = '';
let resultadoExibido = false;

// Elementos do DOM
const expressaoEl = document.getElementById('expressao');
const resultadoEl = document.getElementById('resultado');

/**
 * Adiciona um valor à expressão atual
 * @param {string} valor - O valor a ser adicionado
 */
function adicionarValor(valor) {
    // Se acabou de mostrar um resultado e digita um número, começa nova expressão
    if (resultadoExibido && !isNaN(valor)) {
        expressaoAtual = '';
        resultadoExibido = false;
    }

    // Se acabou de mostrar um resultado e digita um operador, continua a partir do resultado
    if (resultadoExibido && isNaN(valor)) {
        expressaoAtual = resultadoEl.textContent;
        resultadoExibido = false;
    }

    expressaoAtual += valor;
    atualizarDisplay();
}

/**
 * Limpa toda a expressão
 */
function limpar() {
    expressaoAtual = '';
    resultadoEl.textContent = '0';
    expressaoEl.textContent = '';
    resultadoExibido = false;
}

/**
 * Apaga o último caractere da expressão
 */
function apagarUltimo() {
    expressaoAtual = expressaoAtual.slice(0, -1);
    atualizarDisplay();
}

/**
 * Atualiza o display da calculadora
 */
function atualizarDisplay() {
    expressaoEl.textContent = expressaoAtual;
    if (expressaoAtual === '') {
        resultadoEl.textContent = '0';
    }
}

/**
 * Realiza o cálculo da expressão
 */
async function calcular() {
    if (!expressaoAtual) return;

    try {
        const response = await fetch('/calcular', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ expressao: expressaoAtual }),
        });

        const data = await response.json();

        if (response.ok) {
            // Formatar o resultado
            let resultado = data.resultado;

            // Se for um número decimal, limitar casas decimais
            if (typeof resultado === 'number' && !Number.isInteger(resultado)) {
                resultado = parseFloat(resultado.toFixed(10));
            }

            expressaoEl.textContent = expressaoAtual + ' =';
            resultadoEl.textContent = resultado;
            expressaoAtual = resultado.toString();
            resultadoExibido = true;
        } else {
            mostrarErro(data.erro);
        }
    } catch (error) {
        mostrarErro('Erro de conexão');
    }
}

/**
 * Mostra uma mensagem de erro
 * @param {string} mensagem - A mensagem de erro
 */
function mostrarErro(mensagem) {
    resultadoEl.textContent = mensagem;
    resultadoEl.classList.add('erro');

    setTimeout(() => {
        resultadoEl.classList.remove('erro');
        if (expressaoAtual) {
            resultadoEl.textContent = expressaoAtual || '0';
        } else {
            resultadoEl.textContent = '0';
        }
    }, 1500);
}

// Suporte a teclado
document.addEventListener('keydown', (event) => {
    const key = event.key;

    // Números
    if (/[0-9]/.test(key)) {
        adicionarValor(key);
    }
    // Operadores
    else if (['+', '-', '*', '/', '.', '(', ')'].includes(key)) {
        adicionarValor(key);
    }
    // Enter = calcular
    else if (key === 'Enter') {
        event.preventDefault();
        calcular();
    }
    // Backspace = apagar
    else if (key === 'Backspace') {
        apagarUltimo();
    }
    // Escape = limpar
    else if (key === 'Escape') {
        limpar();
    }
});
