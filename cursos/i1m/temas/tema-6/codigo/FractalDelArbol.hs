import CodeWorld

main :: IO ()
main = animationOf (arbol 8 . sin)

arbol :: Integer -> Double -> Picture
arbol 0 _ = blank
arbol n f =
    path [(0,0),(0,1)]
  & translated 0 1 (rotated ( f*pi/10) (arbol (n-1) f) &
                    rotated (-f*pi/10) (arbol (n-1) f))

