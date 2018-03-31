defmodule PrimeTable.Sieve do
  @moduledoc """
  Basic Sieve Algorithm:

  Create a list of consecutive integers from 2 through n: (2, 3, 4, ..., n).

  Initially, let p equal 2, the smallest prime number.

  Enumerate the multiples of p by counting to n from 2p in increments of p,
  and mark them in the list (these will be 2p, 3p, 4p, ...; the p itself should not be marked).

  Find the first number greater than p in the list that is not marked.
  If there was no such number, stop.
  Otherwise, let p now equal this new number (which is the next prime), and repeat from step 3.

  When the algorithm terminates, the numbers remaining not marked in the list are all the primes below n.

  Optimisations:

  The list of values to check for primes contains only odd numbers when p > 2.

  The list of values to use as a sieve is the square root of the limit / 2.

  Uses MapSet to remove the multiples from the input.
  """
  @spec run(limit :: pos_integer()) :: list(pos_integer())
  def run(limit) when limit < 2, do: []
  def run(limit) when limit == 2, do: [2]

  def run(limit) do
    limit
    |> construct_list(:odds)
    |> sieve(limit)
    |> handle_result()
  end

  defp construct_list(limit, type) do
    [2 | construct_list_type(limit, type)]
  end

  defp construct_list_type(limit, :odds) do
    Stream.iterate(3, &(&1 + 2))
    |> Enum.take(round(:math.sqrt(limit) / 2))
  end

  defp construct_list_type(limit, :every) do
    Stream.iterate(3, &(&1 + 2))
    |> Enum.take_while(fn x -> x <= limit end)
  end

  defp sieve(input, limit) do
    list = construct_list(limit, :every)

    Enum.reduce(input, list, fn index, acc ->
      if Enum.at(acc, index) do
        remove_multiples(index, acc, limit)
      else
        acc
      end
    end)
  end

  defp remove_multiples(index, acc, limit) do
    index
    |> construct_multiples(limit)
    |> remove(acc)
  end

  defp construct_multiples(input, limit) do
    Stream.iterate(input * input, &(&1 + input))
    |> Enum.take_while(fn x -> x <= limit end)
  end

  defp remove(multiples, input) do
    MapSet.difference(MapSet.new(input), MapSet.new(multiples))
  end

  defp handle_result(input) when is_map(input), do: Enum.sort(input)
  defp handle_result(input), do: input
end
