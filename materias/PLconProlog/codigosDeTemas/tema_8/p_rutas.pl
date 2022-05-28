% p_rutas.pl
% Problema de rutas entre ciudades (Van_Le-93 p. 281).
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-mayo-2022
% =============================================================================

% Descripción del problema
% ========================

% Se considera el siguiente mapa:
%
%       17  ······I··············L·································
%       16  ·     · ·                                             ·
%       15  A     ·   ·                                           ·
%       14  ·     ·     ·                                         ·
%       13  ······B       ····················                    ·
%       12        · ·                        ·                    ·
%       11        ·   ·                      N                    ·
%       10        ·     ·        S·····R     ·                    ·
%        9  ······C       ·      ·     ·     ·                    ·
%        8  ·     ·       ·      ·     Q·····P········U           ·
%        7  D     ·       ·      ·                    ·           ·
%        6  ······E       ·······T····················V           ·
%        5        ·              ·                                ·
%        4        ·              ·                                ·
%        3  ······G              W·········                       ·
%        2  ·     ·                       ·                       ·
%        1  H     ·                       ·                       ·
%        0  ······K·······················F·······················M
%
%          0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18
%
% El problema consiste en encontrar una ruta desde I hasta F.

% Representación del problema
% ===========================

% Un ESTADO es un átomo.

% estado_inicial(?E) se verifica si E es el estado inicial.
estado_inicial(i).

% estado_final(?E) se verifica si E es un estado final.
estado_final(f).

% sucesor(+E1,?E2) E2 es un sucesor del estado E1.
sucesor(E1,E2) :-
   conectados(E1,L),
   member(E2,L).

% conectados(?E,?L) se verifica si L es la lista de puntos conectados
% con E.
conectados(i,[a,b,n,l]).
conectados(a,[b,i]).
conectados(b,[a,c,t]).
conectados(c,[d,e]).
conectados(d,[c,e]).
conectados(e,[d,g]).
conectados(g,[h,k]).
conectados(h,[g,k]).
conectados(k,[h,f]).
conectados(f,[k,w,m]).
conectados(w,[t,f]).
conectados(t,[b,s,v,w]).
conectados(s,[t,r]).
conectados(r,[s,q]).
conectados(q,[r,p]).
conectados(p,[q,n,u]).
conectados(u,[p,v]).
conectados(v,[t,u]).
conectados(n,[p,i]).
conectados(l,[i,m]).
conectados(m,[l,f]).

% Heurística
% ==========

% heuristica(+E,?H) se verifica si H es la suma del tiempo de espera en
% el estado E más la distancia cartesiana entre el estado E y el estado
% final.
heuristica(E,H) :-
   tiempo_de_espera(E,T),
   coord(E,X,Y),
   estado_final(F),
   coord(F,X1,Y1),
   H is T + sqrt((X-X1)*(X-X1) + (Y-Y1)*(Y-Y1)).

% coord(+E,?X,?Y) se verifica si [X,Y] son las coordenadas de E.
coord(i,2,17).
coord(a,0,15).
coord(b,2,13).
coord(c,2,9).
coord(d,0,7).
coord(e,2,6).
coord(g,2,3).
coord(h,0,1).
coord(k,2,0).
coord(f,10,0).
coord(w,7,3).
coord(t,7,6).
coord(s,7,10).
coord(r,9,10).
coord(q,9,8).
coord(p,11,8).
coord(u,14,8).
coord(v,14,6).
coord(n,11,11).
coord(l,7,17).
coord(m,18,0).

% tiempo_de_espera(+E,?T) se verifica si T es el tiempo de espera en el
% estado E.
tiempo_de_espera(k,5) :- !.
tiempo_de_espera(f,0) :- !.
tiempo_de_espera(_,1).

% Coste
% =====

% coste(+E1,+E2,?C) se verifica si C es el coste de ir del estado E1 al
% E2.
coste(E1,E2,C) :-
   tiempo_de_espera(E1,T),
   distancia(E1,E2,D),
   C is T+D.

distancia(E1,E2,C) :-
   distancia(E1,Sucesores),
   member(E2:C,Sucesores),!.
distancia(E1,E2,C) :-
   coste(E2,E1,C).

% distancia(+E,?L) se verifica si L es una lista de elementos de la
% forma X:Y donde X es un sucesor de E e Y es la distancia entre E y X.
distancia(i,[a:3,b:4,n:12,l:5]).
distancia(a,[b:3]).
distancia(b,[c:4,t:11]).
distancia(c,[d:3,e:3]).
distancia(d,[e:2]).
distancia(e,[g:3]).
distancia(g,[h:3,k:3]).
distancia(h,[k:2]).
distancia(k,[f:8]).
distancia(f,[w:8,m:8]).
distancia(w,[t:3]).
distancia(t,[s:4,v:7]).
distancia(s,[r:2]).
distancia(r,[q:2]).
distancia(q,[p:2]).
distancia(p,[n:3,u:3]).
distancia(u,[v:2]).
distancia(l,[m:27]).

