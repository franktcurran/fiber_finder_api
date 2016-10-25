ExUnit.start

Mix.Task.run "ecto.create", ~w(-r FiberFinder.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r FiberFinder.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(FiberFinder.Repo)

