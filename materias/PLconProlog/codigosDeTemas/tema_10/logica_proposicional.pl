% logica_proposicional.pl
% Formalización en Prolog de la lógica proposicional.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 7-junio-2022
% ======================================================================

% § Sintaxis de la lógica proposicional
% =====================================

% Las conectivas lógicas son - (negación), & (conjunción), v
% (disyunción), => (condicional) y <=> (equivalencia). La precedencia
% entre las conectivas es -, &, v, => y <=>. Las conectivas binarias
% asocian por la derecha. Por ejemplo,
%    ?- p & -q v r => s = ((p & -q) v r) => s.
%    true.
%    ?- p & -q v r => s = (p & (-q v r)) => s.
%    false.
%    ?- p & q & r = p & (q & r).
%    true.
%    ?- p & q & r = (p & q) & r.
%    false.
:- op(610, fy, -).   % negación             
:- op(620, xfy,&).   % conjunción           
:- op(630, xfy,v).   % disyunción           
:- op(640, xfy,=>).  % condicional
:- op(650, xfy,<=>). % equivalencia         

% § Semántica de la lógica proposicional
% ======================================

% §§ Valores de verdad
% ====================

% Los valores de verdad se representan por los símbolos
%    1: verdadero y
%    0: falso.
valor_de_verdad(0).
valor_de_verdad(1).

% §§ Funciones de verdad
% ======================

% función_de_verdad(+Op, +V1, -V) se verifica si Op(V1)) = V. 
función_de_verdad(-,  1, 0).
función_de_verdad(-,  0, 1).

% función_de_verdad(+Op, +V1, +V2, -V) se verifica si Op(V1,V2)=V.
función_de_verdad(v,   0, 0, 0) :- !.
función_de_verdad(v,   _, _, 1).
función_de_verdad(&,   1, 1, 1) :- !.
función_de_verdad(&,   _, _, 0).
función_de_verdad(=>,  1, 0, 0) :- !.
función_de_verdad(=>,  _, _, 1).
función_de_verdad(<=>, X, X, 1) :- !.
función_de_verdad(<=>, _, _, 0).

% §§ Interpretaciones
% ===================

% Las interpretaciones son listas de pares formados por un símbolo
% proposicional y un valor de verdad. Por ejemplo, [(p,1),(r,0),(u,1)]
% representa una interpretación.

% §§ Valor de una fórmula en una interpretación
% =============================================

% valor(+F, +I, -V) se verifica si el valor de la fórmula F en la
% interpretación I es V. Por ejemplo, 
%    ?- valor((p v q) & (-q v r), [(p,1),(q,0),(r,1)], V).
%    V = 1 
%    ?- valor((p v q) & (-q v r), [(p,0),(q,0),(r,1)], V).
%    V = 0 
valor(F, I, V) :-
   memberchk((F,V), I).
valor(-A, I, V) :-
   valor(A, I, VA),
   función_de_verdad(-, VA, V).
valor(F, I, V) :-
   F =..[Op,A,B],
   valor(A, I, VA),
   valor(B, I, VB),
   función_de_verdad(Op, VA, VB, V).

% §§ Interpretaciones de una fórmula
% ==================================

% interpretaciones_fórmula(+F,-L) se verifica si L es el conjunto de las
% interpretaciones de la fórmula F. Por ejemplo,  
%    ?- interpretaciones_fórmula((p v q) & (-q v r),L).
%    L = [[ (p, 0),  (q, 0),  (r, 0)],
%         [ (p, 0),  (q, 0),  (r, 1)],
%         [ (p, 0),  (q, 1),  (r, 0)],
%         [ (p, 0),  (q, 1),  (r, 1)],
%         [ (p, 1),  (q, 0),  (r, 0)],
%         [ (p, 1),  (q, 0),  (r, 1)],
%         [ (p, 1),  (q, 1),  (r, 0)],
%         [ (p, 1),  (q, 1),  (r, 1)]] 
interpretaciones_fórmula(F,U) :-
   findall(I,interpretación_fórmula(I,F),U).

