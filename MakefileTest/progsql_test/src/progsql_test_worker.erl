-module(progsql_test_worker).
-behavior(gen_server).

-export([start_link/0, add_num/1, rem_num/1, stop/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_replication/0, handle_x_log_data/4]).

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

start_replication() ->
    {ok, ReplConn} = epgsql:connect(localhost, epgl_test, epgl_test, [{database, erland_db}, {port, 32}, {replication, "database"}]),

    {ok, _, [{_, _, SnapshotName}|_]} = epgsql:squery(ReplConn,
        "CREATE_REPLICATION_SLOT epgl_repl_slot TEMPORARY LOGICAL pgoutput"),

    {ok, NormalConn} = epgsql:connect(localhost, epgl_test, epgl_test, [{database, erland_db}, {port, 32}]),
    {ok, _, _} = epgsql:squery(NormalConn, "BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ"),
    {ok, _, _} = epgsql:squery(NormalConn, ["SET TRANSACTION SNAPSHOT '", SnapshotName, "'"]),
    %% select/load data epgsql:equery(NormalConn,...
    epgsql:close(NormalConn),

    ReplSlot = "epgl_repl_slot",
    Callback = ?MODULE,
    CbInitState = #{},
    WALPosition = "0/0",
    PluginOpts = "proto_version '1', publication_names '\"epgl_test\"'",
    ok = epgsql:start_replication(ReplConn, ReplSlot, Callback, CbInitState, WALPosition, PluginOpts).

handle_x_log_data(StartLSN, EndLSN, Data, CbState) ->
    io:format("~p~n", [{StartLSN, EndLSN, Data}]),
    {ok, EndLSN, EndLSN, CbState}.

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