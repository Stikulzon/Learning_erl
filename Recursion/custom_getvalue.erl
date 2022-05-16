-module(custom_getvalue).
-export([custom_get_value/2, custom_get_all_values/2]).

% My implementation of proplists:get_value(Key, List) 
% https://www.erldocs.com/19.0/stdlib/proplists.html?i=7&search=proplists:#get_value/2
custom_get_value(_, []) -> "undefined";
custom_get_value(Key, [{Key, X}|_]) -> X;
custom_get_value(Key, [_|Tail]) -> custom_get_value(Key, Tail).

% My implementation of proplists:get_all_values(Key, List) 
% https://www.erldocs.com/19.0/stdlib/proplists.html?i=4&search=proplists:#get_all_values/2
custom_get_all_values(Key, List) -> custom_get_all_values(Key, List, []).
custom_get_all_values(_, [], Acc) -> Acc;
custom_get_all_values(Key, [{Key, X}|Tail], Acc) -> custom_get_all_values(Key, Tail, [X|Acc]);
custom_get_all_values(Key, [_|Tail], Acc) -> custom_get_all_values(Key, Tail, Acc).