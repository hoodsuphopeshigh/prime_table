defmodule PrimeTable.Multiplication do
  @moduledoc """
  Handles the creation of the prime multiplication table
  """

  @spec create_matrix(input :: list(pos_integer())) :: list(list)
  def create_matrix(input) do
    input
    |> construct_matrix()
    |> compose_result()
  end

  defp construct_matrix(input) do
    matrix =
      input
      |> Stream.map(fn row_value ->
        [ row_value | perform_calculations(input, row_value) ]
      end)

    {input, matrix}
  end

  defp perform_calculations(input, row_value) do
    input
    |> Enum.map(fn col_value -> row_value * col_value end)
  end

  defp compose_result({input, matrix}) do
    [ [ 0 | input ] | Enum.to_list(matrix) ]
  end
end