% interpretación_fórmula(?I,+F) se verifica si I es una interpretación
% de la fórmula F. Por ejemplo, 
%    ?- interpretación_fórmula(I,(p v q) & (-q v r)).
%    I = [ (p, 0),  (q, 0),  (r, 0)] ;
%    I = [ (p, 0),  (q, 0),  (r, 1)] ;
%    I = [ (p, 0),  (q, 1),  (r, 0)] ;
%    I = [ (p, 0),  (q, 1),  (r, 1)] ;
%    I = [ (p, 1),  (q, 0),  (r, 0)] ;
%    I = [ (p, 1),  (q, 0),  (r, 1)] ;
%    I = [ (p, 1),  (q, 1),  (r, 0)] ;
%    I = [ (p, 1),  (q, 1),  (r, 1)] ;
%    false.
interpretación_fórmula(I,F) :-
   símbolos_fórmula(F,U),
   interpretación_símbolos(U,I).

% símbolos_fórmula(+F,?U) se verifica si U es el conjunto ordenado de
% los símbolos proposicionales de la fórmula F. Por ejemplo,   
%    ?- símbolos_fórmula((p v q) & (-q v r), U).
%    U = [p, q, r]
símbolos_fórmula(F,U) :-
   símbolos_fórmula_1(F,U).

% Primera versión:
símbolos_fórmula_1(F,U) :-
   símbolos_fórmula_aux(F,U1),
   sort(U1,U).

símbolos_fórmula_aux(F,[F]) :-
   atom(F).
símbolos_fórmula_aux(-F,U) :-
   símbolos_fórmula_aux(F,U).
símbolos_fórmula_aux(F,U) :-
   F =..[_Op,A,B],
   símbolos_fórmula_aux(A,UA),
   símbolos_fórmula_aux(B,UB),
   union(UA,UB,U).

% Segunda versión:
símbolos_fórmula_2(F,U) :-
   setof(A,símbolo_fórmula(A,F),U).

símbolo_fórmula(F,F) :-
   atom(F).
símbolo_fórmula(A,F) :-
   F =.. [_Op|L],
   member(G,L),
   símbolo_fórmula(A,G).

% interpretación_símbolos(+L,-I) se verifica si I es una interpretación
% para la lista de átomos L (i.e. una lista de pares (X,Y) con X un
% elemento de L e Y un valor de verdad (0 ó 1)). Por ejemplo, 
%    ?- interpretación_símbolos([p,q,r],I).
%    I = [ (p, 0),  (q, 0),  (r, 0)] ;
%    I = [ (p, 0),  (q, 0),  (r, 1)] ;
%    I = [ (p, 0),  (q, 1),  (r, 0)] ;
%    I = [ (p, 0),  (q, 1),  (r, 1)] ;
%    I = [ (p, 1),  (q, 0),  (r, 0)] ;
%    I = [ (p, 1),  (q, 0),  (r, 1)] ;
%    I = [ (p, 1),  (q, 1),  (r, 0)] ;
%    I = [ (p, 1),  (q, 1),  (r, 1)].
interpretación_símbolos([], []).
interpretación_símbolos([A|L],[(A,V)|IL]) :-
   valor_de_verdad(V),
   interpretación_símbolos(L, IL).

% §§ Modelo de una fórmula
% ========================

% es_modelo_fórmula(+I,+F) se verifica si la interpretación I es un
% modelo de la fórmula F. Por ejemplo, 
%    ?- es_modelo_fórmula([(p,1),(q,0),(r,1)], (p v q) & (-q v r)).
%    true
%    ?- es_modelo_fórmula([(p,0),(q,0),(r,1)], (p v q) & (-q v r)).
%    false.
es_modelo_fórmula(I,F) :-
   valor(F,I,V),
   V = 1.

% Nota: No puede usarse valor(F,I,1) porque el tercer argumento de valor/3
% tiene que ser una variable (por la definición abreviada de
% función_de_verdad) y daría errores como
%    es_modelo_fórmula([ (p, 1),  (q, 0)], p=>q).

% §§ Cálculo de los modelos de una fórmula
% ========================================

