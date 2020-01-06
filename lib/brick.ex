defmodule Tetris.Brick do
  @type point :: {number, number}
  @type t :: %__MODULE__{
          name: :i | :o | :l | :z,
          location: point,
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

  defmodule Movements do
    def down({x, y}, step), do: {x, y - step}
    def up({x, y}, step), do: {x, y + step}
    def left({x, y}, step), do: {x - step, y}
    def right({x, y}, step), do: {x + step, y}
    def rotate(degrees, step) do
      case degrees + 90 * step do
        360 -> 0
        res -> res
      end
    end
  end

  for {name, operation, field} <- [
        {:down, &Movements.down/2, :location},
        {:up, &Movements.up/2, :location},
        {:left, &Movements.left/2, :location},
        {:right, &Movements.right/2, :location},
        {:rotate, &Movements.rotate/2, :rotation}
      ] do
    @spec unquote(name)(t, integer) :: t

    def unquote(name)(%__MODULE__{unquote(field) => value} = brick, step \\ 1) do
      %{brick | unquote(field) => unquote(Macro.escape(operation)).(value, step)}
    end
  end
end
