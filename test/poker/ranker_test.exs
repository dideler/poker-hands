defmodule Poker.RankerTest do
  use ExUnit.Case, async: true

  alias Poker.Card
  alias Poker.Hand
  alias Poker.Ranker

  doctest Ranker

  @tag :skip
  describe "royal flush" do
    test "royal flush beats anything" do
      royal_flush = %Hand{
        cards: [
          %Card{rank: 14, suit: :clubs},
          %Card{rank: 13, suit: :clubs},
          %Card{rank: 12, suit: :clubs},
          %Card{rank: 11, suit: :clubs},
          %Card{rank: 10, suit: :clubs},
        ],
        type: :royal_flush,
      }

      random_hand = Hand.new

      assert Ranker.call([royal_flush, random_hand]) == [
        royal_flush, random_hand
      ]
    end
  end

  test "royal flush always wins" do
    royal_flush = %Hand{
      cards: [
        %Card{rank: 14, suit: :clubs},
        %Card{rank: 13, suit: :clubs},
        %Card{rank: 12, suit: :clubs},
        %Card{rank: 11, suit: :clubs},
        %Card{rank: 10, suit: :clubs},
      ],
      type: :royal_flush,
    }

    random_hand = Hand.new

    hands = Enum.shuffle([royal_flush, random_hand])

    assert Ranker.highest_hand(hands) == [royal_flush]
  end

  test "identical royal flushes win" do
    royal_flush = %Hand{
      cards: [
        %Card{rank: 14, suit: :clubs},
        %Card{rank: 13, suit: :clubs},
        %Card{rank: 12, suit: :clubs},
        %Card{rank: 11, suit: :clubs},
        %Card{rank: 10, suit: :clubs},
      ],
      type: :royal_flush,
    }

    another_royal_flush = %Hand{
      cards: [
        %Card{rank: 14, suit: :clubs},
        %Card{rank: 13, suit: :clubs},
        %Card{rank: 12, suit: :clubs},
        %Card{rank: 11, suit: :clubs},
        %Card{rank: 10, suit: :clubs},
      ],
      type: :royal_flush,
    }

    hands = Enum.shuffle([royal_flush, another_royal_flush])
    result = Ranker.highest_hand(hands)

    assert length(result) == 2
    assert Enum.member?(result, royal_flush)
    assert Enum.member?(result, another_royal_flush)
  end

  test "straight flush beats four of a kind" do
    straight_flush = %Hand{
      cards: [
        %Card{rank: 5, suit: :clubs},
        %Card{rank: 6, suit: :clubs},
        %Card{rank: 7, suit: :clubs},
        %Card{rank: 8, suit: :clubs},
        %Card{rank: 9, suit: :clubs},
      ],
      type: :straight_flush,
    }

    four_of_a_kind = %Hand{
      cards: [
        %Card{rank: 14, suit: :hearts},
        %Card{rank: 14, suit: :clubs},
        %Card{rank: 14, suit: :spades},
        %Card{rank: 14, suit: :diamonds},
        %Card{rank: 8, suit: :clubs},
      ],
      type: :four_of_a_kind,
    }

    hands = Enum.shuffle([straight_flush, four_of_a_kind])
    result = Ranker.highest_hand(hands)

    assert length(result) == 1
    assert Enum.member?(result, straight_flush)
  end

  test "four of a kind beats full house" do
    four_of_a_kind = %Hand{
      cards: [
        %Card{rank: 14, suit: :hearts},
        %Card{rank: 14, suit: :clubs},
        %Card{rank: 14, suit: :spades},
        %Card{rank: 14, suit: :diamonds},
        %Card{rank: 8, suit: :clubs},
      ],
      type: :four_of_a_kind,
    }

    full_house = %Hand{
      cards: [
        %Card{rank: 13, suit: :hearts},
        %Card{rank: 13, suit: :clubs},
        %Card{rank: 13, suit: :spades},
        %Card{rank: 10, suit: :hearts},
        %Card{rank: 10, suit: :clubs},
      ],
      type: :full_house,
    }

    hands = Enum.shuffle([full_house, four_of_a_kind])
    result = Ranker.highest_hand(hands)

    assert length(result) == 1
    assert Enum.member?(result, four_of_a_kind)
  end

  describe "straight flush tie breaker" do
    test "highest rank at the top of the sequence wins" do
      straight_flush_low = %Hand{
        cards: [
          %Card{rank: 5, suit: :clubs},
          %Card{rank: 6, suit: :clubs},
          %Card{rank: 7, suit: :clubs},
          %Card{rank: 8, suit: :clubs},
          %Card{rank: 9, suit: :clubs},
        ],
        type: :straight_flush,
      }

      straight_flush_high = %Hand{
        cards: [
          %Card{rank: 6, suit: :hearts},
          %Card{rank: 7, suit: :hearts},
          %Card{rank: 8, suit: :hearts},
          %Card{rank: 9, suit: :hearts},
          %Card{rank: 10, suit: :hearts},
        ],
        type: :straight_flush,
      }

      hands = Enum.shuffle([straight_flush_low, straight_flush_high])
      result = Ranker.highest_hand(hands)

      assert length(result) == 1
      assert Enum.member?(result, straight_flush_high)
    end

    test "returns both if an identical tie" do
      straight_flush_a = %Hand{
        cards: [
          %Card{rank: 5, suit: :clubs},
          %Card{rank: 6, suit: :clubs},
          %Card{rank: 7, suit: :clubs},
          %Card{rank: 8, suit: :clubs},
          %Card{rank: 9, suit: :clubs},
        ],
        type: :straight_flush,
      }

      straight_flush_b = %Hand{
        cards: [
          %Card{rank: 5, suit: :clubs},
          %Card{rank: 6, suit: :clubs},
          %Card{rank: 7, suit: :clubs},
          %Card{rank: 8, suit: :clubs},
          %Card{rank: 9, suit: :clubs},
        ],
        type: :straight_flush,
      }

      hands = Enum.shuffle([straight_flush_a, straight_flush_b])
      result = Ranker.highest_hand(hands)

      assert length(result) == 2
      assert Enum.member?(result, straight_flush_a)
      assert Enum.member?(result, straight_flush_b)
    end
  end
end
