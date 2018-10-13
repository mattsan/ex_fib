defmodule ExFibTest do
  use ExUnit.Case
  doctest ExFib

  test "greets the world" do
    assert ExFib.hello() == :world
  end
end
