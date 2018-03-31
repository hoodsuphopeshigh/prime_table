defmodule PrimeTable.TableTest do
  use ExUnit.Case

  alias PrimeTable.Table

  describe "build/1" do
    test "returns a formatted table with valid input" do
      valid_input =
        [
          [0, 2, 3, 5],
          [2, 4, 6, 10],
          [3, 6, 9, 15],
          [5, 10, 15, 25]
        ]
      actual = Table.build(valid_input)
      expected =
        """
        | | 2| 3| 5|
        | 2| 4| 6| 10|
        | 3| 6| 9| 15|
        | 5| 10| 15| 25|
        """

      assert actual == expected
    end
  end
end
