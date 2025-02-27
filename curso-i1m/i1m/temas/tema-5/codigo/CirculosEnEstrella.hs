import CodeWorld

main :: IO ()
main = drawingOf circulosEnEstrella

circulosEnEstrella :: Picture
circulosEnEstrella =
  pictures [rotated angulo (translated x 0 (circle 0.5))
           | x      <- [2,3.5..8]
           , angulo <- [0, pi/4..2*pi]]
  
