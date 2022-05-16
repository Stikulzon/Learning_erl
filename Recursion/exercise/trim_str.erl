-module(trim_str).

-export([trim/1]).

reverse(L) -> reverse(L,[]).
reverse([],F) -> F;
reverse([X|Y],F) -> reverse(Y, [X|F]).

dropwhile(Pred, List) -> 
    case List of
    []->[];
    [X|Y] -> 
        case Pred(X) of 
            true -> dropwhile(Pred, Y);
            false-> List
    end
end.

trim(Str) -> 
    IsSpace = fun(Chr) -> Chr == 32 end,
    reverse(dropwhile(IsSpace,reverse(dropwhile(IsSpace, Str)))).