% familia.pl
% Base de datos familiar.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 15-mayo-2022
% ======================================================================

% ----------------------------------------------------------------------
% Ejercicio 1. Representar la información relativa a las siguientes
% familias:
% + En la primera familia,
%   + el padre es Tomás García Pérez, nacido el 7 de Mayo de 1970,
%     trabaja de profesor y gana 75 euros diarios
%   + la madre es Ana López Ruiz, nacida el 10 de marzo de 1972,
%     trabaja de médica y gana 100 euros diarios
%   + el hijo es Juan García López, nacido el 5 de Enero de 1990,
%     estudiante
%   + la hija es María García López, nacida el 12 de Abril de 1992,
%     estudiante
% + En la segunda familia,
%   + el padre es José Pérez Ruiz, nacido el 6 de Marzo de 1973,
%     trabaja de pintor y gana 150 euros/día
%   + la madre es Luisa Gálvez Pérez, nacida el 12 de Mayo de 1974, es
%     médica y gana 100 euros/día
%   + un hijo es Juan Luis Pérez Pérez, nacido el 5 de Febrero de 2000,
%     estudiante
%   + una hija es María José Pérez Pérez, nacida el 12 de Junio de
%     2002, estudiante
%   + otro hijo es José María Pérez Pérez, nacido el 12 de Julio de
%     2004, estudiante
% ----------------------------------------------------------------------

familia(persona([tomas,garcia,perez],
                fecha(7,mayo,1990),
                trabajo(profesor,75)),
        persona([ana,lopez,ruiz],
                fecha(10,marzo,1972),
                trabajo(medica,100)),
        [ persona([juan,garcia,lopez],
                  fecha(5,enero,1990),
                  estudiante),
          persona([maria,garcia,lopez],
                  fecha(12,abril,1992),
                  estudiante) ]).
familia(persona([jose,perez,ruiz],
                fecha(6,marzo,1973),
                trabajo(pintor,150)),
        persona([luisa,galvez,perez],
                fecha(12,mayo,1974),
                trabajo(medica,100)),
        [ persona([juan_luis,perez,perez],
                  fecha(5,febrero,2000),
                  estudiante),
          persona([maria_jose,perez,perez],
                  fecha(12,junio,2002),
                  estudiante),
          persona([jose_maria,perez,perez],
                  fecha(12,julio,2004),
                  estudiante) ]).

% ----------------------------------------------------------------------
% Ejercicio 2. Realizar las siguientes preguntas:
% + si existe familia sin hijos,
% + si existe familia con un hijo,
% + si existe familia con dos hijos,
% + si existe familia con tres hijos,
% + si existe familia con cuatro hijos.
% ----------------------------------------------------------------------

% ?- familia(_,_,[]).
% false.
%
% ?- familia(_,_,[_]).
% false.
%
% ?- familia(_,_,[_,_]).
% true.
%
% ?- familia(_,_,[_,_,_]).
% true.
%
% ?- familia(_,_,[_,_,_,_]).
% false.

% ----------------------------------------------------------------------
% Ejercicio 3. Buscar los nombres de los padres de familia con tres
% hijos.
% ----------------------------------------------------------------------

% ?- familia(persona(NP,_,_),_,[_,_,_]).
% NP = [jose, perez, ruiz].

% ----------------------------------------------------------------------
% Ejercicio 4. Definir la propiedad
%    casado(X)
% que se verifique si X es un hombre casado.
% ----------------------------------------------------------------------

casado(X) :-
   familia(X,_,_).

% ----------------------------------------------------------------------
% Ejercicio 5. Preguntar por los hombres casados.
% ----------------------------------------------------------------------

% ?- casado(X).
% X = persona([tomas, garcia, perez], fecha(7, mayo, 1990), trabajo(profesor, 75)) ;
% X = persona([jose, perez, ruiz], fecha(6, marzo, 1973), trabajo(pintor, 150)).

% ----------------------------------------------------------------------
% Ejercicio 6. Definir la propiedad
%    casada(X)
% que se verifique si X es una mujer casada.
% ----------------------------------------------------------------------

casada(X) :-
   familia(_,X,_).

% ----------------------------------------------------------------------
% Ejercicio 7. Preguntar por las mujeres casadas.
% ----------------------------------------------------------------------

% ?- casada(X).
% X = persona([ana, lopez, ruiz], fecha(10, marzo, 1972), trabajo(medica, 100)) ;
% X = persona([luisa, galvez, perez], fecha(12, mayo, 1974), trabajo(medica, 100)).

% ----------------------------------------------------------------------
% Ejercicio 8. Determinar el nombre de todas las mujeres casadas que
% trabajan.
% ----------------------------------------------------------------------

% ?- casada(persona([N,_,_],_,trabajo(_,_))).
% N = ana ;
% N = luisa.

% ----------------------------------------------------------------------
% Ejercicio 9. Definir el predicado
%    hijo(X)
% que se verifique si X figura en alguna lista de hijos.
% ----------------------------------------------------------------------

hijo(X) :-
   familia(_,_,L),
   pertenece(X,L).

pertenece(X,[X|_]).
pertenece(X,[_|L]) :-
   pertenece(X,L).

% ----------------------------------------------------------------------
% Ejercicio 10. Preguntar por los hijos.
% ----------------------------------------------------------------------

