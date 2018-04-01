defmodule PrimeTable.Table do
  @moduledoc """
  Responsible for creating the formatted table returned to the user

  Each element is padded with the length of the largest number to ensure
  even spacing.
  """

  alias PrimeTable.Helpers

  @separator "|\n"

  @spec build(input :: list(list)) :: String.t()
  def build(input) do
    input
    |> iterate_over_input()
    |> join_elements()
    |> add_separator(:last)
  end

  defp iterate_over_input(input) do
    padding = calculate_padding(input)
    Helpers.pmap(input, &(iterate_over_elements(&1, padding)))
  end

  defp iterate_over_elements(input, padding) do
    Helpers.pmap(input, &(format_cell(&1, padding)))
  end

  defp format_cell(value, padding) do
    value
    |> convert_to_string()
    |> String.pad_leading(padding)
    |> add_separator(:front)
  end

  defp convert_to_string(value) when value == 0, do: ""
  defp convert_to_string(value) do
    Integer.to_string(value)
  end

  defp join_elements(input) do
    Enum.join(input, @separator)
  end

  defp add_separator(value, :front) do
    "|#{value}"
  end
  defp add_separator(value, :last), do: value <> @separator

  defp calculate_padding(input) do
    input
    |> List.last()
    |> List.last()
    |> to_string()
    |> String.length()
  end
end
