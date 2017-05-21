defmodule Poker.HandTest do
  use ExUnit.Case, async: true

  alias Poker.Hand
  alias Poker.Card

  doctest Poker.Hand

  test "evaluates high card" do
    cards = [
      %Card{rank: 2, suit: :spades},
      %Card{rank: 3, suit: :hearts},
      %Card{rank: 5, suit: :diamonds},
      %Card{rank: 7, suit: :spades},
      %Card{rank: 11, suit: :spades},
    ]

    assert Hand.score(cards) == :high_card
  end
end
