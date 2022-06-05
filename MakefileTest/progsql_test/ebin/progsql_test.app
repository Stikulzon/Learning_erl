{application, 'progsql_test', [
	{description, "New project"},
	{vsn, "0.1.0"},
	{modules, ['progsql_test_app','progsql_test_sup','progsql_test_worker']},
	{registered, [progsql_test_sup]},
	{applications, [kernel,stdlib,epgsql]},
	{mod, {progsql_test_app, []}},
	{env, []}
]}.