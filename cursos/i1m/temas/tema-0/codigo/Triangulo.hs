import CodeWorld

main :: IO ()
main = drawingOf triangulo

triangulo :: Picture
triangulo = polygon [(-9,-9),(0,9),(9,-9)]