% modelos_fórmula(+F,-L) se verifica si L es el conjunto de los modelos
% principales de la fórmula F. Por ejemplo, 
%    ?- modelos_fórmula((p v q) & (-q v r),L).
%    L = [[ (p, 0),  (q, 1),  (r, 1)],
%         [ (p, 1),  (q, 0),  (r, 0)],
%         [ (p, 1),  (q, 0),  (r, 1)],
%         [ (p, 1),  (q, 1),  (r, 1)]] 
modelos_fórmula(F,L) :-
   findall(I,modelo_fórmula(I,F),L).

% modelo_fórmula(?I,+F) se verifica si I es un modelo básico de la
% fórmula F. Por ejemplo, 
%    ?- modelo_fórmula(I,(p v q) & (-q v r)).
%    I = [ (p, 0),  (q, 1),  (r, 1)] ;
%    I = [ (p, 1),  (q, 0),  (r, 0)] ;
%    I = [ (p, 1),  (q, 0),  (r, 1)] ;
%    I = [ (p, 1),  (q, 1),  (r, 1)] ;
%    false.
modelo_fórmula(I,F) :-
   interpretación_fórmula(I,F),
   es_modelo_fórmula(I,F).

% §§ Fórmulas satisfacibles e insatisfacibles
% ===========================================

% es_satisfacible(+F) se verifica si la fórmula F es satisfacible. Por
% ejemplo, 
%    ?- es_satisfacible((p => q) & (q => r)).
%    true
%    ?- es_satisfacible(p & -p).
%    false.
%    ?- es_satisfacible((p v q) & (p => r) & (q => -r)).
%    true
%    ?- es_satisfacible((p & q) & (p => r) & (q => -r)).
%    false.
%    ?- es_satisfacible(p => q).
%    true
%    ?- es_satisfacible(-(p => q)).
%    true
es_satisfacible(F) :-
   interpretación_fórmula(I,F),
   es_modelo_fórmula(I,F).

% §§ Contramodelos de fórmulas
% ============================

% contramodelo_fórmula(?I,+F) se verifica si I es un contramodelo básico
% de la fórmula F. Por ejemplo, 
%    ?- contramodelo_fórmula(I, p <=> q).
%    I = [ (p, 0),  (q, 1)] ;
%    I = [ (p, 1),  (q, 0)] ;
%    false.
%    ?- contramodelo_fórmula(I, p => p).
%    false.
contramodelo_fórmula(I,F) :-
   interpretación_fórmula(I,F),
   \+ es_modelo_fórmula(I,F).

% §§ Fórmulas válidas (tautologías)
% =================================

% es_tautología(+F) se verifica si la fórmula F es una tautología. Por
% ejemplo, 
%    ?- es_tautología((p => q) v (q => p)).
%    true.
%    ?- es_tautología(p => q).
%    false.
es_tautología(F) :-
   \+ contramodelo_fórmula(_I,F).

% §§ Interpretaciones de un conjunto de fórmulas
% ==============================================

% interpretaciones_conjunto(+S,-L) se verifica si L es el conjunto de
% las interpretaciones del conjunto de fórmulas S. Por ejemplo, 
%    ?- interpretaciones_conjunto([p => q, q=> r],U).
%    U = [[ (p, 0),  (q, 0),  (r, 0)],
%         [ (p, 0),  (q, 0),  (r, 1)],
%         [ (p, 0),  (q, 1),  (r, 0)],
%         [ (p, 0),  (q, 1),  (r, 1)],
%         [ (p, 1),  (q, 0),  (r, 0)],
%         [ (p, 1),  (q, 0),  (r, 1)],
%         [ (p, 1),  (q, 1),  (r, 0)],
%         [ (p, 1),  (q, 1),  (r, 1)]] 
interpretaciones_conjunto(S,U) :-
   findall(I,interpretación_conjunto(I,S),U).

