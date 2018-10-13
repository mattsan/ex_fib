defmodule ExFibTest do
  use ExUnit.Case
  doctest ExFib

  describe "member?" do
    test "55 exists within Fibonacci sequence" do
      assert Enum.member?(%ExFib{}, 55)
    end

    test "354224848179261915075 (= f(100)) exists within Fibonacci sequence" do
      assert Enum.member?(%ExFib{}, 354_224_848_179_261_915_075)
    end

    test "550 doesn't exist within Fibonacci sequence" do
      refute Enum.member?(%ExFib{}, 550)
    end

    test "3542248481792619150750 (= f(100) * 10) doesn't exist within Fibonacci sequence" do
      refute Enum.member?(%ExFib{}, 3_542_248_481_792_619_150_750)
    end
  end

  describe "reduce" do
    setup do
      [expects: [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]]
    end

    test "take", %{expects: expects} do
      fibs =
        %ExFib{}
        |> Enum.take(10)

      assert fibs == expects
    end

    test "zip", %{expects: expects} do
      comparisons =
        %ExFib{}
        |> Enum.zip(expects)
        |> Enum.map(fn {actual, expected} -> actual == expected end)

      assert Enum.all?(comparisons)
    end
  end
end
