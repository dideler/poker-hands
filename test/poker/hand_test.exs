defmodule Poker.HandTest do
  use ExUnit.Case, async: true

  alias Poker.Hand
  alias Poker.Card

  doctest Poker.Hand

  test "evaluates a straight flush" do
    cards = [
      %Card{rank: 5, suit: :clubs},
      %Card{rank: 6, suit: :clubs},
      %Card{rank: 7, suit: :clubs},
      %Card{rank: 8, suit: :clubs},
      %Card{rank: 9, suit: :clubs},
    ]

    assert Hand.score(cards) == :straight_flush
  end

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
