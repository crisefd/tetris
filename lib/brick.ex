defmodule Tetris.Brick do
  alias Tetris.Shape
  @type color :: :red | :blue | :green | :orange | :grey
  @type point :: {integer, integer} | {integer, integer, color}
  @type name :: :i | :o | :l | :z | :t
  @type degrees :: 0 | 90 | 180 | 270
  @type t :: %__MODULE__{
          name: name,
          location: point,
          rotation: degrees,
          reflection: boolean
        }

  @shapes [
    l: [{2, 1}, {2, 2}, {2, 3}, {3, 3}],
    o: [{2, 2}, {3, 2}, {2, 3}, {3, 3}],
    i: [{2, 1}, {2, 2}, {2, 3}, {2, 4}],
    z: [{2, 2}, {2, 3}, {3, 3}, {3, 4}],
    t: [{2, 1}, {2, 2}, {3, 2}, {2, 3}]
  ]

  @names ~w(i o l z t)a

  @colors ~w(red blue green orange grey)a

  defstruct name: :i,
            location: {40, 0},
            rotation: 0,
            reflection: false

  @spec new(:default | :random) :: t

  def new(kind \\ :default)

  def new(:default), do: __struct__()

  def new(:random) do
    %__MODULE__{
      name: @names |> Enum.random(),
      location: {3, -3},
      rotation: [0, 90, 180, 270] |> Enum.random(),
      reflection: [true, false] |> Enum.random()
    }
  end

  @spec from(keyword) :: t

  def from(opts \\ [])

  def from([]), do: new()

  def from(opts), do: __struct__(opts)

  @spec shape(t) :: [point]

  def shape(%__MODULE__{name: name}), do: @shapes[name]

  def all_shapes, do: @shapes

  def all_names, do: @names

  def all_colors, do: @colors

  @spec to_string(t) :: binary

  def to_string(brick) do
    brick
    |> prepare
    |> Shape.to_string()
  end

  @spec print(t) :: t

  def print(brick) do
    brick
    |> prepare
    |> Shape.print()

    brick
  end

  defmodule Movements do
    def down({x, y}, step), do: {x, y + step}
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
        {:left, &Movements.left/2, :location},
        {:right, &Movements.right/2, :location},
        {:rotate, &Movements.rotate/2, :rotation}
      ] do
    @spec unquote(name)(t, integer) :: t

    def unquote(name)(%__MODULE__{unquote(field) => value} = brick, step \\ 1) do
      %{brick | unquote(field) => unquote(Macro.escape(operation)).(value, step)}
    end
  end

  @spec color(t) :: any

  for {name, col} <- Enum.zip(@names, @colors) do

    def color(%__MODULE__{name: unquote(name)}), do: unquote(col)
  end

  @spec prepare(t) :: [point]

  def prepare(brick) do
    brick
    |> shape
    |> Shape.rotate(brick.rotation)
    |> Shape.mirror(brick.reflection)
  end

  defimpl Inspect, for: Tetris.Brick do
    import Inspect.Algebra

    @spec inspect(Tetris.Brick.t, any) :: binary
  
    def inspect(brick, _opts) do
      concat([
        Tetris.Brick.to_string(brick),
        "\n",
        "location: ",
        Kernel.inspect(brick.location),
        "\n",
        "refection: ",
        Kernel.inspect(brick.reflection),
        "\n",
        "rotation: ",
        Kernel.inspect(brick.rotation)
      ])
    end
  end
end