% ?- hijo(X).
% X = persona([juan, garcia, lopez], fecha(5, enero, 1990), estudiante) ;
% X = persona([maria, garcia, lopez], fecha(12, abril, 1992), estudiante) ;
% X = persona([juan_luis, perez, perez], fecha(5, febrero, 2000), estudiante) ;
% X = persona([maria_jose, perez, perez], fecha(12, junio, 2002), estudiante) ;
% X = persona([jose_maria, perez, perez], fecha(12, julio, 2004), estudiante) ;
% false.

% ----------------------------------------------------------------------
% Ejercicio 11. Definir el predicado
%    existe(X)
% que se verifique si X es una persona existente en la base de datos.
% ----------------------------------------------------------------------

existe(X) :-
   casado(X).
existe(X) :-
   casada(X).
existe(X) :-
   hijo(X).

% ----------------------------------------------------------------------
% Ejercicio 12. Preguntar por los nombres y apellidos de todas las
% personas existentes en la base de datos.
% ----------------------------------------------------------------------

% ?- existe(persona(X,_,_)).
% X = [tomas, garcia, perez] ;
% X = [jose, perez, ruiz] ;
% X = [ana, lopez, ruiz] ;
% X = [luisa, galvez, perez] ;
% X = [juan, garcia, lopez] ;
% X = [maria, garcia, lopez] ;
% X = [juan_luis, perez, perez] ;
% X = [maria_jose, perez, perez] ;
% X = [jose_maria, perez, perez] ;
% false.

% ----------------------------------------------------------------------
% Ejercicio 13. Determinar todos los estudiantes nacidos antes de 2003.
% ----------------------------------------------------------------------

% ?- existe(persona(X,fecha(_,_,Año),estudiante)), Año < 2003.
% X = [juan, garcia, lopez],
% Año = 1990 ;
% X = [maria, garcia, lopez],
% Año = 1992 ;
% X = [juan_luis, perez, perez],
% Año = 2000 ;
% X = [maria_jose, perez, perez],
% Año = 2002 ;
% false.

% ----------------------------------------------------------------------
% Ejercicio 14. Definir el predicado
%    fecha_de_nacimiento(X,Y)
% de forma que si X es una persona, entonces Y es su fecha de nacimiento.
% ----------------------------------------------------------------------

fecha_de_nacimiento(persona(_,Y,_),Y).

% ----------------------------------------------------------------------
% Ejercicio 15. Buscar todos los hijos nacidos en 2002.
% ----------------------------------------------------------------------

% ?- hijo(X), fecha_de_nacimiento(X,fecha(_,_,2002)).
% X = persona([maria_jose, perez, perez], fecha(12, junio, 2002), estudiante) ;
% false.

% ----------------------------------------------------------------------
% Ejercicio 16. Definir el predicado
%    sueldo(X,Y)
% que se verifique si el sueldo de la persona X es Y.
% ----------------------------------------------------------------------

sueldo(persona(_,_,trabajo(_,Y)),Y).
sueldo(persona(_,_,estudiante),0).

% ----------------------------------------------------------------------
% Ejercicio 17. Buscar todas las personas nacidas antes de 1974 cuyo
% sueldo sea superior a 100.
% ----------------------------------------------------------------------

% ?- existe(X),
%    fecha_de_nacimiento(X,fecha(_,_,Año)),
%    Año < 1974,
%    sueldo(X,Y), Y > 100.
% X = persona([jose, perez, ruiz], fecha(6, marzo, 1973), trabajo(pintor, 150)),
% Año = 1973,
% Y = 150 ;
% false.

% ----------------------------------------------------------------------
% Ejercicio 18. Definir la relacion
%    total(L,Y)
% de forma que si L es una lista de personas, entonces Y es la suma
% de los sueldos de las personas de la lista L.
% ----------------------------------------------------------------------

total([],0).
total([X|L],Y) :-
   sueldo(X,Y1),
   total(L,Y2),
   Y is Y1 + Y2.

% ----------------------------------------------------------------------
% Ejercicio 19. Calcular los ingresos totales de cada familia.
% ----------------------------------------------------------------------

% ?- familia(X,Y,Z), total([X,Y|Z],Total).
% X = persona([tomas, garcia, perez],
%             fecha(7, mayo, 1990),
%             trabajo(profesor, 75)),
% Y = persona([ana, lopez, ruiz],
%             fecha(10, marzo, 1972),
%             trabajo(medica, 100)),
% Z = [persona([juan, garcia, lopez],
%              fecha(5, enero, 1990),
%              estudiante),
%      persona([maria, garcia, lopez],
%              fecha(12, abril, 1992),
%              estudiante)],
% Total = 175 ;
% X = persona([jose, perez, ruiz],
%             fecha(6, marzo, 1973),
%             trabajo(pintor, 150)),
% Y = persona([luisa, galvez, perez],
%             fecha(12, mayo, 1974),
%             trabajo(medica, 100)),
% Z = [persona([juan_luis, perez, perez],
%              fecha(5, febrero, 2000),
%              estudiante),
%      persona([maria_jose, perez, perez],
%              fecha(12, junio, 2002),
%              estudiante),
%      persona([jose_maria, perez, perez],
%              fecha(12, julio, 2004),
%              estudiante)],
% Total = 250 ;
% false.
