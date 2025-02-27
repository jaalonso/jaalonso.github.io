import CodeWorld

main :: IO()
main = drawingOf arcoiris

arcoiris :: Picture
arcoiris =
  translated 0 (-4) (pictures [ colored c (thickArc 1 0 pi r)
                              | (c,r) <- zip [ white
                                             , violet
                                             , azure
                                             , blue
                                             , green
                                             , yellow
                                             , orange
                                             , red]
                                             [2..9]])
  
