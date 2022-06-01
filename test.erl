-module(test).
-export([ex2/1, ex2f/1, start_test_ex2/2, start_test_ex2f/2]).

%fibonachii - func1
ex2(0) -> 0;
ex2(1) -> 1;
ex2(N) when N > 0 ->
    ex2(N-1) + ex2(N-2).

%fibonachii - func2
ex2f(N) when N > 0 -> ex2f(N, 0, 1).
ex2f(0, F1, _F2) -> F1;
ex2f(N, F1, F2) -> ex2f(N-1, F2, F1+F2).


start_test_ex2(N, CallsNum) -> 
  T1 = erlang:system_time(millisecond), 
  test_ex2(N, CallsNum),
  T2 = erlang:system_time(millisecond),
  io:format("~p milliseconds~n",[T2 - T1]).

test_ex2(_, 0) -> ok;
test_ex2(N, CallsNum) -> 
  ex2(N),
  test_ex2(N, CallsNum-1).


start_test_ex2f(N, CallsNum) -> 
  T1 = erlang:system_time(millisecond), 
  test_ex2f(N, CallsNum),
  T2 = erlang:system_time(millisecond),
  io:format("~p milliseconds~n",[T2 - T1]).

test_ex2f(_, 0) -> ok;
test_ex2f(N, CallsNum) -> 
  ex2f(N),
  test_ex2f(N, CallsNum-1).