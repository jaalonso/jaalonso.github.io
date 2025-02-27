import CodeWorld

main :: IO ()
main = drawingOf dosCuadrados

dosCuadrados :: Picture
dosCuadrados = cuadrado1 <> cuadrado2

cuadrado1, cuadrado2 :: Picture
cuadrado1 = polygon [(-3,-3),(-3,3),(3,3),(3,-3)]
cuadrado2 = polygon [(0,0),(0,6),(6,6),(6,0)]




  
