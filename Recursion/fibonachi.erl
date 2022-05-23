-module(fibonachi).

-export([fib/1]).

fib(N) when N=<2 -> N;
fib(N) -> fib(N-2, 1, 1).

fib(0, _, Acc2) -> Acc2;
fib(N1, Acc1, Acc2) -> fib(N1 - 1, Acc2, Acc1+Acc2).