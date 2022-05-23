-module(factorial).
-export([fac/1, start_test1/2, fac2/1, start_test2/2]).

fac(0) -> 1;
fac(N) when N > 0  -> N*fac(N-1).

start_test1(N, CallsNum) -> 
    T1 = erlang:system_time(millisecond), 
    test1(N, CallsNum),
    T2 = erlang:system_time(millisecond),
    io:format("~p milliseconds~n",[T2 - T1]).

test1(_, 0) -> ok;
test1(N, CallsNum) -> 
    fac(N),
    test1(N, CallsNum-1).

fac2(N) -> 
    fac2(N,1).
 
fac2(0,Acc) ->
    Acc;
fac2(N,Acc) when N > 0 ->
    fac2(N-1,N*Acc).

start_test2(N, CallsNum) -> 
    T1 = erlang:system_time(millisecond), 
    test2(N, CallsNum),
    T2 = erlang:system_time(millisecond),
    io:format("~p milliseconds~n",[T2 - T1]).

test2(_, 0) -> ok;
test2(N, CallsNum) -> 
    fac2(N),
    test2(N, CallsNum-1).
 