% Escritura de solución
% =====================

% escribe_solucion(+S) escribe la solución S.
escribe_solucion(S) :-
   format('~nSol: ~w~n',[S]).

% Problemas
% =========

% lista_de_numeros_de_heuristica(?L) se verifica si L es la lista de los
% números de heurísticas. 
lista_de_numeros_de_heuristica([]).

% agotado(+P,+Pr) se verifica si la resolución del problema P mediante
% el procedimiento Pr agota la memoria.
agotado(p_rutas, profundidad_sin_ciclos).

% sin_solucion(+P,+Pr) se verifica el procedimiento Pr no encuentra
% solución al problema P. 
sin_solucion(p_rutas,escalada).

% Experimentos
% ============

% Se usa el fichero experimentos.pl
%    ?- [experimentos].
%    true.

% Comparación de procedimientos
%    ?- compara_procedimientos(p_rutas).
%    
%    +---------------------------------------------------------------------------+
%    |                             Problema: p_rutas                             |
%    +---------------------------------------------------------------------------+
%    
%    Procedimiento: profundidad_sin_ciclos
%    Agotado
%    
%    Procedimiento: profundidad_con_ciclos
%    Sol: [i,a,b,c,d,e,g,h,k,f]
%    Coste: 56
%    223 inferencias en 0.00 segundos y 2,576 bytes.
%    
%    Procedimiento: profundidad_con_cerrados
%    Sol: [i,b,c,e,g,k,f]
%    Coste: 44
%    531 inferencias en 0.00 segundos y 6,904 bytes.
%    
%    Procedimiento: profundidad_iterativa
%    Sol: [i,l,m,f]
%    Coste: 44
%    504 inferencias en 0.00 segundos y 1,400 bytes.
%    
%    Procedimiento: anchura
%    Sol: [i,l,m,f]
%    Coste: 44
%    830 inferencias en 0.00 segundos y 13,168 bytes.
%    
%    Procedimiento: anchura_con_cerrados
%    Sol: [i,l,m,f]
%    Coste: 44
%    811 inferencias en 0.00 segundos y 11,320 bytes.
%    
%    Procedimiento: optimal_exhaustiva
%    Sol: [i,b,t,w,f]
%    Coste: 31
%    26,343 inferencias en 0.00 segundos y 1,960 bytes.
%    
%    Procedimiento: optimal
%    Sol: [i,b,t,w,f]
%    Coste: 31
%    3,439 inferencias en 0.00 segundos y 10,000 bytes.
%    
%    Procedimiento: escalada
%    Sin solución
%    
%    Procedimiento: primero_el_mejor
%    Sol: [i,n,p,u,v,t,w,f]
%    Coste: 47
%    631 inferencias en 0.00 segundos y -54,048 bytes.
%    
%    Procedimiento: a_estrella
%    Sol: [i,b,t,w,f]
%    Coste: 31
%    1,937 inferencias en 0.00 segundos y 36,040 bytes.
%    true.

% Estadísticas
%    ?- estadistica(p_rutas).
%    
%    +---------------------------------------------------------------------------+
%    |                             Problema: p_rutas                             |
%    +---------------------------------------------------------------------------+
%    | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
%    +------------------------+-----+----------+-----------+--------+------------+
%    |profundidad_sin_ciclos  |     | Agotado  |           |        |            |
%    |profundidad_con_ciclos  |  56 |          |       116 |   0.00 |      1,920 |
%    |profundidad_con_cerrados|  44 |          |       323 |   0.00 |      5,568 |
%    |profundidad_iterativa   |  44 |          |       398 |   0.00 |        744 |
%    |anchura                 |  44 |          |       622 |   0.00 |     11,832 |
%    |anchura_con_cerrados    |  44 |          |       603 |   0.00 |      9,984 |
%    |optimal_exhaustiva      |  31 |          |    26,341 |   0.00 |      1,960 |
%    |optimal                 |  31 |          |     3,230 |   0.00 |      9,136 |
%    |escalada                |     | Sin sol. |           |        |            |
%    |primero_el_mejor        |  47 |          |       422 |   0.00 |      8,488 |
%    |a_estrella              |  31 |          |     1,727 |   0.00 |     34,704 |
%    +------------------------+-----+----------+-----------+--------+------------+
%    true.
