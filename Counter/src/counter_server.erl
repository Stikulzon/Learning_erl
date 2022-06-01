-module(counter_server).
-behavior(gen_server).

-export([start_link/0, add_num/1, rem_num/1, stop/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-record(state, {
        count :: integer()
         }).



%%% module API
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

%% Збільшення/зменшення функціями add_num(Num)/rem_num(Num)
add_num(Num) ->
    NewCount = gen_server:call(?MODULE, {add_num, Num}),
    io:format("New count: ~p~n", [NewCount]).

rem_num(Num) ->
    NewCount = gen_server:call(?MODULE, {rem_num, Num}),
    io:format("New count: ~p~n", [NewCount]).

stop() -> gen_server:call(?MODULE, stop).

%%% gen_server API
init([]) ->
    {ok, #state{
            count = 0
           }}.

handle_call({add_num, Num}, _From, State) ->
    NewCount = State#state.count + Num,
    NewState = State#state{count = NewCount},
    {reply, NewState#state.count, NewState};


handle_call({rem_num, Num}, _From, State) ->
    NewCount = State#state.count - Num,
    NewState = State#state{count = NewCount},
    {reply, NewState#state.count, NewState};

handle_call(stop, _From, State) -> {stop, normal, ok, State};

handle_call(_Any, _From, State) ->
    {noreply, State}.


handle_cast(_Any, State) ->
    {noreply, State}.

handle_info(_Request, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVersion, State, _Extra) ->
    {ok, State}.