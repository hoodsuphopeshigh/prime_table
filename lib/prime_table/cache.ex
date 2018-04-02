defmodule PrimeTable.Cache do
  @moduledoc """
  Module for handling the cache while calculating the multiplication table
  """

  use GenServer

  @name __MODULE__

  ## Client API

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def write(key, value) do
    GenServer.call(@name, {:write, {key, value}})
  end

  def read(key) do
    GenServer.call(@name, {:read, key})
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:write, {key, value}}, _from, state) do
    new_state = update_state(state, {key, value})
    {:reply, "Written to cache: %{#{key}: #{value}}", new_state}
  end

  def handle_call({:read, key}, _from, state) do
    value = get_value(state, key)
    {:reply, value, state}
  end

  defp update_state(old_state, {key, value}) do
    case Map.has_key?(old_state, key) do
      true ->
        Map.put(old_state, key, value)
      false ->
        Map.put_new(old_state, key, value)
    end
  end

  defp get_value(state, key) do
    case Map.has_key?(state, key) do
      true ->
        value = Map.fetch!(state, key)
        {:ok, value}
      false ->
        {:error, %{}}
    end
  end
end
