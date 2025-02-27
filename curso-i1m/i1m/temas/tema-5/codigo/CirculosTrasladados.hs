import CodeWorld

main :: IO ()
main = drawingOf circulosTrasladados

circulosTrasladados :: Picture
circulosTrasladados =
  pictures [translated x 0 (circle 3) | x <- [-6..6]]

  
