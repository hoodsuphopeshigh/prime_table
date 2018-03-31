defmodule PrimeTable.CLITest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias PrimeTable.CLI

  describe "main/1" do
    test "displays the help message when no arguments are supplied" do
      actual = capture_io(fn -> assert :ok == CLI.main([]) end)
      expected =
        """
        Useage:
        ./primetable <Integer>

        Will return a formatted multiplication table of prime numbers.

        """

      assert actual == expected
    end

    test "displays the error message when an invalid argument is supplied" do
      invalid_arg = "Hello"
      actual = CLI.main([invalid_arg]) |> catch_exit
      expected =
        """
        The following error has occurred: "argument error"

        Supplied argument: #{invalid_arg}
        """

      assert actual == expected
    end

    test "returns the value passed in when valid argument is supplied" do
      valid_arg = "2"
      actual = capture_io(fn -> assert :ok == CLI.main([valid_arg]) end)
      expected = "2\n"

      assert actual == expected
    end
  end
end
