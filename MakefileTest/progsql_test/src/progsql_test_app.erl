-module(progsql_test_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
	progsql_test_main:start_replication().

stop(_State) ->
	ok.
