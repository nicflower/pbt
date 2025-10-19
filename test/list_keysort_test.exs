
defmodule ListKeysortTest do
  use ExUnit.Case
  use PropCheck

  property "a sorted list has ordered pairs" do
    forall list <- list({term(), term()}) do
      sorted_list = List.keysort(list, 0)
      assert check_sorted_pairs(sorted_list, fn ({el1, _}, {el2, _}) -> el1 <= el2 end)
    end
  end


  ## helpers
  defp check_sorted_pairs([first | [second | tail]], comp) do
    comp.(first, second) and check_sorted_pairs([second | tail], comp)
  end
  defp check_sorted_pairs([], _), do: true
  defp check_sorted_pairs([_el], _), do: true
end
