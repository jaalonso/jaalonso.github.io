---
author: 'José A. Alonso'
category: 'Resaltado'
date: 2024-04-19 14:00:00 UTC+02:00
description: ''
has_math: true
link: ''
slug: prueba-de-resaltado
tags: 'Haskell, Pythhon, Lean, Isabelle'
title: Prueba de resaltado y de matemática
type: text
---
Esta entrada es una prueba del resaltado de sintaxis de código y de
texto matemático con LaTeX.

<!-- TEASER_END -->

# Matemáticas

## Escritura matemática

* En línea: \\(e^{ix} = \cos x + i\sin x\\)
* Centrada: \\[e^{ix} = \cos x + i\sin x\\]

## Demostración

Tenemos que demostrar que, para toda $y$,
$$y ∈ f[s] ∩ t ↔ y ∈ f[s ∩ f⁻¹[t]]$$
Lo haremos probando las dos implicaciones.

(⟹) Supongamos que $y ∈ f[s] ∩ t$. Entonces, se tiene que

\begin{align}
   &y ∈ f[s] \tag{1} \newline
   &y ∈ t    \tag{2}
\end{align}

Por (1), existe un $x$ tal que

\begin{align}
   &x ∈ s     \tag{3} \newline
   &f(x) = y  \tag{4}
\end{align}

Por (2) y (4),
$$ f(x) ∈ t $$
y, por tanto,
$$ x ∈ f⁻¹[t] $$
que, junto con (3), da
$$ x ∈ s ∩ f⁻¹[t] $$
y, por tanto,
$$ f(x) ∈ f[s ∩ f⁻¹[t]] $$
que, junto con (4), da
$$ y ∈ f[s ∩ f⁻¹[t]] $$

(⟸) Supongamos que $y ∈ f[s ∩ f⁻¹[t]]$. Entonces, existe un $x$ tal que
\begin{align}
   &x ∈ s ∩ f⁻¹[t] \tag{5} \\\\
   &f(x) = y       \tag{6}
\\end{align}
Por (1), se tiene que
\begin{align}
   &x ∈ s      \tag{7} \\\\
   &x ∈ f⁻¹[t] \tag{8}
\\end{align}
Por (7) se tiene que
$$ f(x) ∈ f[s] $$
y, junto con (6), se tiene que
$$ y ∈ f[s] \tag{9} $$
Por (8), se tiene que
$$ f(x) ∈ t $$
y, junto con (6), se tiene que
$$ y ∈ t \tag{10} $$
Por (9) y (19), se tiene que
$$ y ∈ f[s] ∩ t $$

# Haskell

~~~haskell
module Reconocimiento_de_potencias_de_4 where

import Test.Hspec (Spec, describe, hspec, it, shouldBe)

-- 1ª solución
-- ===========

esPotenciaDe4_1 :: Integral a => a -> Bool
esPotenciaDe4_1 0 = False
esPotenciaDe4_1 1 = True
esPotenciaDe4_1 n = n `mod` 4 == 0 && esPotenciaDe4_1 (n `div` 4)
~~~

# Python

~~~phyton
from itertools import count, dropwhile, islice
from sys import setrecursionlimit
from timeit import Timer, default_timer
from typing import Callable, Iterator

setrecursionlimit(10**6)

# 1ª solución
# ===========

