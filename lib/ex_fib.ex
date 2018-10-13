defmodule ExFib do
  @moduledoc """
  Enumerable Fibonacci numbers.
  """

  defstruct f1: 1, f2: 1

  def value(%ExFib{f1: f1}) do
    f1
  end

  def succ(%ExFib{f1: f1, f2: f2}) do
    %ExFib{f1: f2, f2: f1 + f2}
  end

  defimpl Enumerable do
    def count(%ExFib{}), do: {:error, __MODULE__}

    def slice(%ExFib{}), do: {:error, __MODULE__}

    def member?(%ExFib{f1: value}, value), do: {:ok, true}

    def member?(%ExFib{f1: f1, f2: f2}, value) when f1 < value,
      do: member?(%ExFib{f1: f2, f2: f1 + f2}, value)

    def member?(%ExFib{}, _), do: {:ok, false}

    def reduce(%ExFib{}, {:halt, acc}, _), do: {:halted, acc}
    def reduce(%ExFib{} = fib, {:suspend, acc}, fun), do: {:suspended, acc, &reduce(fib, &1, fun)}

    def reduce(%ExFib{f1: f1} = fib, {:cont, acc}, fun),
      do: reduce(ExFib.succ(fib), fun.(f1, acc), fun)
  end
end
