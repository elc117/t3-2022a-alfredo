# t3-2022a-alfredo
O trabalho usa a biblioteca gráfica Gloss para recriar o clássico "jogo da cobrinha".

## Implementação
O código usa 3 funções principais para criar o jogo: `render`, `update` e `keyHandler`. Render recebe um conjunto de parâmetros(`GameState`) e o converte em uma imagem(`Picture`) que o gloss consiga renderizar. keyHandler recebe os inputs do jogado e o GameState atual e partir disso gera um novo GameState com a direção da cobra(input do jogador) atualizada. Update também recebe um GameState e atualiza, considerando a passagem de tempo entre um frame e outro, o estado da sobra, da fruta e do gameOver do jogo em um novo GameState.
<br><br>
O Gloss possui a função play que recebe as funções descritas e passa a saída do keyHandler para o update e a saída do update para o render, e por fim renderiza o resultado, repetindo o processo em todos os frames


## Snake Game
O jogo não possui menu, sistema de pause nem restart. Ao abrir o jogo a cobra já começará a se mover.
* se a cabeça da cobra colidir com o corpo ou com as paredes, o jogo termina
* os controles são : WASD
* o jogo é atualizado a uma taxa de 8 fps
## Refêrencias
* https://andrew.gibiansky.com/blog/haskell/haskell-gloss/
* https://github.com/leonardo-ono/HaskellSnakeGame

Apesar das referências o código é 100% original

## Obs
Para executar o código foi necessário colocar o arquivo `Glut32.dll` junto do SnakeGame.exe
