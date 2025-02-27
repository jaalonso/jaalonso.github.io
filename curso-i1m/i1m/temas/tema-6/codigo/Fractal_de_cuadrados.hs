import CodeWorld

main :: IO ()
main = drawingOf (arbol 4)

tronco :: Picture
tronco = rectangle 6 6

arbol :: Integer -> Picture
arbol 0 = tronco
arbol n = tronco & rama1 & rama2
  where rama  = scaled (1/2) (1/2) (arbol (n-1))
        rama1 = translated (-3)   3  rama
        rama2 = translated   3  (-3) rama

