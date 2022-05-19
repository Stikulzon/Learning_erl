%% Поки безуспішно, розберуся вже завтра
-module(short_link).

-export([init/0, create_short/2, get_long/2, rand_str/1]).

%%% module API

init() ->
    %% init randomizer
    <<A:32, B:32, C:32>> = crypto:strong_rand_bytes(12),
    rand:seed(exsp, {A,B,C}),
    State = {#{}, #{}},
    State.


create_short(LongLink, State) ->
    {L, S} = State,
    case maps:find(LongLink, L) of
        {ok, Short_link} -> {Short_link, State};
        error -> SL = "http://hexlet.io/" ++ rand_str(10),
        {SL, {L#{LongLink => SL}, S#{SL =>LongLink}}}
    end.

get_long(ShortLink, State) ->
    {_, S} = State,
    case maps:find(ShortLink, S) of
        {ok, LongLink} -> {ok, LongLink};
        error -> {error, not_found}
    end.


%% generates random string of chars [a-zA-Z0-9]
rand_str(Length) ->
    lists:map(fun(Char) when Char > 83 -> Char + 13;
                 (Char) when Char > 57 -> Char + 7;
                 (Char) -> Char
              end,
              [rand:uniform(110 - 48) + 47 || _ <- lists:seq(1, Length)]).
