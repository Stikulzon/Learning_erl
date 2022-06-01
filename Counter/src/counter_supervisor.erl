-module(counter_supervisor).

-export([start_link/0, init/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init(_Args) ->
    SupervisorSpecification = #{
        strategy => one_for_one,
        intensity => 10,
        period => 1000},

    ChildSpecifications =
        [#{id => counter_server,
           start => {counter_server, start_link, []},
           restart => permanent,
           shutdown => 1000,
           type => worker,
           modules => [counter_server]}
        ],
    {ok, {SupervisorSpecification, ChildSpecifications}}.