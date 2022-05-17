%% Реализовать функцию, которая принимает список, и возвращает максимальный элемент этого списка
-module(list_max).

-export([list_max_value/1]).

list_max_value([H|T]) -> list_max_value(T, H).

list_max_value([], BiggestValue) -> BiggestValue;
list_max_value([H|T], BiggestValue) -> 
    case BiggestValue < H of
      true -> list_max_value(T, H);
      false -> list_max_value(T, BiggestValue)
    end.