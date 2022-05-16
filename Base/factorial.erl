-module(factorial).
-export([fac/1]).

fac(N) -> 
    T1 = erlang:system_time(millisecond), 
    fac(N,1, T1).
 
fac(0,Acc, T1) ->
    T2 = erlang:system_time(millisecond),
    io:format("~p milliseconds~n==========================================~n",[T2 - T1]),
    Acc;
fac(N,Acc, T1) when N > 0 ->
    fac(N-1,N*Acc, T1).
