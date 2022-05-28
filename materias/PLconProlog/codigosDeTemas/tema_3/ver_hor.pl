% ver_hor.pl
% Utilización de objetos estructurados.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 15-mayo-2022
% ======================================================================

% ----------------------------------------------------------------------
% Supongamos que representamos los puntos del plano mediante términos
% de la forma
%    punto(X,Y)
% donde X e Y son números, y los segmentos del plano mediante términos
% de la forma
%    seg(P1,P2)
% donde P1 y P2 son los puntos extremos del segmento.
%
% Definir los predicados
%    vertical(S)
%    horizontal(S)
% tales que
% + vertical(S) se verifica si el segmento S es vertical.
% + horizontal(S) se verifica si el segmento S es horizontal.
% Por ejemplo,
%      vertical(seg(punto(1,2),punto(1,3)))  =>  Sí
%      vertical(seg(punto(1,2),punto(4,2)))  =>  No
%      vertical(seg(punto(1,2),punto(1,3)))  =>  No
%      vertical(seg(punto(1,2),punto(4,2)))  =>  Sí
%
% Usar el programa para responder a las siguientes cuestiones:
% (1) ¿Es vertical el segmento que une los puntos (1,1) y (1,2)?.
% (2) ¿Es vertical el segmento que une los puntos (1,1) y (2,2)?.
% (3) ¿Hay algún Y tal que el segmento que une los puntos (1,1) y (2,Y)
%     sea vertical?.
% (4) ¿Hay algún X tal que el segmento que une los puntos (1,2) y (X,3)
%     sea vertical?.
% (5) ¿Hay algún Y tal que el segmento que une los puntos (1,1) y (2,Y)
%     sea horizontal?.
% (6) ¿Para qué puntos el segmento que comienza en (2,3) es vertical?.
% (7) ¿Hay algún segmento que sea horizontal y vertical?.
%
% Ampliar el programa con el predicado
%   no_degenerado(S)
% que se verifique si S es un segmento no degenerado (es decir, que no se
% reduce a un punto). Por ejemplo,
%   no_degenerado(seg(punto(1,2),punto(1,2))  => No
%
% Con el programa ampliado, responder a la siguiente cuestión:
% (8) ¿todos los segmentos que son horizontales y verticales son
%     degenerados?.
% ----------------------------------------------------------------------

% Definición de vertical y horizontal
% ===================================

horizontal(seg(punto(_,Y),punto(_,Y))).
vertical(seg(punto(X,_),punto(X,_))).

% Consultas (1 a 7)
% =================

% ?- vertical(seg(punto(1,1),punto(1,2))).
% true.
%
% ?- vertical(seg(punto(1,1),punto(2,2))).
% false.
%
% ?- vertical(seg(punto(1,1),punto(2,Y))).
% false.
%
% ?- vertical(seg(punto(1,2),punto(X,3))).
% X = 1.
%
% ?- horizontal(seg(punto(1,1),punto(2,Y))).
% Y = 1.
%
% ?- vertical(seg(punto(2,3),P)).
% P = punto(2, _2328).
%
% ?- vertical(S), horizontal(S).
% S = seg(punto(_3356, _3358), punto(_3356, _3358)).
%
% ?- vertical(_), horizontal(_).
% true.

% Definición de no_degenerado
% ===========================

no_degenerado(seg(P1,P2)) :- P1 \== P2.

% Consulta (8)
% ============

% ?- vertical(S), horizontal(S), no_degenerado(S).
% false.
