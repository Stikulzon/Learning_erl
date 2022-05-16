-module(mirror).
-export([mirror_key_and_values/1]).

% Mirror keys and values
% Example:
%[{1, "a"}, {2, "b"}, {3, "c"}]
%->
%[{"a", 1}, {"b", 2}, {"c", 3}]
mirror_key_and_values(List) -> mirror_key_and_values(List, []).
mirror_key_and_values([], Acc) -> Acc;
mirror_key_and_values([{Key, X}|Tail], Acc) -> mirror_key_and_values(Tail, [{X, Key}|Acc]);
mirror_key_and_values([{_}|Tail], Acc) -> mirror_key_and_values(Tail, Acc).