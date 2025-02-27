-- plato.hs
-- Plato con comida
-- José A. Alonso Jiménez <jalonso@us.es>
-- Sevilla, 21 de Mayo de 2013
-- ---------------------------------------------------------------------

-- ---------------------------------------------------------------------
-- Ejercicio. Dibujar un plato con comida com el de la figura plato.png
-- ---------------------------------------------------------------------

import Graphics.Gloss

main :: IO ()
main = display (InWindow "Dibujo" (500,500) (20,20)) white dibujo

dibujo :: Picture
dibujo = plato_con_comida

plato_con_comida = 
  pictures [ mesa,
             plato,
             comida,
             translate ( 200) 0 tenedor,
             translate (-200) 0 cuchillo ]

mesa = color marron (rectangleSolid 500 500)

plato = 
  pictures [ color gris      (circleSolid 175),
             color grisClaro (circleSolid 150) ]

comida = 
  pictures [ translate (-50) ( 50) (rotate   45  zanahoria),
             translate (-20) (-40) (rotate   20  brocoli),
             translate ( 60) (-30) (rotate (-10) brocoli) ]

zanahoria = 
  color orange 
        (polygon [(-5,-40),(-20,40),(20,40),(5,-40) ])

brocoli = 
  color (dark green) 
        (pictures [ translate (  0) (-15) (rectangleSolid 30 50), -- base
                    translate (-15) (  0) (circleSolid 25),       -- flor
                    translate ( 15) (  0) (circleSolid 25),       -- flor
                    translate (  0) ( 15) (circleSolid 25)        -- flor
                  ])

tenedor = 
  color grisClaro 
        (pictures [rectangleSolid 10 250,                        -- mango
                   translate (  0) ( 80) (rectangleSolid 40 10), -- base
                   translate (-15) (100) (rectangleSolid 10 45), -- diente izquierdo
                   translate ( 15) (100) (rectangleSolid 10 45)  -- diente derecho
                  ])

cuchillo = 
  color grisClaro 
        (pictures [translate 0 (-25) (rectangleSolid 30 200),    -- mango
                   polygon [ (-15,  75),
                             ( -5, 105),
                             ( 15, 125),
                             ( 15,  75) ]                        -- hoja
                  ])

-- Algunos colores usados en el dibujo:
marron    = dark orange
grisClaro = dark white
gris      = dark grisClaro
