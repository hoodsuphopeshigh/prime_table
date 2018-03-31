defmodule PrimeTable.Table do
  @moduledoc """
  Responsible for creating the formatted table returned to the user
  """

  @separator "|\n"

  @spec build(input :: list(list)) :: String.t()
  def build(input) do
    input
    |> iterate_over_input()
    |> join_elements()
    |> add_separator(:last)
  end

  defp iterate_over_input(input) do
    Enum.map(input, &(iterate_over_elements/1))
  end

  defp iterate_over_elements(input) do
    Enum.map(input, &(format_cell/1))
  end

  defp join_elements(input) do
    Enum.join(input, @separator)
  end

  defp format_cell(value) do
    value
    |> convert_to_string()
    |> add_separator(:front)
  end

  defp convert_to_string(value) when value == 0, do: ""
  defp convert_to_string(value) do
    Integer.to_string(value)
  end

  defp add_separator(value, :front) do
    "| #{value}"
  end
  defp add_separator(value, :last), do: value <> @separator
end
