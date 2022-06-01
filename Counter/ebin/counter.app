{application, counter, [
	{description, "Count numbers"},
	{vsn, "1.0"},
	{modules, [counter_app, counter_server, counter_supervisor]},
	{registered, [counter_server, counter_supervisor]},
	{applications, [kernel, stdlib]},
	{mod, {counter_app, []}},
	{env, []}
]}.