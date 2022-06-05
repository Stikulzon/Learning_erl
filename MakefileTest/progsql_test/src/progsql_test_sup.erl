-module(progsql_test_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
	SupervisorSpecification = #{
		strategy => one_for_one,
		intensity => 10,
		period => 1000},

	ChildSpecifications =
		[#{id => counter_server,
			start => {progsql_test_worker, start_link, []},
			restart => permanent,
			shutdown => 1000,
			type => worker,
			modules => [progsql_test_worker]}
		],
	{ok, {SupervisorSpecification, ChildSpecifications}}.
