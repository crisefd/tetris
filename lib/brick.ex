defmodule Tetris.Brick do
  @type t :: %__MODULE__{
          name: :i | :o | :l | :z,
          location: {number, number},
          rotation: 0 | 90 | 180 | 270,
          reflection: boolean
        }
  defstruct name: :i,
            location: {40, 0},
            rotation: 0,
            reflection: false

  @spec new(:default | :random) :: t

  def new(kind \\ :default)

  def new(:default), do: __struct__()

  def new(:random) do
    %__MODULE__{
      name: ~w(i o l z)a |> Enum.random(),
      location: {40, 0},
      rotation: [0, 90, 180, 270] |> Enum.random(),
      reflection: [true, false] |> Enum.random()
    }
  end
end
