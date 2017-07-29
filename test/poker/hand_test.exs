defmodule Poker.HandTest do
  use ExUnit.Case, async: true

  alias Poker.Hand
  alias Poker.Card

  doctest Poker.Hand

  test "evaluates a royal flush" do
    cards = [
      %Card{rank: 14, suit: :clubs},
      %Card{rank: 13, suit: :clubs},
      %Card{rank: 12, suit: :clubs},
      %Card{rank: 11, suit: :clubs},
      %Card{rank: 10, suit: :clubs},
    ]

    assert Hand.score(cards) == :royal_flush
  end

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

  test "evaluates four of a kind" do
    cards = [
      %Card{rank: 14, suit: :hearts},
      %Card{rank: 14, suit: :clubs},
      %Card{rank: 14, suit: :spades},
      %Card{rank: 14, suit: :diamonds},
      %Card{rank: 8, suit: :clubs},
    ]

    assert Hand.score(cards) == :four_of_a_kind
  end

  test "evaluates full house" do
    cards = [
      %Card{rank: 13, suit: :hearts},
      %Card{rank: 13, suit: :clubs},
      %Card{rank: 13, suit: :spades},
      %Card{rank: 10, suit: :hearts},
      %Card{rank: 10, suit: :clubs},
    ]

    assert Hand.score(cards) == :full_house
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
