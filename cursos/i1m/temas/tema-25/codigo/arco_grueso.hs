import Graphics.Gloss

main :: IO ()
main = display (InWindow "Dibujo" (300,300) (20,20)) white arcoGrueso

arcoGrueso :: Picture
arcoGrueso = thickArc 0 90 100 50
