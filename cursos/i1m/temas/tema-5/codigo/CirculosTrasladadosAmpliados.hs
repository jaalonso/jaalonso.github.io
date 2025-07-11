import CodeWorld

main :: IO ()
main = drawingOf circulosTrasladadosAmpliados

circulosTrasladadosAmpliados :: Picture
circulosTrasladadosAmpliados =
  translated (-8) 0 (pictures [translated x 0 (circle x) | x <- [1..8]])


  
