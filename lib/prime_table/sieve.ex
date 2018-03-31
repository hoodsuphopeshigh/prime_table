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

  """
  @spec run(limit :: pos_integer()) :: list(pos_integer())
  def run(limit) when limit < 2,  do: []
  def run(limit) when limit == 2, do: [2]
  def run(limit) do
    limit
    |> construct_list(:odds)
    |> sieve(limit)
  end

  defp construct_list(limit, type) do
    [2 | construct_list_type(limit, type) ]
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
    Enum.reduce(input, list, fn x, acc ->
      if Enum.at(acc, x) do
        multiples = multiples_to_remove(x, limit)
        remove_multiples(acc, multiples)
      else
        acc
      end
    end)
  end

  defp multiples_to_remove(input, limit) do
    Stream.iterate(input * input, &(&1 + input))
    |> Enum.take_while(fn x -> x <= limit end)
  end

  defp remove_multiples(input, multiples) do
    input -- multiples
  end
end
