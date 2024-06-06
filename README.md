<h1 align="center">Relatório Prático II</h1>

Atividade Prática para, desenvolvimento (descrição e síntese em VHDL) e testes (análise de temporização e simulação) da SAD  (Sum of Absolute Differences)

* V1: 1 amostra de cada bloco por vez; barreira de registradores na entrada e na saída
* V3: 4 amostras de cada bloco por vez; barreira de registradores na entrada e na saída

## ✒️ Alunos Grupo-13

**Marco Jose Pedro** - 20105254

**Vinicius de Campos Pereira** - 20103807

## 📄 SAD (Sum of Absolute Differences)

### O que é uma SAD (Sum of Absolute Differences)

A SAD (Sum of Absolute Differences, ou Soma das Diferenças Absolutas) é uma medida frequentemente usada em processamento de imagens e visão computacional 
para comparar blocos de pixels entre duas imagens ou duas partes de uma imagem. 
A SAD é utilizada, por exemplo, em algoritmos de compressão de vídeo e de reconhecimento de padrões.

A ideia básica é calcular a soma das diferenças absolutas entre pixels correspondentes de dois blocos de imagens. Isso é feito da seguinte maneira:

1. **Seleção de Blocos:** Dois blocos de imagens são escolhidos, um de cada imagem ou de partes diferentes da mesma imagem.
2. **Cálculo das Diferenças:** Para cada par de pixels correspondentes (um de cada bloco), calcula-se a diferença absoluta. A diferença absoluta é simplesmente o valor absoluto da diferença entre os valores de intensidade dos dois pixels.
3. **Soma das Diferenças:** As diferenças absolutas calculadas no passo anterior são somadas para obter um único valor, que é a SAD.

Matematicamente, se `A`  e `B` são os dois blocos de imagens a serem comparados, a SAD é calculada como:

`{SAD}=\sum_{i,j}|A(i,j)-B(i,j)|`

onde `(i,j)` são as coordenadas dos pixels dentro dos blocos.

A SAD é uma medida simples e eficiente que proporciona uma estimativa da similaridade entre dois blocos de imagens. 
Quanto menor o valor da SAD, mais similares são os blocos. Por sua simplicidade, a SAD é amplamente utilizada em aplicações em tempo real, 
onde a velocidade de cálculo é crucial.

### 📄 V1 - 1 amostra de cada bloco por vez; barreira de registradores na entrada e na saída

#### Especificação do Comportamento

- Quando `iniciar = 1` o sistema realiza o cálculo descrito na equação do somatório de forma sequencial:
  - Lê um par de amostras de `Mem_A` e de `Mem_B` e as armazena nas variáveis `pA` e `pB`, respectivamente.
  - Calcula `ABS(pA - pB)` e acumula o resultado.
- Quando terminar, o resultado da SAD deve ser mostrado com a máxima precisão, i.e., jamais ocorre overflow.
- O resultado mais recente de SAD deve estar disponível na saída `SAD` até o momento em que um novo cálculo de SAD tenha sido concluído.

![](https://iili.io/JpMIfta.png)

#### Simulação

Após ser testada em simulação, a SAD V1 se comportou conforme o esperado. No entanto, é praticamente impossível verificar todas as combinações possíveis de entradas utilizando o **ModelSim** e um arquivo de **estimulus.do**. Apesar dessa limitação, todas as combinações testadas funcionaram corretamente.

![](https://iili.io/JpVNvsa.png)

#### FSM

![](https://iili.io/JpMIWNe.png)

### 📄 V3 - 4 amostras de cada bloco por vez; barreira de registradores na entrada e na saída

#### Especificação do Comportamento

Aumentando o paralelismo do B.O.
 Processando 4 pares de pixels por ciclo, será necessário executar 16 vezes o laço para processar todos os 64 pares!
- A memória será acessada somente 16 vezes (cada linha da memória contém 4 pixels);

![](https://iili.io/JpMu5Gf.png)

#### Simulação

Após ser testada em simulação, a SAD V3 também se comportou conforme o esperado com as combinações apresentadas.

![](https://iili.io/JpMvTNI.png)
