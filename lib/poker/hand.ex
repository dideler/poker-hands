defmodule Poker.Hand do
  alias Poker.Card

  def score(cards) do
    cond do
      straight_flush?(cards) -> :straight_flush
      true -> :high_card
    end
  end

  defp straight_flush?(_), do: true
end
