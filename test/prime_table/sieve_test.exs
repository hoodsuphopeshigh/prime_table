defmodule PrimeTable.SieveTest do
  use ExUnit.Case

  alias PrimeTable.Sieve

  describe "run/1" do
    test "returns an empty list if limit is less than 2" do
      zero = 0
      one = 1
      actual_zero = Sieve.run(zero)
      actual_one = Sieve.run(one)
      expected = []

      assert actual_zero == expected
      assert actual_one == expected
    end

    test "returns an empty list if limit is negative" do
      negative = -2
      actual_neg = Sieve.run(negative)
      expected = []

      assert actual_neg == expected
    end

    test "returns a list if the limit is 2" do
      limit = 2
      actual = Sieve.run(limit)
      expected = [2]

      assert actual == expected
    end

    test "returns a list if limit is greater than 2" do
      limit = 3
      actual = Sieve.run(limit)
      expected = [2, 3]

      assert actual == expected
    end

    test "filters a list for multiples of 2" do
      limit = 8
      actual = Sieve.run(limit)
      expected = [2, 3, 5, 7]

      assert actual == expected
    end

    test "filters a list for multiples of 3" do
      limit = 10
      actual = Sieve.run(limit)
      expected = [2, 3, 5, 7]

      assert actual == expected
    end

    test "filters a list for multiples of 5" do
      limit = 25
      actual = Sieve.run(limit)
      expected = [2, 3, 5, 7, 11, 13, 17, 19, 23]

      assert actual == expected
    end

    test "returns a list of primes below 100" do
      limit = 100
      actual = Sieve.run(limit)
      expected = [
        2, 3, 5, 7, 11, 13, 17, 19,
        23, 29, 31, 37, 41, 43, 47,
        53, 59, 61, 67, 71, 73, 79,
        83, 89, 97
        ]

      assert actual == expected
    end
  end

end
