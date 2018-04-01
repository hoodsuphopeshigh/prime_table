defmodule PrimeTable.Multiplication do
  @moduledoc """
  Handles the creation of the prime multiplication table

  Accepts a list of primes and returns a matrix.
  """

  alias PrimeTable.Helpers

  @spec create_matrix(input :: list(pos_integer())) :: list(list)
  def create_matrix(input) do
    input
    |> construct_matrix()
    |> compose_result()
  end

  defp construct_matrix(input) do
    matrix = Stream.map(input, &compose_row(&1, input))

    {input, matrix}
  end

  defp compose_row(row_value, input) do
    [ row_value | perform_calculations(input, row_value) ]
  end

  defp perform_calculations(input, row_value) do
    Helpers.pmap(input, fn col_value -> row_value * col_value end)
  end

  defp compose_result({input, matrix}) do
    [ [ 0 | input ] | Enum.to_list(matrix) ]
  end
end
