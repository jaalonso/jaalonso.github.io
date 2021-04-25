import CodeWorld

main :: IO ()
main = drawingOf (arbol 5)

tronco :: Picture
tronco = rectangle 10 10

arbol :: Integer -> Picture
arbol 0 = tronco
arbol n = tronco & rama1 & rama2 & rama3 & rama4 
  where rama  = scaled (1/2) (1/2) (arbol (n-1))
        rama1 = translated (-5)   5  rama
        rama2 = translated   5  (-5) rama
        rama3 = translated (-5) (-5) rama
        rama4 = translated   5    5  rama
