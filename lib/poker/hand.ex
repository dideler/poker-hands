defmodule Poker.Hand do
  alias Poker.Card

  def score(cards) do
    evaluate(cards)
  end

  defp evaluate(_), do: :high_card
end
