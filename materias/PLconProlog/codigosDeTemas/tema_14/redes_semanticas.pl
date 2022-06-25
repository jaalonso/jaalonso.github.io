% redes_semanticas.pl
% Redes semánticas.
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

% Representación de la red semántica
% ==================================

% Relaciones entre clases:
es_un(persona,inicio).
es_un(alumno,persona).
es_un(profesor,persona).

% Relaciones entre instancias y clases:
inst(juan,alumno).
inst(luis,alumno).
inst(pablo,profesor).
inst(pedro,profesor).

% Propiedades de clases:
prop(persona,ciudad,sevilla).
prop(alumno,estado,soltero).
prop(profesor,estado,casado).

% Propiedades de instancias:
prop(juan,edad,19).
prop(luis,edad,24).
prop(luis,estado,casado).
prop(pablo,edad,44).
prop(pablo,ciudad,mairena).
prop(pedro,edad,47).

% Razonamiento con la red semántica
% =================================

% propiedades_especificas(X,Ps) se verifica si Ps es la lista de las
% propiedades específicas de X. Por ejemplo,
%    ?- propiedades_especificas(persona,P).
%    P = [ciudad:sevilla].
%    
%    ?- propiedades_especificas(juan,P).
%    P = [edad:19].
%    
%    ?- propiedades_especificas(luis,P).
%    P = [edad:24,estado:casado].
propiedades_especificas(X,Props) :-
   findall(Atr:Valor,prop(X,Atr,Valor),Props).

% propiedades_rs(I,P) se verifica si P es la lista de las propiedades de la
% instancia I. Por ejemplo.
%    ?- propiedades_rs(juan,P).
%    P = [ciudad:sevilla,estado:soltero,edad:19] 
%    
%    ?- propiedades_rs(luis,P).
%    P = [ciudad:sevilla,edad:24,estado:casado] 
%    
%    ?- propiedades_rs(pablo,P).
%    P = [estado:casado,edad:44,ciudad:mairena] 
%    
%    ?- propiedades_rs(pedro,P).
%    P = [ciudad:sevilla,estado:casado,edad:47] 
propiedades_rs(Inst,Props) :-
   propiedades_especificas(Inst,P_Especificas),
   inst(Inst,Clase),
   herencia_rs(Clase,P_Especificas,Props).

herencia_rs(inicio,Props,Props).
herencia_rs(Clase,P_Actuales,Props) :-
   propiedades_especificas(Clase,P_Generales),
   actualiza(P_Actuales,P_Generales,N_P_Actuales),
   es_un(Clase,Super_clase),
   herencia_rs(Super_clase,N_P_Actuales,Props).

actualiza(Props,[],Props).
actualiza(P_Actuales,[Atr:_Valor|P_Generales],Props) :-
   member(Atr:_V,P_Actuales),
   actualiza(P_Actuales,P_Generales,Props).
actualiza(P_Actuales,[Atr:Valor|P_Generales],
                     [Atr:Valor|Props]) :-
   not(member(Atr:_V,P_Actuales)), 
   actualiza(P_Actuales,P_Generales,Props).
