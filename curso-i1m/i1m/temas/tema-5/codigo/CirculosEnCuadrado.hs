import CodeWorld

main :: IO ()
main = drawingOf circulosEnCuadrado

circulosEnCuadrado :: Picture
circulosEnCuadrado =
  pictures [translated x y (circle 1)
           | x <- [-6,-3..6]
           , y <- [-6,-3..6]]
  

  
