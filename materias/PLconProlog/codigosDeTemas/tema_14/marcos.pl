% marcos.pl
% Marcos.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-junio-2022
% ======================================================================

% Ejemplo
% =======

% Se considerará la siguiente red semántica
%    Personas [ciudad: Sevilla]
%     * Alumnos [estado: soltero]
%       * Juan [edad: 19]
%       * Luis [edad: 24, estado: casado]
%     * Profesores [estado: casado]
%       * Pablo [edad: 44, ciudad: Mairena]
%       * Pedro [edad: 47]

% Representación del marco
% ========================

% Clases;
clase(persona,inicio,[ciudad:sevilla]).
clase(alumno,persona,[estado:soltero]).
clase(profesor,persona,[estado:casado]).

% Instancias:
instancia(juan,alumno,[edad:19]).
instancia(luis,alumno,[edad:24,estado:casado]).
instancia(pablo,profesor,[edad:44,ciudad:mairena]).
instancia(pedro,profesor,[edad:47]).

% Razonamiento con marcos
% =======================

% propiedades_marco(I,P) se verifica si P es la lista de las propiedades de la
% instancia I. Por ejemplo.
%    ?- propiedades_marco(juan,P).
%    P = [ciudad:sevilla,estado:soltero,edad:19] 
%    ?- propiedades_marco(luis,P).
%    P = [ciudad:sevilla,edad:24,estado:casado] 
%    ?- propiedades_marco(pablo,P).
%    P = [estado:casado,edad:44,ciudad:mairena] 
%    ?- propiedades_marco(pedro,P).
%    P = [ciudad:sevilla,estado:casado,edad:47] 
propiedades_marco(Inst,Props) :-
   instancia(Inst,Clase,PropsInst),
   herencia_marco(Clase,PropsInst,Props).

herencia_marco(inicio,Props,Props).
herencia_marco(Clase,P_Actuales,Props) :-
   clase(Clase,Super_clase,P_Generales),
   actualiza(P_Actuales,P_Generales,N_P_Actuales),
   herencia_marco(Super_clase,N_P_Actuales,Props).

actualiza(Props,[],Props).
actualiza(P_Actuales,[Atr:_Valor|P_Generales],Props) :-
   member(Atr:_V,P_Actuales),
   actualiza(P_Actuales,P_Generales,Props).
actualiza(P_Actuales,[Atr:Valor|P_Generales],
                     [Atr:Valor|Props]) :-
   not(member(Atr:_V,P_Actuales)), 
   actualiza(P_Actuales,P_Generales,Props).
