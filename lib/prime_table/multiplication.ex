defmodule PrimeTable.Multiplication do
  @moduledoc """
  Handles the creation of the prime multiplication table

  Accepts a list of primes and returns a matrix.
  """

  alias PrimeTable.{Cache, Helpers}

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
    [ row_value | get_values(input, row_value) ]
  end


  defp get_values(input, row_value) do
    input
    |> Stream.map(&construct_keys(&1, row_value))
    |> Helpers.pmap(&check_cache/1)
  end

  defp construct_keys(input_value, row_value) do
    key_a = "#{input_value}::#{row_value}"
    key_b = "#{row_value}::#{input_value}"

    {key_a, key_b, input_value, row_value}
  end

  defp check_cache({key_a, key_b, input_value, row_value}) do
    with {:error, _value} <- Cache.read(key_a),
         {:error, _value} <- Cache.read(key_b)
      do
      outcome = perform_calculations(input_value, row_value)
      update_cache(key_a, key_b, outcome)

      outcome
      else
        {:ok, value} ->
          value
    end
  end

  defp update_cache(key_a, key_b, outcome) do
    Cache.write(key_a, outcome)
    Cache.write(key_b, outcome)
  end

  defp perform_calculations(input_value, row_value) do
    input_value * row_value
  end

  defp compose_result({input, matrix}) do
    [ [ 0 | input ] | Enum.to_list(matrix) ]
  end
end
