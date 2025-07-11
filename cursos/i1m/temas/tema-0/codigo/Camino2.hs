import CodeWorld

main :: IO ()
main = drawingOf camino

camino :: Picture
camino = thickPath 1 [(-3,3),(3,3),(-3,-3),(3,-3)]
