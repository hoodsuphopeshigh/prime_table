defmodule PrimeTable.Helpers do
  @moduledoc """
  Module that contains useful helper methods for the application
  """

  @spec pmap(collection :: any() , func :: fun() ) :: any()
  def pmap(collection, func) do
    collection
    |> Stream.map(&(Task.async(fn -> func.(&1) end)))
    |> Enum.map(&Task.await/1)
  end
end
