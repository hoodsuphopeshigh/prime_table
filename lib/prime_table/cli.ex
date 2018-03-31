defmodule PrimeTable.CLI do
  @moduledoc """
  Command Line Interface

  Useage:
  Input a valid integer and receive a formatted multiplication table of prime numbers
  """

  alias PrimeTable.{Multiplication, Sieve, Table}

  @spec main(list(binary)) :: :ok
  def main([]), do: IO.puts(help_message())
  def main(["0"]), do: IO.puts(invalid_arg())
  def main([arg]) do
    amount = String.to_integer(arg)

    Sieve.run()
    |> Enum.take(amount)
    |> Multiplication.create_matrix()
    |> Table.build()
    |> IO.puts()
  rescue
    error -> exit(error_message(error, arg))
  end

  defp help_message do
    """
    Useage:
    ./primetable <Integer>

    Will return a formatted multiplication table of prime numbers.
    """
  end

  defp invalid_arg do
    """
    Invalid argument supplied.

    Please ensure input is at least 1.
    """
  end

  defp error_message(error, arg) do
    """
    The following error has occurred: #{inspect(error.message)}

    Supplied argument: #{arg}
    """
  end
end
