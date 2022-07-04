module Main(main) where

import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import System.Random

width, height, cols, rows, offset :: Int
width = 480
height = 480
cols = 20
rows = 20
offset = 10 
fps = 8

window :: Display
window = InWindow "Jogo da cobrinha feito em Haskell" (width + offset, height + offset) (0,0)

background :: Color
background = black

data GameState = State
  { 
    snake :: [Point],
    snakeDir :: Point,
    foodLoc :: Point,
    isGameover :: Bool,
    foodSeed :: StdGen,
    snakeColor :: Color 
  }

initialState :: GameState
initialState = State
  { snake = [(fX, fY), (fX - 1, fY),(fX - 2, fY), (fX - 3, fY)],
    snakeDir = (1,0),
    foodLoc = (fX - 4, fY - 4), 
    isGameover = False,
    foodSeed = mkStdGen 80, --um número qualquer como seed inicial
    snakeColor = white
  }
  where 
    fX = fromIntegral rows / 2
    fY = fromIntegral cols / 2

--funções necessárias para o gloss:

handleKeys :: Event -> GameState -> GameState
handleKeys (EventKey (Char 'd') _ _ _) game =
  game { snakeDir = if curDir /= (-1, 0) then (1,0) else curDir }
    where curDir = snakeDir game
handleKeys (EventKey (Char 'a') _ _ _) game =
  game { snakeDir = if curDir /= (1, 0) then (-1,0) else curDir }
    where curDir = snakeDir game
handleKeys (EventKey (Char 'w') _ _ _) game =
  game { snakeDir = if curDir /= (0, -1) then (0,1) else curDir }
    where curDir = snakeDir game
handleKeys (EventKey (Char 's') _ _ _) game =
  game { snakeDir = if curDir /= (0, 1) then (0,-1) else curDir }
    where curDir = snakeDir game
handleKeys _ game = game

render :: GameState -> Picture  
render game = pictures (food : (snakeBody ++ walls)) 
  where
    food = mkNode (dark red) (foodLoc game)
    snakeBody = map (mkNode newColor) (snake game)
    newColor = snakeColor game

    -- paredes do topo e dos lados
    walls :: [Picture]
    walls = 
      [
      translate halfX 0 $ color wallColor $ rectangleSolid offsetf h,
      translate (-halfX) 0 $ color wallColor $ rectangleSolid offsetf h,
      translate 0 halfY $ color wallColor $ rectangleSolid w offsetf,
      translate 0 (-halfY) $ color wallColor $ rectangleSolid w offsetf
      ]
        where
          halfX = fromIntegral (width + offset) / 2
          halfY = fromIntegral (height + offset) / 2
          w = fromIntegral (width + 2 * offset) 
          h = fromIntegral (height + 2 * offset)
          wallColor = white
          offsetf = fromIntegral offset

    --desenha um retângulo nas proporções da grid(cols, rows) do jogo
    mkNode :: Color -> Point -> Picture
    mkNode col (x, y) = translate xt yt $ color col $ rectangleSolid rectX rectY
      where
        xt = x*rectX - fromIntegral (width + offset) / 2
        yt = y*rectY - fromIntegral (height + offset) / 2
        rectX = fromIntegral (width + offset) / fromIntegral cols
        rectY = fromIntegral (height + offset) / fromIntegral rows

update :: Float -> GameState -> GameState
update _ game = if checkGameOver snakeBody then game { snakeColor = red }
  else game {
  snake = newHead : tail, foodLoc = newFood, foodSeed = newSeed
  }
  where
    tail = if wasFoodEaten then snakeBody else removePoint snakeBody $ last snakeBody
    (newFood, newSeed) = if wasFoodEaten then generateNewFood snakeBody curSeed else (curFood, curSeed)
    curFood = foodLoc game
    curSeed = foodSeed game
    wasFoodEaten = newHead == curFood
    newHead = (x + xDir, y + yDir)
    xDir = fst dir
    yDir = snd dir
    dir = snakeDir game
    (x,y) = head snakeBody
    snakeBody = snake game 



--funções auxiliares do update:

--remove um ponto da lista que representa a sobra
removePoint :: [Point] -> Point -> [Point]
removePoint list elem = filter (/= elem) list

--cria um novo ponto aleatório e uma nova semente(necessária para os valores pseudoalatórios)
generateNewFood :: [Point] -> StdGen -> (Point, StdGen)
generateNewFood snake stdGen =  
  if (fromIntegral foodX, fromIntegral foodY) `elem` snake
    then generateNewFood snake stdGen3
    else ((fromIntegral foodX, fromIntegral foodY), stdGen3)
        where 
          (foodX, stdGen2) = randomR (1, cols - 1) stdGen
          (foodY, stdGen3) = randomR (1, rows - 1) stdGen2

--verifica se a cabeça da cobra está no mesmo ponto que alguma outra parte do corpo ou fora dos limites do cenário
checkGameOver :: [Point] -> Bool
checkGameOver snake = 
  headX == 0 ||
  headX == fromIntegral cols || 
  headY == 0 ||
  headY == fromIntegral rows ||
  snakeHead `elem` snakeTail
    where   snakeHead = head snake
            (headX, headY) = snakeHead
            snakeTail = tail snake

main :: IO ()
main = play window background fps initialState render handleKeys update