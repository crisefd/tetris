defmodule Tetris.Shape do
  alias Tetris.Brick

  @type point :: Brick.point()
  @type t :: [point]
  @type degrees :: Brick.degrees()
  @type color :: Brick.color()

  @spec traslate(t, point) :: t

  @doc """
    Adds {dx, dy} to every point {x, y} in the shape
  """
  def traslate(shape, adjustment \\ {0, 0})

  def traslate(shape, {0, 0}), do: shape

  def traslate(shape, {dx, dy}) do
    Enum.map(shape, fn {x, y} ->
      {x + dx, y + dy}
    end)
  end

  @spec rotate(t, degrees) :: t

  @doc """
    rotates 90 degrees as per adjustment
  """
  def rotate(shape, 0), do: shape

  def rotate(shape, adjustment) do
    shape
    |> rotate_90()
    |> rotate(adjustment - 90)
  end

  @spec rotate_90(t) :: t

  @doc """
    transposes and mirrors the given shape
  """
  def rotate_90(shape) do
    shape
    |> transpose
    |> mirror
  end

  @spec transpose(t) :: t

  @doc """
      +
      +     --->  + + +
      + +         +
  """
  def transpose(shape) do
    shape |> Enum.map(fn {x, y} -> {y, x} end)
  end

  @doc """
      +            +
      +     --->   +
      + +        + +
  """
  @spec mirror(t) :: t

  def mirror(shape) do
    shape |> Enum.map(fn {x, y} -> {5 - x, y} end)
  end

  @spec mirror(t, boolean) :: t

  def mirror(shape, false), do: shape

  def mirror(shape, true), do: mirror(shape)

  @spec flip(t) :: t

  @doc """
      +           + +
      +     --->  +
      + +         +
  """
  def flip(shape) do
    shape |> Enum.map(fn {x, y} -> {x, 5 - y} end)
  end

  @spec to_string(t) :: binary
  @doc """
    Returns string representation of the given shape
  """
  def to_string(shape) do
    map =
      shape
      |> Enum.map(fn key -> {key, "🔲"} end)
      |> Map.new()

    for y <- 1..4, x <- 1..4 do
      Map.get(map, {x, y}, "⬛️")
    end
    |> Enum.chunk_every(4)
    |> Enum.map(&Enum.join/1)
    |> Enum.join("\n")
  end

  @spec print(t) :: t

  def print(shape) do
    shape
    |> __MODULE__.to_string()
    |> IO.puts()

    shape
  end

  @spec with_color(t, color) :: t
  @doc """
    Adds the color to every point in the shape
  """
  def with_color(shape, color) do
    shape
    |> Enum.map( fn point -> add_color(point, color) end)
  end

  @spec add_color(point, color) :: point

  defp add_color(point, color)

  defp add_color({_, _, _} = point, _), do: point

  defp add_color({x, y}, color), do: {x, y, color}

end
