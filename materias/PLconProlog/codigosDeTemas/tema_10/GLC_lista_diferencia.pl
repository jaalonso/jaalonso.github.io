% GLC_lista_diferencia.pl
% Gramáticas libres de contexto mediante lista de diferencia.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 3-junio-2022
% ======================================================================

% oración(O) se verifica si O es una oración de la gramática
%    oración          --> sintagma_nominal, sintagma_verbal
%    sintagma_nominal --> nombre
%    sintagma_nominal --> artículo, nombre
%    sintagma_verbal  --> verbo, sintagma_nominal
%    artículo         --> [el]
%    nombre           --> [gato]
%    nombre           --> [perro]
%    nombre           --> [pescado]
%    nombre           --> [carne]
%    verbo            --> [come]
% Por ejemplo,
%    ?- oración([el,gato,come,pescado]-[]).
%    true 
%    ?- oración([el,come,pescado]-[]).
%    false.
%    ?- oración([el,perro,come,carne]-[]).
%    true 
%    ?- oración([el,perro,come,pienso]-[]).
%    false.
oración(A-B) :-
   sintagma_nominal(A-C),
   sintagma_verbal(C-B).

sintagma_nominal(A-B) :-
   nombre(A-B).
sintagma_nominal(A-B) :-
   artículo(A-C),
   nombre(C-B).

sintagma_verbal(A-B) :-
   verbo(A-C),
   sintagma_nominal(C-B).

artículo([el|A]-A).
nombre([gato|A]-A).
nombre([perro|A]-A).
nombre([pescado|A]-A).
nombre([carne|A]-A).
verbo([come|A]-A).

% Generación de las oraciones
% ===========================

%    ?- oración(O-[]).
%    O = [gato,come,gato] ;
%    O = [gato,come,perro]
%    
%    ?- findall(_O,oración(_O-[]),_L),length(_L,N).
%    N = 64.

% Reconocimiento de las categorías gramaticales
% =============================================

%    ?- sintagma_nominal([el,gato]-[]).
%    true.
%    
%    ?- sintagma_nominal([un,gato]-[]).
%    false.

% Generación de las categorias gramaticales
% =========================================

%    ?- findall(_SN,sintagma_nominal(_SN-[]),L).
%    L = [[gato],[perro],[pescado],[carne],
%         [el,gato],[el,perro],[el,pescado],[el,carne]]. 

% Traza del análisis
% ==================

%    ?- maplist(trace,[oración,sintagma_nominal,sintagma_verbal,artículo,nombre,verbo]).
%    true.
%    
%    ?- oración([el,gato,come,pescado]-[]).
%     T Call: oración([el,gato,come,pescado]-[])
%     T Call: sintagma_nominal([el,gato,come,pescado]-_2308)
%     T Call: nombre([el,gato,come,pescado]-_2308)
%     T Fail: nombre([el,gato,come,pescado]-_2308)
%     T Call: artículo([el,gato,come,pescado]-_3432)
%     T Exit: artículo([el,gato,come,pescado]-[gato,come,pescado])
%     T Call: nombre([gato,come,pescado]-_2308)
%     T Exit: nombre([gato,come,pescado]-[come,pescado])
%     T Exit: sintagma_nominal([el,gato,come,pescado]-[come,pescado])
%     T Call: sintagma_verbal([come,pescado]-[])
%     T Call: verbo([come,pescado]-_6330)
%     T Exit: verbo([come,pescado]-[pescado])
%     T Call: sintagma_nominal([pescado]-[])
%     T Call: nombre([pescado]-[])
%     T Exit: nombre([pescado]-[])
%     T Exit: sintagma_nominal([pescado]-[])
%     T Exit: sintagma_verbal([come,pescado]-[])
%     T Exit: oración([el,gato,come,pescado]-[])
%    true 
%    ?- oración([el,come,pescado]-[]).
%     T Call: oración([el,come,pescado]-[])
%     T Call: sintagma_nominal([el,come,pescado]-_958)
%     T Call: nombre([el,come,pescado]-_958)
%     T Fail: nombre([el,come,pescado]-_958)
%     T Call: artículo([el,come,pescado]-_2082)
%     T Exit: artículo([el,come,pescado]-[come,pescado])
%     T Call: nombre([come,pescado]-_958)
%     T Fail: nombre([come,pescado]-_958)
%     T Fail: sintagma_nominal([el,come,pescado]-_958)
%     T Fail: oración([el,come,pescado]-[])
%    false.