% interpretación_conjunto(?I,+S) se verifica si I es una interpretación
% del conjunto de fórmulas S. Por ejemplo,
%    ?- interpretación_conjunto(I,[p => q, q=> r]).
%    I = [ (p, 0),  (q, 0),  (r, 0)] ;
%    I = [ (p, 0),  (q, 0),  (r, 1)] ;
%    I = [ (p, 0),  (q, 1),  (r, 0)] ;
%    I = [ (p, 0),  (q, 1),  (r, 1)] ;
%    I = [ (p, 1),  (q, 0),  (r, 0)] ;
%    I = [ (p, 1),  (q, 0),  (r, 1)] ;
%    I = [ (p, 1),  (q, 1),  (r, 0)] ;
%    I = [ (p, 1),  (q, 1),  (r, 1)] ;
%    false.
interpretación_conjunto(I,S) :-
   símbolos_conjunto(S,U),
   interpretación_símbolos(U,I).

% símbolos_conjunto(+S,?U) se verifica si U es el conjunto ordenado de
% los símbolos proposicionales del conjunto de fórmulas S. Por ejemplo,   
%    ?- símbolos_conjunto([p => q, q=> r],U).
%    U = [p, q, r] 
símbolos_conjunto(S,U) :-
   símbolos_conjunto_1(S,U).

% Primera versión:
símbolos_conjunto_1(S,U) :-
   símbolos_conjunto_aux(S,U1),
   sort(U1,U).

símbolos_conjunto_aux([],[]).
símbolos_conjunto_aux([F|S],U) :-
   símbolos_fórmula(F,U1),
   símbolos_conjunto_aux(S,U2),
   union(U1,U2,U).

% Segunda versión:
símbolos_conjunto_2(S,U) :-
   setof(A,F^(member(F,S),símbolo_fórmula(A,F)),U).

% §§ Modelo de un conjunto de fórmulas
% ====================================

% es_modelo_conjunto(+I,+S) se verifica si la interpretación I es un
% modelo del conjunto de fórmulas S. Por ejemplo, 
%    ?- es_modelo_conjunto([(p,1),(q,0),(r,1)],[(p v q) & (-q v r),q => r]).
%    true.
%    ?- es_modelo_conjunto([(p,0),(q,1),(r,0)],[(p v q) & (-q v r),q => r]).
%    false.
es_modelo_conjunto(_I,[]).
es_modelo_conjunto(I,[F|S]) :-
   es_modelo_fórmula(I,F),
   es_modelo_conjunto(I,S).

% §§ Modelos de un conjunto de fórmulas
% =====================================

% modelos_conjunto(+S,-L) se verifica si L es el conjunto de los modelos
% (básicos) del conjunto de fórmulas S. Por ejemplo,  
%    ?- modelos_conjunto([(p v q) & (-q v r),p => r],L).
%    L = [[ (p, 0),  (q, 1),  (r, 1)],
%         [ (p, 1),  (q, 0),  (r, 1)],
%         [ (p, 1),  (q, 1),  (r, 1)]] 
modelos_conjunto(S,L) :-
   findall(I,modelo_conjunto(I,S),L).

% modelo_conjunto(?I,+S) se verifica si I es un modelo básico del
% conjunto de fórmulas S. Por ejemplo, 
%    ?- modelo_conjunto(I,[(p v q) & (-q v r),p => r]).
%    I = [ (p, 0),  (q, 1),  (r, 1)] ;
%    I = [ (p, 1),  (q, 0),  (r, 1)] ;
%    I = [ (p, 1),  (q, 1),  (r, 1)] ;
%    false.
modelo_conjunto(I,S) :-
   interpretación_conjunto(I,S),
   es_modelo_conjunto(I,S).

% §§ Conjuntos consistentes e inconsistentes de fórmulas
% ======================================================

% consistente(+S) se verifica si el conjunto de fórmulas S es
% consistente. Por ejemplo, 
%    ?- consistente([(p v q) & (-q v r),p => r]).
%    true.
%    ?- consistente([(p v q) & (-q v r),p => r, -r]).
%    false.
consistente(S) :-
   modelo_conjunto(_I,S), !.

% inconsistente(+S) se verifica si el conjunto de fórmulas S es
% inconsistente. Por ejemplo, 
%    ?- inconsistente([(p v q) & (-q v r),p => r, -r]).
%    true.
%    ?- inconsistente([(p v q) & (-q v r),p => r]).
%    false.
inconsistente(S) :-
   \+ modelo_conjunto(_I,S).

% §§ Consecuencia lógica
% ======================

