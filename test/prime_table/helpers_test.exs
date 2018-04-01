defmodule PrimeTable.HelpersTest do
  use ExUnit.Case

  alias PrimeTable.Helpers

  describe "pmap/2" do
    test "accepts a collection and a function and returns the applied result" do
      collection = [1, 2, 3, 4, 5]
      actual = Helpers.pmap(collection, &example_function/1)
      expected = [1, 4, 9, 16, 25]

      assert actual == expected
    end
  end

  defp example_function(value) do
    value * value
  end
end
