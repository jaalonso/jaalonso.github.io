-- moviendo_un_circulo.hs
-- Moviendo un círculo.
-- José A. Alonso Jiménez <jalonso@us.es>
-- Sevilla, 21 de Mayo de 2013
-- ---------------------------------------------------------------------

import Graphics.Gloss

main :: IO ()
main = animate (InWindow "Moviendo un circulo" (500,500) (20,20)) green animacion

animacion :: Float -> Picture
animacion t = rotate (60 * t) (translate 100 0 (color (masRojo (0.2*t)) (circleSolid 25)))

masRojo :: Float -> Color
masRojo t = mixColors (1.0-t) t black red
