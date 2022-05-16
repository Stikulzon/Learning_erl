-module(task_2).

-export([len/1, reverse/1]).

-include_lib("eunit/include/eunit.hrl").


%% implement erlang:length/1
%% http://www.erlang.org/doc/man/erlang.html#length-1
len([]) -> 0;
len([_|Y]) -> 1+len(Y).
     


len_test() ->
    ?assertEqual(0, len([])),
    ?assertEqual(1, len([1])),
    ?assertEqual(2, len([1,2])),
    ?assertEqual(5, len([1,2,3,4,5])),
    ?assertEqual(10, len([1,1,1,1,1,2,2,2,2,2])),
    ok.


%% implement lists:reverse/1
%% http://www.erlang.org/doc/man/lists.html#reverse-1
reverse(L) -> reverse(L,[]).
reverse([],F) -> F;
reverse([X|Y],F) -> reverse(Y, [X|F]).



reverse_test() ->
    ?assertEqual([], reverse([])),
    ?assertEqual([1], reverse([1])),
    ?assertEqual([2,1], reverse([1,2])),
    ?assertEqual([5,4,3,2,1], reverse([1,2,3,4,5])),
    ?assertEqual(["ef", "cd", "ab"], reverse(["ab", "cd", "ef"])),
    ok.
