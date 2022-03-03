import CodeWorld

main :: IO ()
main = drawingOf (arbol 8)

tronco :: Picture
tronco = path [(0,0),(0,1)]

arbol :: Integer -> Picture
arbol 0 = tronco
arbol n = tronco & rama1 & rama2
  where rama  = arbol (n-1)
        rama1 = translated 0 1 (rotated ( pi/10) rama)
        rama2 = translated 0 1 (rotated (-pi/10) rama)
        
