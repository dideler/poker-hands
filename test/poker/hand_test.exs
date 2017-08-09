defmodule Poker.HandTest do
  use ExUnit.Case, async: true

  alias Poker.Card
  alias Poker.Hand

  doctest Hand

  test "consists of five cards" do
    assert length(Hand.new.cards) == 5
  end

  test "evaluates a royal flush" do
    cards = [
      %Card{rank: 14, suit: :clubs},
      %Card{rank: 13, suit: :clubs},
      %Card{rank: 12, suit: :clubs},
      %Card{rank: 11, suit: :clubs},
      %Card{rank: 10, suit: :clubs},
    ]

    assert Hand.rank(cards) == :royal_flush
  end

  test "evaluates a straight flush" do
    cards = [
      %Card{rank: 5, suit: :clubs},
      %Card{rank: 6, suit: :clubs},
      %Card{rank: 7, suit: :clubs},
      %Card{rank: 8, suit: :clubs},
      %Card{rank: 9, suit: :clubs},
    ]

    assert Hand.rank(cards) == :straight_flush
  end

  test "evaluates four of a kind" do
    cards = [
      %Card{rank: 14, suit: :hearts},
      %Card{rank: 14, suit: :clubs},
      %Card{rank: 14, suit: :spades},
      %Card{rank: 14, suit: :diamonds},
      %Card{rank: 8, suit: :clubs},
    ]

    assert Hand.rank(cards) == :four_of_a_kind
  end

  test "evaluates full house" do
    cards = [
      %Card{rank: 13, suit: :hearts},
      %Card{rank: 13, suit: :clubs},
      %Card{rank: 13, suit: :spades},
      %Card{rank: 10, suit: :hearts},
      %Card{rank: 10, suit: :clubs},
    ]

    assert Hand.rank(cards) == :full_house
  end

  test "evaluates flush" do
    cards = [
      %Card{rank: 12, suit: :clubs},
      %Card{rank: 8, suit: :clubs},
      %Card{rank: 6, suit: :clubs},
      %Card{rank: 4, suit: :clubs},
      %Card{rank: 3, suit: :clubs},
    ]

    assert Hand.rank(cards) == :flush
  end

  test "evaluates straight" do
    cards = [
      %Card{rank: 2, suit: :diamonds},
      %Card{rank: 3, suit: :clubs},
      %Card{rank: 4, suit: :spades},
      %Card{rank: 5, suit: :diamonds},
      %Card{rank: 6, suit: :clubs},
    ]

    assert Hand.rank(cards) == :straight
  end

  test "evaluates three of a kind" do
    cards = [
      %Card{rank: 11, suit: :clubs},
      %Card{rank: 11, suit: :hearts},
      %Card{rank: 11, suit: :diamonds},
      %Card{rank: 5, suit: :clubs},
      %Card{rank: 8, suit: :diamonds},
    ]

    assert Hand.rank(cards) == :three_of_a_kind
  end

  test "evaluates two pair" do
    cards = [
      %Card{rank: 10, suit: :diamonds},
      %Card{rank: 10, suit: :clubs},
      %Card{rank: 6, suit: :spades},
      %Card{rank: 6, suit: :clubs},
      %Card{rank: 13, suit: :diamonds},
    ]

    assert Hand.rank(cards) == :two_pair
  end

  test "evaluates one pair" do
    cards = [
      %Card{rank: 14, suit: :hearts},
      %Card{rank: 14, suit: :clubs},
      %Card{rank: 8, suit: :spades},
      %Card{rank: 6, suit: :hearts},
      %Card{rank: 2, suit: :diamonds},
    ]

    assert Hand.rank(cards) == :one_pair
  end

  test "evaluates high card" do
    cards = [
      %Card{rank: 2, suit: :spades},
      %Card{rank: 3, suit: :hearts},
      %Card{rank: 5, suit: :diamonds},
      %Card{rank: 7, suit: :spades},
      %Card{rank: 11, suit: :spades},
    ]

    assert Hand.rank(cards) == :high_card
  end
end