% es_consecuencia(+S,+F) se verifica si la fórmula F es consecuencia del
% conjunto de fórmulas S (i.e.  S |= F). Por ejemplo, 
%    ?- es_consecuencia([p => q, q => r], p => r).
%    true.
%    ?- es_consecuencia([p], p & q).
%    false.
%    ?- es_consecuencia([p <=> q, r <=> (p & q)], p & r).
%    false.
%    ?- es_consecuencia([p <=> q, r <=> (p & q)], p <=> r).
%    true.
%    ?- es_consecuencia(
%          [tiene_pelos v da_leche => es_mamifero,
%           es_mamifero & (tiene_pezugnas v rumia) => es_ungulado,
%           es_ungulado & tiene_cuello_largo => es_jirafa,
%           es_ungulado & tiene_rayas_negras => es_cebra,
%           tiene_pelos & tiene_pezugnas & tiene_rayas_negras],
%          es_cebra).
%    true.
es_consecuencia(S,F) :-
   \+ contramodelo_consecuencia(S,F,_I).

% contramodelo_consecuencia(+S,+F,?I) se verifica si I es un modelo del
% conjunto de fórmulas S que no es modelo de la fórmula F. Por ejemplo, 
%    ?- contramodelo_consecuencia([p], p & q, I).
%    I = [ (p, 1),  (q, 0)] ;
%    false.
%    ?- contramodelo_consecuencia([p => q, q=> r], p => r, I).
%    false.
%    ?- contramodelo_consecuencia([p => q, q=> r], p <=> r, I).
%    I = [ (p, 0),  (q, 0),  (r, 1)] ;
%    I = [ (p, 0),  (q, 1),  (r, 1)] ;
%    false.
%    ?- contramodelo_consecuencia([p <=> q, r <=> (p & q)], p & r, I).
%    I = [ (p, 0),  (q, 0),  (r, 0)] ;
%    false.
contramodelo_consecuencia(S,F,I) :-
   interpretación_conjunto(I,[F|S]),
   es_modelo_conjunto(I,S),
   \+ es_modelo_fórmula(I,F).

% Segunda versión:
es_consecuencia_2(S,F) :-
   inconsistente([-F|S]).

% Tercera versión:
es_consecuencia_3(S,F) :-
   forall((interpretación_conjunto(I,[F|S]), es_modelo_conjunto(I,S)),
          es_modelo_fórmula(I,F)).

% §§ El problema de los veraces y mentirosos
% ==========================================

% Enunciado
% ---------

% En una isla hay dos tribus, la de los veraces (que siempre dicen la
% verdad) y la de los mentirosos (que siempre mienten). Un viajero se
% encuentra con tres isleños A, B y C y cada uno le dice una frase 
% + A dice "B y C son veraces syss C es veraz"
% + B dice "Si A y B son veraces, entonces B y C son veraces y A es
%   mentiroso" 
% + C dice "B es mentiroso syss A o B es veraz"
% 
% Determinar a qué tribu pertenecen A, B y C. 

% Representación
% --------------

% Representaremos por a, b y c que A, B y C son veraces. Por tanto, -a,
% -b y -c representan que A, B y C son mentirosos.

% Solución
% --------

% Las tribus se determinan a partir de los modelos del conjunto de
% fórmulas correspondientes a las tres frases.
%    ?- modelos_conjunto([a <=> (b & c <=> c),
%                         b <=> (a & c => b & c & -a),
%                         c <=> (-b <=> a v b)],
%                        L).
%    L == [[ (a, 1), (b, 1), (c, 0)]] .
% Por tanto, A y B son veraces y C es mentiroso.

% § Tableros semánticos
% =====================

% §§ Notación uniforme
% ====================

% literal(+F) se verifica si la fórmula F es un literal. Por ejemplo,
%    ?- literal(p).
%    true.
%    ?- literal(-p).
%    true.
%    ?- literal(p => q).
%    false.
literal(F)  :- atom(F).
literal(-F) :- atom(F).

% alfa(+A, -A1, -A2) se verifica si A es una fórmula alfa y sus
% componentes son A1 y A2. 
alfa(A1 & A2, A1, A2).
alfa(-(A1 => A2), A1, -A2).
alfa(-(A1 v A2), -A1, -A2).

