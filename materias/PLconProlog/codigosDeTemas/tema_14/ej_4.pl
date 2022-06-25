:- op(1200,xfx,<-).

alumno(A,P) <- [estudia(A,C), enseña(P,C)].
estudia(ana,ia) <- [].
estudia(ana,pl) <- [].
estudia(eva,ra) <- [].
enseña(jose_a,ia) <- [].
enseña(jose_a,ra) <- [].
enseña(rafael,pl) <- [].

arco([A|As],L) :-
        (A <- Cuerpo),
        append(Cuerpo,As,L).

hoja([]).

camino_hasta_hoja(Hoja,[Hoja]) :-
        hoja(Hoja).
camino_hasta_hoja(Nodo1,[Nodo1|Nodos]) :-
        arco(Nodo1,Nodo2),
        camino_hasta_hoja(Nodo2,Nodos).
