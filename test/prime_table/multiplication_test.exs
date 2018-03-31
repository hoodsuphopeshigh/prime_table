defmodule PrimeTable.MultiplicationTest do
  use ExUnit.Case

  alias PrimeTable.Multiplication

  describe "create_matrix/1" do
    test "returns a list of lists when given valid input" do
      valid_input = [2, 3, 5]
      actual = Multiplication.create_matrix(valid_input)
      expected =
        [
          [0, 2, 3, 5],
          [2, 4, 6, 10],
          [3, 6, 9, 15],
          [5, 10, 15, 25]
        ]

      assert actual == expected
    end
  end
end
