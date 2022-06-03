exp_numerica(Z) --> termino(X), "+", exp_numerica(Y), {Z is X + Y}.
exp_numerica(Z) --> termino(X), "-", exp_numerica(Y), {Z is X - Y}.
exp_numerica(X) --> termino(X).

termino(Z) --> numero(X), "*", termino(Y), {Z is X * Y}.
termino(Z) --> numero(X), "/", termino(Y), {Z is X / Y}.
termino(Z) --> numero(Z).

numero(C) --> "+", numero(C).
numero(C) --> "-", numero(X), {C is -X}.
numero(X) --> [C], {"0"=<C, C=<"9", X is C - "0"}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sesión                                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?-  phrase(exp_numerica(Z), "-2+3*5+1").
% Z = 14
% ?-  phrase(exp_numerica(Z), "-2+3*10/2+1").
% Z = 14
% ?- phrase(exp_numerica(X),"a+2-3").
% No

