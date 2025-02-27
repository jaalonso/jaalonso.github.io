import CodeWorld

main :: IO ()
main = drawingOf (arbol 8)

tronco :: Picture
tronco = translated 0 (-5) (rectangle 4 4 &
                            path [(-2, 2), (0, 4), (2, 2)])

arbol :: Integer -> Picture
arbol 0 = tronco
arbol n = tronco & rama1 & rama2
  where rama  = scaled r r (arbol (n-1))
        rama1 = translated   4.3  1.4 (rotated (-pi/4) rama)
        rama2 = translated (-4.3) 1.4 (rotated ( pi/4) rama)
        r     = 0.685