% beta(+B, -B1, -B2) se verifica si B es una fórmula beta y sus
% componentes son B1 y B2. 
beta(B1 v B2, B1, B2).
beta(B1 => B2, -B1, B2).
beta(-(B1 & B2), -B1, -B2).
beta(B1 <=> B2, B1 & B2, -B1 & -B2).
beta(-(B1 <=> B2),  B1 & -B2, -B1 & B2).

% §§ Representación de tableros
% =============================

% t(S1, Izq, Dcha) representa al tablero cuya raiz es la lista de
% fórmulas S1, Izq es el subtablero izquierdo y Dcha es el subtablero
% derecho.

% §§ Procedimiento de completación de tableros
% ============================================

% tablero_completo(+S,-Tab) se verifica si Tab es un tablero completo
% del conjunto de fórmulas S. Por ejemplo,
%    ?- tablero_completo([- (-p v -q => - (p & r))],T).
%    T = t([- (-p v -q => - (p & r))],
%          t([-p v -q, - -(p & r)],
%            t([p & r, -p v -q],
%              t([p, r, -p v -q],
%                t([-p, p, r], cerrado, vacio),
%                t([-q, p, r], abierto, vacio)),
%              vacio),
%            vacio),
%          vacio) 
%    true.
tablero_completo(S,Tab) :-
   completacion(t(S,_Izq,_Dcha),Tab).

% completacion(+Tab1,-Tab2) se verifica si Tab2 es una completación
% (i.e. un tablero completo) del tablero Tab1.  
completacion(t(S1,Izq1,Dcha1),t(S1,Izq3,Dcha3)) :-
   paso(t(S1,Izq1,Dcha1),t(S1,Izq2,Dcha2)), !,
   completacion(Izq2,Izq3),
   completacion(Dcha2,Dcha3).
completacion(Tab,Tab).

% paso(+Tab1,-Tab2) se verifica si Tab2 es un tablero obtenido aplicando
% un paso de completación al tablero Tab1. Los pasos de completación que
% se pueden aplicar a un tablero cuya raiz es S1 son: 
% 1. Si S1 es una lista cerrada (i.e. contiene una fórmula y su negación),
%    entonces Izq=cerrado y Dcha=vacío. 
% 2. Si S1 es una lista de literales (no cerrada), entonces Izq=abierto y
%    Dcha=vacío. 
% 3. Si S1 tiene una doble negación, entonces Izq es el tablero de la
%    lista S1 sustituyendo una fórmula alfa de S1 por su componente y
%    Dcha=vacio. 
% 4. Si S1 tiene una fórmula alfa, entonces Izq es el tablero de la lista
%    S1 sustituyendo una fórmula alfa de S1 por sus componentes y
%    Dcha=vacio. 
% 5. Si S1 tiene una fórmula beta, entonces Izq es el tablero de la lista
%    S1 sustituyendo una fórmula beta de S1 por una de sus componentes y
%    Dcha por la otra.
paso(t(S1,_,_),t(S1, cerrado, vacio)) :-     % 1
   cerrada(S1), !.
paso(t(S1,_,_),t(S1, abierto, vacio)) :-     % 2
   lista_de_literales(S1), !.
paso(t(S1,_,_),t(S1, Izq, vacio)) :-         % 3
   regla_doble_negacion(S1, S2), !,
   Izq = t(S2, _, _).
paso(t(S1,_,_),t(S1, Izq, vacio)) :-         % 4
   regla_alfa(S1, S2), !,
   Izq = t(S2, _, _).
paso(t(S1,_,_),t(S1, Izq, Dcha)) :-          % 5
   regla_beta(S1, S2, S3),
   Izq  = t(S2, _, _),
   Dcha = t(S3, _, _).

% cerrada(+L) se verifica si L es una lista cerrada (i.e. que contiene
% una fórmula y su negación). Por ejemplo, 
%    ?- cerrada([p => q, r, -(p => q)]).
%    true.
%    ?- cerrada([p => q, r, -(p => r)]).
%    false.
cerrada(L) :-
   member(-F, L),
   member(F, L).

