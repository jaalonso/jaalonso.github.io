import CodeWorld

main :: IO ()
main = drawingOf (arbol 8)

arbol :: Integer -> Picture
arbol 0 = blank
arbol n =
    path [(0,0),(0,1)]
  & translated 0 1 (rotated ( pi/10) (arbol (n-1)) &
                    rotated (-pi/10) (arbol (n-1)))

