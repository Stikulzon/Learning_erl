-module(numbs).
-export([nums/0]).
nums() -> nums(10000).

nums(100000) -> ok;
nums(N) -> 
    {N1,N2,N3,N4,N5} = {N rem 10, N rem 100 div 10, N rem 1000 div 100, N rem 10000 div 1000, N div 10000},
    if N1>=0 andalso N2>=0 andalso N3>=0 andalso N4>=0 andalso N5>=0 andalso N1=<5 andalso N2=<5 andalso N3=<5 andalso N4=<5 andalso N5=<5 andalso N1/=N2 andalso N1/=N3 andalso N1/=N4 andalso N1/=N5 andalso N2/=N3 andalso N2/=N4 andalso N2/=N5 andalso N3/=N4 andalso N3/=N5 andalso N4/=N5 -> io:format("~p~n", [N]);  true -> ok end,
    nums(N+1).
