% redes_de_clasificacion.pl
% Redes de clasificación con herencia.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-junio-2022
% ======================================================================

% Se considerará la siguiente red de clasificación
%    Personas [ciudad: Sevilla]
%     * Alumnos [estado: soltero]
%       * Juan [edad: 19]
%       * Luis [edad: 24, estado: casado]
%     * Profesores [estado: casado]
%       * Pablo [edad: 44, ciudad: Mairena]
%       * Pedro [edad: 47]

% Relaciones entre clases:
persona(X) :- alumno(X).
persona(X) :- profesor(X).

% Instancias:
alumno(juan).     alumno(luis).
profesor(pablo).  profesor(pedro).

% Propiedades:
ciudad(pablo,mairena).
ciudad(X,sevilla) :- persona(X).

estado(luis,casado).
estado(X,soltero) :- alumno(X).
estado(X,casado) :- profesor(X).

edad(juan,19).
edad(luis,24).
edad(pablo,44).
edad(pedro,47).

atributos([ciudad,estado,edad]).

% propiedades(I,P) se verifica si P es la lista de las propiedades de la
% instancia I. Por ejemplo.
%    ?- propiedades(juan,P).
%    P = [ciudad:sevilla,estado:soltero,edad:19].
%    
%    ?- propiedades(luis,P).
%    P = [ciudad:sevilla,estado:casado,edad:24].
%    
%    ?- propiedades(pablo,P).
%    P = [ciudad:mairena,estado:casado,edad:44].
%    
%    ?- propiedades(pedro,P).
%    P = [ciudad:sevilla,estado:casado,edad:47].
propiedades(Inst,Props) :-
   atributos(Atrs),
   propiedades(Atrs,Inst,Props).

propiedades([],_Inst,[]).
propiedades([Atr|Atrs],Inst,[Atr:Valor|Props]) :-
   apply(Atr,[Inst,Valor]), !,
   propiedades(Atrs,Inst,Props).

% Ejemplo de conflicto entre propiedades:
%    ?- estado(luis,X).
%    X = casado ;
%    X = soltero ;
%    false.
%    
%    ?- propiedades(luis,_P), member(estado:X,_P).
%    X = casado ;
%    false.
