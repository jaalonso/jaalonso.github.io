% planificacion.pl
% Planificación de tareas mediante CLP(Q).
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 31-mayo-2022
% ======================================================================

:- use_module(library(clpq)).

% tareas(+LTD) se verifica si LTD es la lista de los pares de las tareas
% y sus duraciones con el formato T/D.
tareas([t1/5,t2/7,t3/10,t4/2,t5/9]).

% precede(+T1,+T2) se verifica si la tarea T1 tiene que preceder a la
% T2.
precede(t1,t2).
precede(t1,t4).
precede(t2,t3).
precede(t4,t5).

% planificación(P,TP) se verifica si P es el plan (esto es una lista de
% elementos de la forma tarea/inicio/duración) para realizar las tareas
% en el menor tiempo posible, TP. Por ejemplo,
%    ?- planificación(P,TP).
%    P = [t1/0/5,t2/5/7,t3/12/10,t4/_20034/2,t5/_20052/9],
%    TP = 22,
%    {_20084= -6-_20098-_20092,_20098+_20092>= -6,_20092=<0,_20052=13+_20098,
%     _20098=<0,_20034=11+_20098+_20092,_20186= -9+_20098+_20092} 
%    
%    ?- planificación([_/I1/_, _/I2/_, _/I3/_, _/I4/_, _/I5/_],TP).
%    I1 = 0,
%    I2 = 5,
%    I3 = 12,
%    TP = 22,
%    {_27474= -6-_27488-_27482,_27488+_27482>= -6,_27482=<0,I5=13+_27488,
%     _27488=<0,I4=11+_27488+_27482,_27576= -9+_27488+_27482} 
planificación(P,TP) :-
   tareas(LTD),
   restricciones(LTD,P,TP),
   minimize(TP).

% restricciones(LTD,P,TP) se verifica si P es un plan para realizar las
% tareas de LTD cumpliendo las restricciones definidas por precedencia/2
% y TP es el tiempo que se necesita para ejecutar el plan P. 
restricciones([],[],_TP).
restricciones([T/D | RLTD],[T/I/D | RTID],TP) :-
   {I >= 0, I + D =< TP}, 
   restricciones(RLTD,RTID,TP),
   restricciones_aux(T/I/D,RTID).

% restricciones_aux(TID,LTID) se verifica si el triple
% tarea-inicio-duración TID es consistente con la lista de triples
% tarea-inicio-duración LTID. 
restricciones_aux(_,[]).
restricciones_aux(T/I/D, [T1/I1/D1 | RTID]) :-
   ( precede(T,T1) -> {I+D =< I1}
   ; precede(T1,T) -> {I1+D1 =< I}
   ; true ),
   restricciones_aux(T/I/D,RTID).
