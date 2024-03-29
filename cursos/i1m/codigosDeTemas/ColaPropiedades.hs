-- propiedadesColas.hs
-- Propiedades del TAD colas.
-- José A. Alonso Jiménez <jalonso@us.es>
-- ---------------------------------------------------------------------

{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TemplateHaskell #-}

-- Hay que elegir una implementación del TAD colas:
import ColaConListas
-- import ColaConDosListas

import Data.List
import Test.QuickCheck

-- ---------------------------------------------------------------------
-- Generador de colas                                          --
-- ---------------------------------------------------------------------

-- genCola es un generador de colas de enteros. Por ejemplo,
--    ghci> sample genCola
--    C ([],[])
--    C ([],[])
--    C ([],[])
--    C ([],[])
--    C ([7,8,4,3,7],[5,3,3])
--    C ([],[])
--    C ([1],[13])
--    C ([18,28],[12,21,28,28,3,18,14])
--    C ([47],[64,45,7])
--    C ([8],[])
--    C ([42,112,178,175,107],[])
genCola :: Gen (Cola Int)
genCola = frequency [(1, return vacia),
                     (30, do n <- choose (10,100)
                             xs <- vectorOf n arbitrary
                             return (creaCola xs))]
          where creaCola = foldr inserta vacia

-- El tipo pila es una instancia del arbitrario.
instance Arbitrary (Cola Int) where
    arbitrary = genCola

-- Propiedad. Todo los elementos generados por genCola son colas
-- válidas.
prop_genCola_correcto :: Cola Int -> Bool
prop_genCola_correcto c = valida c

-- Comprobación.
--    ghci> quickCheck prop_genCola_correcto
--    +++ OK, passed 100 tests.

-- ---------------------------------------------------------------------
-- Propiedades
-- ---------------------------------------------------------------------

-- Propiedad. El primero de la cola obtenida añadiendo x a la cola vacía
-- es x.
prop_primero_inserta_vacia :: Int -> Bool
prop_primero_inserta_vacia x =
    primero (inserta x vacia) == x

-- Comprobación.
--    > quickCheck prop_primero_inserta_vacia
--    +++ OK, passed 100 tests.

-- Propiedad. Si una cola no está vacía, su primer elemento no varía al
-- añadirle un elemento.
prop_primero_inserta_no_vacia :: Cola Int -> Int -> Int -> Bool
prop_primero_inserta_no_vacia c x y =
    primero (inserta x c') == primero c'
    where c' = inserta y vacia

-- Comprobación.
--    > quickCheck prop_primero_inserta_no_vacia
--    +++ OK, passed 100 tests.

-- Propiedad. El resto de la cola obtenida insertando un elemento en la
-- cola vacía es la cola vacía.
prop_resto_inserta_vacia :: Int -> Bool
prop_resto_inserta_vacia x =
    resto (inserta x vacia) == vacia

-- Comprobación.
--    > quickCheck prop_resto_inserta_vacia
--    +++ OK, passed 100 tests.

-- Propiedad. Las operaciones de inserta y resto conmutan.
prop_resto_inserta_en_no_vacia :: Cola Int -> Int -> Int -> Bool
prop_resto_inserta_en_no_vacia c x y =
    resto (inserta x c') == inserta x (resto c')
    where c' = inserta y c

-- Comprobación.
--    > quickCheck prop_resto_inserta_en_no_vacia
--    +++ OK, passed 100 tests.

-- Propiedad. vacia es una cola vacía.
prop_vacia_es_vacia :: Bool
prop_vacia_es_vacia =
    esVacia vacia

-- Comprobación.
--    > quickCheck prop_vacia_es_vacia
--    +++ OK, passed 100 tests.

-- Propiedad. La cola obtenida insertando un elemento no es vacía.
prop_inserta_no_es_vacia :: Int -> Cola Int -> Bool
prop_inserta_no_es_vacia x c =
    not (esVacia (inserta x c))

-- Comprobación
--    > quickCheck prop_inserta_no_es_vacia
--    +++ OK, passed 100 tests.

-- ---------------------------------------------------------------------
-- Propiedades de la normalización                                    --
-- ---------------------------------------------------------------------

-- Propiedad. La cola vacía es válida.
prop_valida_vacia :: Bool
prop_valida_vacia = valida vacia

-- Comprobación
--    ghci> quickCheck prop_valida_vacia
--    +++ OK, passed 100 tests.

-- Propiedad. Al añadirle un elemento a una cola válida se obtiene otra
-- cola válida.
prop_valida_inserta :: Cola Int -> Int -> Property
prop_valida_inserta c x =
    valida c ==> valida (inserta x c)

-- Comprobación.
--    ghci> quickCheck prop_valida_inserta
--    +++ OK, passed 100 tests.

-- Propiedad. El resto de una cola válida y no vacía es una cola válida.
prop_valida_resto :: Cola Int -> Property
prop_valida_resto c =
    valida c && not (esVacia c) ==> valida (resto c)

-- Comprobación
--    *Main> quickCheck prop_valida_resto
--    +++ OK, passed 100 tests.

-- ---------------------------------------------------------------------
-- § Verificación de todas las propiedades                            --
-- ---------------------------------------------------------------------

-- Para verificar todas las propiedades se escribe
return []
verifica = $quickCheckAll

-- La verificación es
λ> verifica
=== prop_genCola_correcto from ColaPropiedades.hs:46 ===
+++ OK, passed 100 tests.

=== prop_primero_inserta_vacia from ColaPropiedades.hs:59 ===
+++ OK, passed 100 tests.

=== prop_primero_inserta_no_vacia from ColaPropiedades.hs:69 ===
+++ OK, passed 100 tests.

=== prop_resto_inserta_vacia from ColaPropiedades.hs:80 ===
+++ OK, passed 100 tests.

=== prop_resto_inserta_en_no_vacia from ColaPropiedades.hs:89 ===
+++ OK, passed 100 tests.

=== prop_vacia_es_vacia from ColaPropiedades.hs:99 ===
+++ OK, passed 1 tests.

=== prop_inserta_no_es_vacia from ColaPropiedades.hs:108 ===
+++ OK, passed 100 tests.

=== prop_valida_vacia from ColaPropiedades.hs:121 ===
+++ OK, passed 1 tests.

=== prop_valida_inserta from ColaPropiedades.hs:130 ===
+++ OK, passed 100 tests.

=== prop_valida_resto from ColaPropiedades.hs:139 ===
+++ OK, passed 100 tests.

True
