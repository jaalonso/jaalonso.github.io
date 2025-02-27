import CodeWorld

main :: IO ()
main = drawingOf cuadradosGirados

cuadradosGirados :: Picture
cuadradosGirados =
  pictures [rotated x (rectangle 12 12) | x <- [0,pi/18..pi/2]]
  
  
