defmodule Poker.Card do
  # Ranks of numbered cards are represented by the number (2..10)
  # Jack, Queen, King, Ace represented by 11, 12, 13, 14 respectively
  # Suits can be: :hearts, :diamonds, :clubs, :spades

  defstruct [:rank, :suit]

  @type t :: %__MODULE__{
    rank: 2..14,
    suit: :clubs | :hearts | :diamonds | :spades,
  }

  def new do
    %__MODULE__{
      rank: Enum.random(2..14),
      suit: Enum.random([:clubs, :hearts, :diamonds, :spades]),
    }
  end
end
