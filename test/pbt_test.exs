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
      Pbt.biggest(x) == model_biggest(x)
    end
  end

  property "picks the last number" do
    forall {list, known_last} <- {list(number()), number()} do
      known_list = list ++ [known_last]
      known_last == List.last(known_list)  
    end
  end

  property "a sorted list has ordered pairs" do
    forall list <- list (term()) do
      is_ordered(Enum.sort(list))
    end
  end

  property "a sorted list keeps its size" do
    forall l <- list(number()) do
      length(l) == length(Enum.sort(l))
    end
  end

  property "no element added" do
    forall l <- list(number()) do
      sorted = Enum.sort(l)
      Enum.all?(sorted, fn el -> el in l end)
    end
  end

  property "no element deleted" do
    forall l <- non_empty(list(number())) do
      sorted = Enum.sort(l)
      Enum.all?(l, fn el -> el in sorted end)
    end
  end


  # helpers
  def boolean(_), do: true

  def model_biggest(list), do: list |> Enum.sort() |> List.last()

  def is_ordered([a, b| t]), do: a <= b and is_ordered([b | t])
  def is_ordered(_), do: true

  # generators
  def my_type() do
    term()
  end
end
