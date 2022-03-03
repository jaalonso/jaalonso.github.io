import CodeWorld

main :: IO ()
main = drawingOf circulosConcentricos

circulosConcentricos :: Picture
circulosConcentricos =
  pictures [circle x | x <- [1,2..10]]

  
