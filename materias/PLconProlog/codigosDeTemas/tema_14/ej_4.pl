:- op(1200,xfx,<-).

alumno(A,P) <- [estudia(A,C), ense�a(P,C)].
estudia(ana,ia) <- [].
estudia(ana,pl) <- [].
estudia(eva,ra) <- [].
ense�a(jose_a,ia) <- [].
ense�a(jose_a,ra) <- [].
ense�a(rafael,pl) <- [].

arco([A|As],L) :-
        (A <- Cuerpo),
        append(Cuerpo,As,L).

hoja([]).

camino_hasta_hoja(Hoja,[Hoja]) :-
        hoja(Hoja).
camino_hasta_hoja(Nodo1,[Nodo1|Nodos]) :-
        arco(Nodo1,Nodo2),
        camino_hasta_hoja(Nodo2,Nodos).
