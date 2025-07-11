import CodeWorld

main :: IO ()
main = drawingOf (arbol 4)

tronco :: Picture
tronco = translated 0 (-4) (circle 5)

arbol :: Integer -> Picture
arbol 0 = tronco
arbol n = tronco & rama1 & rama2 & rama3
  where rama  = scaled (1/2) (1/2) (arbol (n-1))
        rama1 = translated (-6.2) 2.3 rama
        rama2 = translated      0 5.5 rama
        rama3 = translated    6.2 2.3 rama
