import CodeWorld

main :: IO ()
main = animationOf (arbol 8 . sin)

tronco :: Picture
tronco = path [(0,0),(0,1)]

arbol :: Integer -> Double -> Picture
arbol 0 _ = tronco
arbol n f = tronco & rama1 & rama2
  where rama  = arbol (n-1) f
        rama1 = translated 0 1 (rotated ( f*pi/10) rama)
        rama2 = translated 0 1 (rotated (-f*pi/10) rama)
