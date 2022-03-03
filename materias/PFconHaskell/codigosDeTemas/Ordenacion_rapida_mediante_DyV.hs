-- Ordenacion_rapida_mediante_DyV.hs
-- Ordenación rápida mediante divide y vencerás.
-- José A. Alonso Jiménez <jalonso@us.es>
-- Sevilla, 7 de Abril de 2015
-- ---------------------------------------------------------------------

import I1M.DivideVenceras

-- ---------------------------------------------------------------------
-- Ordenación rápida                                                  --
-- ---------------------------------------------------------------------

-- (ordenaRapida xs) es la lista obtenida ordenando xs por el
-- procedimiento de ordenación rápida. Por ejemplo,
--    ghci> ordenaRapida [3,1,4,1,5,9,2,8]
--    [1,1,2,3,4,5,8,9]
ordenaRapida :: Ord a => [a] -> [a]
ordenaRapida xs = 
    divideVenceras ind id divide combina xs
    where 
      ind xs                = length xs <= 1
      divide (x:xs)         = [[ y | y<-xs, y<=x],
                               [ y | y<-xs, y>x] ]
      combina (x:_) [l1,l2] = l1 ++ [x] ++ l2

