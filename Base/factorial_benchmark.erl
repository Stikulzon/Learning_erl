-module(factorial_benchmark).
-export([fac_test/2]).

fac_test(N, CallsNum) -> 
    T1 = erlang:system_time(millisecond), 
    fac(N, CallsNum),
    T2 = erlang:system_time(millisecond),
    io:format("~p milliseconds~n",[T2 - T1]).

fac(_, 0) -> ok;
fac(N, CallsNum) -> 
    factorial:fac(N),
    fac(N, CallsNum-1).
 