%%%-------------------------------------------------------------------
%%% @author zefir
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. чер 2022 21:05
%%%-------------------------------------------------------------------
-module(progsql_test_main).
-author("zefir").
-include_lib("/home/zefir/IdeaProjects/Learning_erl/MakefileTest/progsql_test/deps/epgsql/include/epgsql.hrl").
%-include_lib("/home/zefir/IdeaProjects/Learning_erl/MakefileTest/progsql_test/deps/epgsql/src/epgsql.erl").

%% API
-export([start_replication/0, handle_x_log_data/4]).

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