def esPotenciaDe4_1(n: int) -> bool:
    if n == 0:
        return False
    if n == 1:
        return True
    return n % 4 == 0 and esPotenciaDe4_1(n // 4)
~~~

# Lean

~~~lean
import Mathlib.Data.Set.Function

variable {α β : Type _}
variable (f : α → β)
variable (s t : Set α)

open Set

-- 1ª demostración
-- ===============

example : f '' (s ∪ t) = f '' s ∪ f '' t :=
by
  ext y
  -- y : β
  -- ⊢ y ∈ f '' (s ∪ t) ↔ y ∈ f '' s ∪ f '' t
  calc y ∈ f '' (s ∪ t)
     ↔ ∃ x, x ∈ s ∪ t ∧ f x = y :=
         by simp only [mem_image]
   _ ↔ ∃ x, (x ∈ s ∨ x ∈ t) ∧ f x = y :=
         by simp only [mem_union]
   _ ↔ ∃ x, (x ∈ s ∧ f x = y) ∨ (x ∈ t ∧ f x = y) :=
         by simp only [or_and_right]
   _ ↔ (∃ x, x ∈ s ∧ f x = y) ∨ (∃ x, x ∈ t ∧ f x = y) :=
         by simp only [exists_or]
   _ ↔ y ∈ f '' s ∨ y ∈ f '' t :=
         by simp only [mem_image]
   _ ↔ y ∈ f '' s ∪ f '' t :=
         by simp only [mem_union]

-- 2ª demostración
-- ===============

example : f '' (s ∪ t) = f '' s ∪ f '' t :=
by
  ext y
  -- y : β
  -- ⊢ y ∈ f '' (s ∪ t) ↔ y ∈ f '' s ∪ f '' t
  constructor
  . -- ⊢ y ∈ f '' (s ∪ t) → y ∈ f '' s ∪ f '' t
    intro h
    -- h : y ∈ f '' (s ∪ t)
    -- ⊢ y ∈ f '' s ∪ f '' t
    rw [mem_image] at h
    -- h : ∃ x, x ∈ s ∪ t ∧ f x = y
    rcases h with ⟨x, hx⟩
    -- x : α
    -- hx : x ∈ s ∪ t ∧ f x = y
    rcases hx with ⟨xst, fxy⟩
    -- xst : x ∈ s ∪ t
    -- fxy : f x = y
    rw [←fxy]
    -- ⊢ f x ∈ f '' s ∪ f '' t
    rw [mem_union] at xst
    -- xst : x ∈ s ∨ x ∈ t
    rcases xst with (xs | xt)
    . -- xs : x ∈ s
      apply mem_union_left
      -- ⊢ f x ∈ f '' s
      apply mem_image_of_mem
      -- ⊢ x ∈ s
      exact xs
    . -- xt : x ∈ t
      apply mem_union_right
      -- ⊢ f x ∈ f '' t
      apply mem_image_of_mem
      -- ⊢ x ∈ t
      exact xt
  . -- ⊢ y ∈ f '' s ∪ f '' t → y ∈ f '' (s ∪ t)
    intro h
    -- h : y ∈ f '' s ∪ f '' t
    -- ⊢ y ∈ f '' (s ∪ t)
    rw [mem_union] at h
    -- h : y ∈ f '' s ∨ y ∈ f '' t
    rcases h with (yfs | yft)
    . -- yfs : y ∈ f '' s
      rw [mem_image]
      -- ⊢ ∃ x, x ∈ s ∪ t ∧ f x = y
      rw [mem_image] at yfs
      -- yfs : ∃ x, x ∈ s ∧ f x = y
      rcases yfs with ⟨x, hx⟩
      -- x : α
      -- hx : x ∈ s ∧ f x = y
      rcases hx with ⟨xs, fxy⟩
      -- xs : x ∈ s
      -- fxy : f x = y
      use x
      -- ⊢ x ∈ s ∪ t ∧ f x = y
      constructor
      . -- ⊢ x ∈ s ∪ t
        apply mem_union_left
        -- ⊢ x ∈ s
        exact xs
      . -- ⊢ f x = y
        exact fxy
    . -- yft : y ∈ f '' t
      rw [mem_image]
      -- ⊢ ∃ x, x ∈ s ∪ t ∧ f x = y
      rw [mem_image] at yft
      -- yft : ∃ x, x ∈ t ∧ f x = y
      rcases yft with ⟨x, hx⟩
      -- x : α
      -- hx : x ∈ t ∧ f x = y
      rcases hx with ⟨xt, fxy⟩
      -- xt : x ∈ t
      -- fxy : f x = y
      use x
      -- ⊢ x ∈ s ∪ t ∧ f x = y
      constructor
      . -- ⊢ x ∈ s ∪ t
        apply mem_union_right
        -- ⊢ x ∈ t
        exact xt
      . -- ⊢ f x = y
        exact fxy
~~~

# Isabelle/HOL

~~~isabelle
theory Imagen_de_la_union
imports Main
begin

(* 1ª demostración *)
lemma "f ` (s ∪ t) = f ` s ∪ f ` t"
proof (rule equalityI)
  show "f ` (s ∪ t) ⊆ f ` s ∪ f ` t"
  proof (rule subsetI)
    fix y
    assume "y ∈ f ` (s ∪ t)"
    then show "y ∈ f ` s ∪ f ` t"
    proof (rule imageE)
      fix x
      assume "y = f x"
      assume "x ∈ s ∪ t"
      then show "y ∈ f ` s ∪ f ` t"
      proof (rule UnE)
        assume "x ∈ s"
        with ‹y = f x› have "y ∈ f ` s"
          by (simp only: image_eqI)
        then show "y ∈ f ` s ∪ f ` t"
          by (rule UnI1)
      next
        assume "x ∈ t"
        with ‹y = f x› have "y ∈ f ` t"
          by (simp only: image_eqI)
        then show "y ∈ f ` s ∪ f ` t"
          by (rule UnI2)
      qed
    qed
  qed
next
  show "f ` s ∪ f ` t ⊆ f ` (s ∪ t)"
  proof (rule subsetI)
    fix y
    assume "y ∈ f ` s ∪ f ` t"
    then show "y ∈ f ` (s ∪ t)"
    proof (rule UnE)
      assume "y ∈ f ` s"
      then show "y ∈ f ` (s ∪ t)"
      proof (rule imageE)
        fix x
        assume "y = f x"
        assume "x ∈ s"
        then have "x ∈ s ∪ t"
          by (rule UnI1)
        with ‹y = f x› show "y ∈ f ` (s ∪ t)"
          by (simp only: image_eqI)
      qed
    next
      assume "y ∈ f ` t"
      then show "y ∈ f ` (s ∪ t)"
      proof (rule imageE)
        fix x
        assume "y = f x"
        assume "x ∈ t"
        then have "x ∈ s ∪ t"
          by (rule UnI2)
        with ‹y = f x› show "y ∈ f ` (s ∪ t)"
          by (simp only: image_eqI)
      qed
    qed
  qed
qed

end
~~~
