-module(custom_getvalue).
-export([custom_get_value/2, custom_get_all_values/2, mirror_key_and_values/1]).

custom_get_value(_, []) -> "undefined";
custom_get_value(Y, [{Y, X}|_]) -> X;
custom_get_value(Y, [_|T]) -> custom_get_value(Y, T).

custom_get_all_values(Y, T) -> custom_get_all_values(Y, T, []).
custom_get_all_values(_, [], F) -> F;
custom_get_all_values(Y, [{Y, X}|T], F) -> custom_get_all_values(Y, T, [F|X]);
custom_get_all_values(Y, [{_}|T], F) -> custom_get_all_values(Y, T, F);
custom_get_all_values(_, [_], F) -> F.

mirror_key_and_values(T) -> mirror_key_and_values(T, []).
mirror_key_and_values([], F) -> F;
mirror_key_and_values([{Y, X}|T], F) -> mirror_key_and_values(T, [{X, Y}|F]);
mirror_key_and_values([{_}|T], F) -> mirror_key_and_values(T, F).