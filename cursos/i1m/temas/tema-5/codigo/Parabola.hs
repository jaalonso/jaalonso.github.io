import CodeWorld

main :: IO ()
main = drawingOf (graficaSeno <> coordinatePlane)

graficaSeno :: Picture
graficaSeno = curve [(x, x**2-8) | x <- [-4..4]]



  
