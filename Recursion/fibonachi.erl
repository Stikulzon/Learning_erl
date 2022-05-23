-module(fibonachi).

-export([fib/1, start_test1/2]).

fib(N) when N=<2 -> N;
fib(N) -> fib(N-2, 1, 1).

fib(0, _, Acc2) -> Acc2;
fib(N1, Acc1, Acc2) -> fib(N1 - 1, Acc2, Acc1+Acc2).


start_test1(N, CallsNum) -> 
    T1 = erlang:system_time(millisecond), 
    test1(N, CallsNum),
    T2 = erlang:system_time(millisecond),
    io:format("~p milliseconds~n",[T2 - T1]).

test1(_, 0) -> ok;
test1(N, CallsNum) -> 
    fib(N),
    test1(N, CallsNum-1).