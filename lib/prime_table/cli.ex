defmodule PrimeTable.CLI do
  @moduledoc """
  Command Line Interface

  Useage:
  Input a valid integer and receive a formatted multiplication table of prime numbers
  """

  @spec main(list(binary)) :: :ok
  def main([]), do: IO.puts(help_message())
  def main([arg]) do
    arg
    |> String.to_integer()
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

  defp error_message(error, arg) do
    """
    The following error has occurred: #{inspect(error.message)}

    Supplied argument: #{arg}
    """
  end
end
