import CodeWorld

main :: IO ()
main = drawingOf (arbol 6)

tronco :: Picture
tronco = path [(0,-5),(0,0)]

arbol :: Integer -> Picture
arbol 0 = tronco
arbol n = tronco & rama1 & rama2
  where rama  = scaled (3/4) (3/4) (arbol (n-1))
        rama1 = translated (-2.7) 0.5 (rotated ( pi/4) rama)
        rama2 = translated   2.6  2.6 (rotated (-pi/4) rama)
