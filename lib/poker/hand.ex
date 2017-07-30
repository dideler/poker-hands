defmodule Poker.Hand do
  @moduledoc "Identifies rank for a traditional high poker hand"

  alias Poker.Card

  def score(cards) do
    cards = Enum.sort_by(cards, &(&1.rank))
    cond do
      royal_flush?(cards) -> :royal_flush
      straight_flush?(cards) -> :straight_flush
      four_of_a_kind?(cards) -> :four_of_a_kind
      full_house?(cards) -> :full_house
      flush?(cards) -> :flush
      straight?(cards) -> :straight
      three_of_a_kind?(cards) -> :three_of_a_kind
      two_pair?(cards) -> :two_pair
      true -> :high_card
    end
  end

  # An unbeatable hand. The best possible straight flush.
  defp royal_flush?([
    %{rank: 10, suit: s},
    %{rank: 11, suit: s},
    %{rank: 12, suit: s},
    %{rank: 13, suit: s},
    %{rank: 14, suit: s},
    ]), do: true
  defp royal_flush?(_), do: false

  # Five cards in numerical order, all of identical suits.
  defp straight_flush?([
    %{rank: a, suit: s},
    %{rank: b, suit: s},
    %{rank: c, suit: s},
    %{rank: d, suit: s},
    %{rank: e, suit: s},
    ]) when b == a + 1
        and c == a + 2
        and d == a + 3
        and e == a + 4, do: true
  defp straight_flush?(_), do: false

  # Four cards of the same rank, and one side card or ‘kicker’.
  defp four_of_a_kind?([
    %{rank: a},
    %{rank: a},
    %{rank: a},
    %{rank: a},
    %{rank: _},
    ]), do: true
  defp four_of_a_kind?([
    %{rank: _},
    %{rank: a},
    %{rank: a},
    %{rank: a},
    %{rank: a},
    ]), do: true
  defp four_of_a_kind?(_), do: false

  # Three cards of the same rank, and two cards of a different, matching rank.
  defp full_house?([
    %{rank: a},
    %{rank: a},
    %{rank: a},
    %{rank: b},
    %{rank: b},
    ]), do: true
  defp full_house?([
    %{rank: a},
    %{rank: a},
    %{rank: b},
    %{rank: b},
    %{rank: b},
    ]), do: true
  defp full_house?(_), do: false

  # Five cards of the same suit.
  defp flush?([
    %{suit: a},
    %{suit: a},
    %{suit: a},
    %{suit: a},
    %{suit: a},
    ]), do: true
  defp flush?(_), do: false

  # Five cards in numerical order.
  defp straight?([
    %{rank: a},
    %{rank: b},
    %{rank: c},
    %{rank: d},
    %{rank: e},
    ]) when b == a + 1
        and c == a + 2
        and d == a + 3
        and e == a + 4, do: true
  defp straight?(_), do: false

  # Three cards of the same rank, and two unrelated side cards.
  defp three_of_a_kind?([
    %{rank: a},
    %{rank: a},
    %{rank: a},
    %{rank: _b},
    %{rank: _c},
    ]), do: true
  defp three_of_a_kind?([
    %{rank: _a},
    %{rank: b},
    %{rank: b},
    %{rank: b},
    %{rank: _c},
    ]), do: true
  defp three_of_a_kind?([
    %{rank: _a},
    %{rank: _b},
    %{rank: c},
    %{rank: c},
    %{rank: c},
    ]), do: true
  defp three_of_a_kind?(_), do: false

  # Two cards of a matching rank, two cards of a different matching rank, and one side card.
  defp two_pair?([
    %{rank: a},
    %{rank: a},
    %{rank: b},
    %{rank: b},
    %{rank: _},
    ]), do: true
  defp two_pair?([
    %{rank: a},
    %{rank: a},
    %{rank: _},
    %{rank: b},
    %{rank: b},
    ]), do: true
  defp two_pair?([
    %{rank: _},
    %{rank: a},
    %{rank: a},
    %{rank: b},
    %{rank: b},
    ]), do: true
  defp two_pair?(_), do: false
end
