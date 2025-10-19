defmodule Pbt do
  def biggest([head | tail]) do
    biggest(tail, head)
  end

  def biggest([], max), do: max
  def biggest([head | tail], max) when head >= max, do: biggest(tail, head)
  def biggest([head | tail], max) when max > head, do: biggest(tail, max)
end