% lista_de_literales(+L) se verifica si L es una lista de literales. Por
% ejemplo, 
%    ?- lista_de_literales([p, -q, r]).
%    true.
%    ?- lista_de_literales([p, -q, r v s]).
%    false.
lista_de_literales([]).
lista_de_literales([A|L]) :-
   literal(A),
   lista_de_literales(L).

% regla_doble_negacion(+S1,-S2) se verifica si S1 es una lista de
% fórmulas que contiene al menos una doble negación y S2 es la lista de
% fórmulas obtenidas sustituyendo una doble negación de S1 por su
% componente. Por ejemplo, 
%    ?- regla_doble_negacion([- -(q v r), p => r],L).
%    L = [q v r, p => r] 
%    ?- regla_doble_negacion([p v (q v r), p => r],L).  
%    false.
regla_doble_negacion(S1, [F|S2]) :-
   member(- -F, S1), !,
   delete(S1, - -F, S2).

% regla_alfa(+S1,-S2) se verifica si S1 es una lista de fórmulas que
% contiene una fórmula alfa A y S2 es la lista de fórmulas obtenida
% sustituyendo en S1 la fórmula A por sus componentes. Por ejemplo,
%    ?- regla_alfa([p & (q v r), p => r],L).
%    L = [p, q v r, p => r] 
%    ?- regla_alfa([p v (q v r), p => r],L).  
%    false.
regla_alfa(S1, [A1,A2|S2]) :-
   member(A, S1),
   alfa(A, A1, A2), !,
   delete(S1, A, S2).

% regla_beta(+S1,-S2,-S3) se verifica si S1 es una lista de fórmulas que
% contiene al menos una fórmula beta B y S2 es la lista de fórmulas
% obtenidas sustituyendo en S1 la fórmula B por una de sus componentes y
% S3, por la otra. Por ejemplo,
%    ?- regla_beta([p & (q v r), p => r],L1,L2).
%    L1 = [-p, p & (q v r)]
%    L2 = [r, p & (q v r)] 
%    ?- regla_beta([p & (q v r), -(p => r)],L1,L2).
%    false.
regla_beta(S1, [B1|RS1], [B2|RS1]) :-
   member(B, S1),
   beta(B, B1, B2),
   delete(S1, B, RS1).

% §§ Tablero cerrado
% ==================

% es_cerrado(+Tab) se verifica si Tab es un tablero cerrado (i.e. tiene
% todas sus ramas cerradas).  
es_cerrado(t(_,Izq,Dcha)) :-
   es_cerrado(Izq),
   es_cerrado(Dcha).
es_cerrado(cerrado).
es_cerrado(vacio).

% §§ Prueba por tableros
% ======================

% prueba(+F,-Tab) se verifica si Tab es una prueba por tableros de la
% fórmula F. Por ejemplo,    
%    ?- prueba(-p v -q => -(p & q),T).
%    T = t([- (-p v-q => - (p & q))],
%          t([-p v-q, - -(p & q)],
%            t([p&q, -p v -q],
%              t([p, q, -p v -q],
%                t([-p, p, q], cerrado, vacio),
%                t([-q, p, q], cerrado, vacio)),
%              vacio),
%            vacio),
%          vacio)
%    ?- prueba(-p v -q => -p,T).
%    false.
prueba(F,Tab) :-
   tablero_completo([-F],Tab), !,
   es_cerrado(Tab).

% §§ Teorema por tableros
% =======================

% es_teorema(+F) se verifica si la fórmula F es teorema (mediante
% tableros semánticos). Por ejemplo,   
%    ?- es_teorema(-p v -q => -(p & q)).
%    true.
%    ?- es_teorema(-p v -q => -(p & r)).
%    false.
es_teorema(F) :-
   prueba(F,_Tab).
   
% §§ Deducción por tableros
% =========================

