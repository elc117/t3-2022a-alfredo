# t3-2022a-alfredo
O trabalho usa a biblioteca gráfica Gloss para recriar o clássico "jogo da cobrinha".

## Motivação
Este trabalho foi realizado para explorar a como a programação funcional pode ser aplicada à criação de jogos. Para isto foi escolhida a famosa biblioteca gráfica `Gloss` que permite a criação de aplicações gráficas simples e eficientes por meio do Haskell.

## Implementação
O código usa 3 funções principais para criar o jogo: `render`, `update` e `keyHandler`. Render recebe um conjunto de parâmetros(`GameState`) e o converte em uma imagem(`Picture`) que o gloss consiga renderizar. keyHandler recebe os inputs do jogado e o GameState atual e partir disso gera um novo GameState com a direção da cobra(input do jogador) atualizada. Update também recebe um GameState e atualiza, considerando a passagem de tempo entre um frame e outro, o estado da sobra, da fruta e do gameOver do jogo em um novo GameState.
<br><br>
O Gloss possui a função play que recebe as funções descritas e passa a saída do keyHandler para o update e a saída do update para o render, e por fim renderiza o resultado, repetindo o processo em todos os frames

## Snake Game
O jogo não possui menu, sistema de pause nem restart. Ao abrir o jogo a cobra já começará a se mover.
* se a cabeça da cobra colidir com o corpo ou com as paredes, o jogo termina
* os controles são : WASD
* o jogo é atualizado a uma taxa de 8 fps

## Conclusões
Ao explorar funções do Gloss como `display`, `simulate` e `play` pude perceber o paradgma funcional dentro do Gloss. Todo o frame não passa de uma passagem de funções: input -> update -> render. Input retorna os comandos do jogador; update retorna o estado do jogo atualizado para o próximo frame; render retorna uma imagem que representa o estado do jogo. Gloss não só utiliza Haskell para criar um jogo, mas sim todo o paradgma funional aplicado a mecânica de gameplay e gráficos.

## Refêrencias
* https://andrew.gibiansky.com/blog/haskell/haskell-gloss/
* https://github.com/leonardo-ono/HaskellSnakeGame

Apesar das referências o código é 100% original

## Obs
Para executar o código foi necessário colocar o arquivo `Glut32.dll` junto do SnakeGame.exe
