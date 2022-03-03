import CodeWorld

main :: IO ()
main = drawingOf camino

camino :: Picture
camino = path [(-3,3),(3,3),(-3,-3),(3,-3)]
