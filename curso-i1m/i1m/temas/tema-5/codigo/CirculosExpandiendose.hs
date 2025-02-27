import CodeWorld

main :: IO ()
main = drawingOf circulosEnEstrella

circulosEnEstrella :: Picture
circulosEnEstrella =
  pictures [rotated angulo (translated x 0 (circle (x/5)))
           | x      <- [1..8]
           , angulo <- [0, pi/4..2*pi]]
    
