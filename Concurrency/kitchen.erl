-module(kitchen).
-compile(export_all).

start(FoodList) ->
    spawn(?MODULE, fridge2, [FoodList]).

store(Pid, Food) ->
    Pid ! {self(), {store, Food}},
    receive
        {Pid, Msg} -> Msg
    end.

take(Pid, Food) ->
    Pid ! {self(), {take, Food}},
    receive
        {Pid, Msg} -> Msg
    end.

store2(Pid, Food) ->
    Pid ! {self(), {store, Food}},
    receive
        {Pid, Msg} -> Msg
    after 3000 ->
        timeout
    end.

take2(Pid, Food) ->
    Pid ! {self(), {take, Food}},
    receive
        {Pid, Msg} -> Msg
    after 3000 ->
        timeout
    end.

fridge1() ->
    receive
        {From, {store, _Food}} ->
            From ! {self(), ok},
            fridge1();
        {From, {take, _Food}} ->
            %% uh....
            From ! {self(), not_found},
            fridge1();
        terminate ->
            ok
    end.

fridge2(FoodStore) ->
    receive
        {From, {store, Food}} ->
            From ! {self(), ok},
            fridge2([Food | FoodStore]);

        {From, {take, Food}} ->
            case lists:member(Food, FoodStore) of
                true -> From ! {self(), Food}, fridge2(lists:delete(Food, FoodStore));
                false -> From ! {self(), not_found}, fridge2(FoodStore)
            end;
        terminate ->
            ok
    end.