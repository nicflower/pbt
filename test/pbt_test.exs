defmodule PbtTest do
  use ExUnit.Case
  use PropCheck

  # properties
  property "always work" do
    forall type <- my_type() do
      boolean(type)
    end
  end

  property "finds biggest element" do
    forall x <- non_empty(list(integer())) do
      biggest(x) == List.last(Enum.sort(x))
    end
  end

  # helpers
  def boolean(_), do: true

  def biggest([head | tail]) do
    biggest(tail, head)
  end

  def biggest([], max), do: max
  def biggest([head | tail], max) when head >= max, do: biggest(tail, head)
  def biggest([head | tail], max) when max > head, do: biggest(tail, max)

  # generators
  def my_type() do
    term()
  end
end
