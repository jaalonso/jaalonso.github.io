% GCD_anbn.pl
% GCD para un lenguaje formal a^nb^n
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 3-junio-2022
% ======================================================================


% La siguiente GCD reconoce el lenguaje a^nb^n. Por ejemplo,
%    ?- s([a,a,b,b],[]).
%    true 
%    
%    ?- s([a,a,b,b,b],[]).
%    false.
%    
%    ?- s(X,[]).
%    X = [] ;
%    X = [a,b] ;
%    X = [a,a,b,b] ;
%    X = [a,a,a,b,b,b] 

s --> [].
s --> i,s,d.
i --> [a].
d --> [b].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Sesión                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- s([a,a,b,b],[]).
% Yes
% ?- s([a,a,b,b,b],[]).
% No
% ?- s(X,[]).
% X = [] ;
% X = [a, b] ;
% X = [a, a, b, b] ;
% X = [a, a, a, b, b, b] 
% Yes
