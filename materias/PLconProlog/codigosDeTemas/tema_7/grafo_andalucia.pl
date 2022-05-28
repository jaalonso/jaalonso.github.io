% grafo_andalucia.pl
% Grafo de Andalucía.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 23-mayo-2022
% =============================================================================

% :- use_module(grafos_rep_1,
%               [adyacente/3, % +Grafo, -Nodo, -Nodo
%                nodos/2,     % +Grafo, -Nodos
%                nodo/2,      % +Grafo, -Nodo
%                arcos/2      % +Frafo, -Arcos
%               ]).

conectado(andalucía,huelva,sevilla).
conectado(andalucía,huelva,cádiz).
conectado(andalucía,sevilla,córdoba).
conectado(andalucía,sevilla,málaga).
conectado(andalucía,sevilla,cádiz).
conectado(andalucía,córdoba,jaén).
conectado(andalucía,córdoba,granada).
conectado(andalucía,córdoba,málaga).
conectado(andalucía,cádiz,málaga).
conectado(andalucía,málaga,granada).
conectado(andalucía,jaén,granada).
conectado(andalucía,granada,almería).
