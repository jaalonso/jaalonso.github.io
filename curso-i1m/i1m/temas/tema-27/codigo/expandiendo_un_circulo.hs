-- expandiendo_un_circulo.hs
-- Expandiendo un círculo.
-- José A. Alonso Jiménez <jalonso@us.es>
-- Sevilla, 21 de Mayo de 2013
-- ---------------------------------------------------------------------

import Graphics.Gloss

main :: IO ()
main = animate (InWindow "Expandiendo un circulo" (500,500) (20,20)) green animacion

animacion :: Float -> Picture
animacion t = circle (20 * t)

-- Nota: La variable t toma como valor el tiempo transcurrido. Sus
-- valores son [0,0.5..]. Por tanto, los radios son [0,10,..]. 

