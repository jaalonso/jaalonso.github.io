pertenece(X,[X|L]).
pertenece(X,[Y|L]) :- pertenece(X,L).

pertenece_2(X,[Y|L]) :- X=Y ; pertenece_2(X,L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Sesión                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- pertenece(b,[a,b,c]).
% Yes
%
% ?- pertenece(d,[a,b,c]).
% No
%
% ?- pertenece(X,[a,b,a]).
% X = a ;
% X = b ;
% X = a ;
% No
%
% ?- pertenece(a,L).
% L = [a|_G233] ;
% L = [_G232, a|_G236] ;
% L = [_G232, _G235, a|_G239]
% Yes
