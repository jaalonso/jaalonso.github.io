import CodeWorld

main :: IO()
main = animationOf koch 

koch :: Double -> Picture
koch t = 
     path (fractal 16.0 (fromInteger (mod (round (t)) 6))
                    0.0 (-8.0,5.0) [(-8.0,5.0)])
  <> path (fractal 16.0 (fromInteger (mod (round (t)) 6))
                   (-2*pi/3) (8.0,5.0) [(8.0,5.0)])
  <> path (fractal 16.0 (fromInteger (mod (round (t)) 6))
                   (2*pi/3) lp [lp])

type Punto = (Double,Double)

fractal :: Double -> Double -> Double -> Punto -> [Punto] -> [Punto]
fractal lon it ang (x,y) puntos = 
  if lon <= 18.0 /(3.0**it) 
  then puntos ++ [(x + lon*cos ang, y + lon*sin ang)]
  else a
    where 
      b =  fractal (lon/3) it (ang) (last puntos) puntos 
      c =  fractal (lon/3) it (ang+pi/3) (last b) b
      d =  fractal (lon/3) it (ang-pi/3) (last c) c
      a =  fractal (lon/3) it (ang) (last d) d

lp :: Punto
lp = last ( fractal 16.0 0  (-pi/2-pi/6) (8.0,5.0) [(8.0,5.0)] )

