defmodule Poker.Ranker do
  @moduledoc "Ranks poker hands against each other"

  alias Poker.Hand

  import Minmaxlist

  @hand_rank_scores [
    royal_flush: 10,
    straight_flush: 9,
    four_of_a_kind: 8,
    full_house: 7,
    flush: 6,
    straight: 5,
    three_of_a_kind: 4,
    two_pair: 3,
    one_pair: 2,
    high_card: 1,
  ]

  def highest_hand(hands) do
    score_hand_rank = fn(hand) -> @hand_rank_scores[Hand.rank(hand.cards)] end

    highest_hands = max_list_by(hands, score_hand_rank)
    highest_hand_rank = List.first(highest_hands).type

    highest_hands
    |> break_tie(highest_hand_rank)
  end

  defp break_tie(hands, _) when length(hands) == 1, do: hands
  defp break_tie(hands, :royal_flush), do: hands
  defp break_tie(hands, :straight_flush) do
    max_list_by(hands, fn(hand) -> hand.cards end)
  end
end
