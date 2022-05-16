-module(guards).
-export([right_age/1, wrong_age/1]).

right_age(X) when  X >= 16, X =< 104 ->
    true;
right_age(_) ->
    false.

wrong_age(X) when X < 16; X > 104 ->
    true;
wrong_age(_) ->
    false.