% prueba_deducible_tab(+S,+F,-Tab) se verifica si Tab es una prueba por
% tableros semánticos de que la fórmula F es consecuencia del conjunto
% de fórmulas S. Por ejemplo, 
%    ?- prueba_deducible_tab([p => q, q => r], p => r,T).
%    T = t([- (p => r), p => q, q => r],
%          t([p, -r, p => q, q => r],
%            t([-p, p, -r, q => r], cerrado, vacio),
%            t([q, p, -r, q => r],
%              t([-q, q, p, -r], cerrado, vacio),
%              t([r, q, p, -r], cerrado, vacio))),
%          vacio) 
%    true.
%    ?- prueba_deducible_tab([p => q, q => r], p <=> r,T). 
%    false.
prueba_deducible_tab(S,F,Tab) :-
   tablero_completo([-F|S],Tab), !,
   es_cerrado(Tab).

% es_deducible_tab(+S,+F) se verifica si la fórmula F es consecuencia
% (mediante tableros) del conjunto de fórmulas S. Por ejemplo, 
%    ?- es_deducible_tab([p => q, q => r], p => r).
%    true.
%    ?- es_deducible_tab([p => q, q => r], p <=> r).
%    false.
es_deducible_tab(S,F) :-
   prueba_deducible_tab(S,F,_Tab).

% §§ Prueba con escritura
% =======================

% prueba(+F) se verifica si la fórmula F es teorema y, en su caso,
% escribe una prueba por tableros de F. Por ejemplo, 
%    ?- prueba(-p v -q => -(p & q)).
%    -((-p v -q) => -(p & q))
%       (-p v -q),--(p & q)
%          (p & q),(-p v -q)
%             p,q,(-p v -q)
%                -p,p,q Cerrado
%                -q,p,q Cerrado
%    true.
%    ?- prueba(-p v -q => -p).
%    false.
prueba(F) :- 
   completacion(t([-F],_,_),Tab), !,
   es_cerrado(Tab),
   escribe_tablero(Tab).

% escribe_tablero(+Tab) escribe el tablero Tab. Por ejemplo,
%    ?- escribe_tablero(t([p & (-q v -p)], 
%                         t([p, -q v -p], 
%                           t([-q, p], abierto, vacio), 
%                           t([-p, p], cerrado, vacio)), 
%                         vacio)).
%    (p & (-q v -p))
%       p,(-q v -p)
%          -q,p Abierto  
%          -p,p Cerrado
%    true
escribe_tablero(Tab) :-
   escribe_tablero(Tab, 0).

% escribe_tablero(+Tab, +Nivel) escribe el tablero Tab poniendo la raíz
% en la posición del Nivel. 
escribe_tablero(vacio,_).
escribe_tablero(cerrado,_) :- 
   write(' Cerrado').
escribe_tablero(abierto,_)   :- 
   write(' Abierto  ').
escribe_tablero(t(S1, Izq, Dcha), Nivel) :-
   nl,
   tab(Nivel), Nivel1 is Nivel + 3,
   escribe_lista_formulas(S1),
   escribe_tablero(Izq, Nivel1),
   escribe_tablero(Dcha, Nivel1).

% escribe_lista_formulas(+L) escribe las fórmulas de la lista L.
escribe_lista_formulas([E1,E2|L]) :-
   escribe_formula(E1),
   write(','),
   escribe_lista_formulas([E2|L]).
escribe_lista_formulas([E]) :-
   escribe_formula(E).
escribe_lista_formulas(_, []).

% escribe_formula(+F) escribe la fórmula F, añadiendo paréntesis en las
% fórmulas binarias. Por ejemplo,  
%    ?- escribe_formula(p & q => -(p v -s)).
%    ((p & q) => -(p v -s))
escribe_formula(F) :-
   atom(F), !,
   write(F).
escribe_formula(F) :-
   F =.. [Op, F1], !,
   write(Op),
   escribe_formula(F1).
escribe_formula(F) :-
   F =.. [Op, F1, F2], !,
   escribe_formula_binaria(Op, F1, F2).

% escribe_formula_binaria(+Op, +F1, +F2) escribe la fórmula F1 Op F2 (en
% representación externa), añadiendo paréntesis. Por ejemplo, 
%    ?- escribe_formula_binaria(&,-p, q v r => s).
%    (-p & ((q v r) => s))
escribe_formula_binaria(Op, F1, F2) :-
  write('('), escribe_formula(F1), write(' '),
  write(Op),
  write(' '), escribe_formula(F2), write(')').
