defmodule PrimeTable.CacheTest do
  use ExUnit.Case

  alias PrimeTable.Cache

  describe "write/2" do
    test "adds a new value to the cache" do
      new_key = "test_key"
      new_value = "test_value"
      actual = Cache.write(new_key, new_value)
      expected = "Written to cache: %{test_key: test_value}"

      assert actual == expected
    end

    test "updates an existing value in the cache" do
      new_key = "test_key"
      updated_value = "updated_value"
      actual = Cache.write(new_key, updated_value)
      expected = "Written to cache: %{test_key: updated_value}"

      assert actual == expected
    end
  end

  describe "read/1" do
    test "returns a tuple with the value on a cache hit" do
      test_key = "test_key"
      test_value = "test_value"

      Cache.write(test_key, test_value)

      actual = Cache.read(test_key)
      expected = {:ok, "test_value"}

      assert actual == expected
    end

    test "returns a tuple with an error on a cache miss" do
      missing_key = "missing_key"
      actual = Cache.read(missing_key)
      expected = {:error, %{}}

      assert actual == expected
    end
  end
end
