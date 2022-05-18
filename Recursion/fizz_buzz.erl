-module(fizz_buzz).
-export([fizzbuzz/0]).

fizzbuzz() -> fizzbuzz(0).

fizzbuzz(N) -> 
    if N rem 15 == 0 ->
           io:format("fizzbuzz~n");
       N rem 3 == 0 ->
           io:format("izz~n");
       N rem 5 == 0 ->
           io:format("buzz~n");
       true ->
           io:format("~p~n", [N])
    end,
    if N >= 100 -> true;
        true -> fizzbuzz(N+1)
    end.