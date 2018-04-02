defmodule PrimeTable do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(PrimeTable.Cache, []),
    ]

    opts = [strategy: :one_for_one, name: PrimeTable.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
