module EjemplosPol where

-- Elegir una de las representaciones
import PolRepTDA
-- import PolRepDispersa
-- import PolRepDensa

-- Ejemplos de polinomios con coeficientes enteros:
ejPol1, ejPol2, ejPol3, ejTerm:: Polinomio Int
ejPol1 = consPol 4 3 (consPol 2 (-5) (consPol 0 3 polCero))
ejPol2 = consPol 5 1 (consPol 2 5 (consPol 1 4 polCero))
ejPol3 = consPol 4 6 (consPol 1 2 polCero)
ejTerm = consPol 1 4 polCero

-- Sesión:
--    ghci> ejPol1
--    3*x^4 + -5*x^2 + 3
--    ghci> ejPol2
--    x^5 + 5*x^2 + 4*x
--    ghci> ejPol3
--    6*x^4 + 2*x
--    ghci> ejTerm
--    4*x
