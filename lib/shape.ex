defmodule Tetris.Shape do
  alias Tetris.Brick

  @type point :: Brick.point()
  @type t :: [point]
  @type degrees :: Brick.degrees()

  @spec translate(t, point) :: t

  @doc """
    Ads {dx, dy} to every point {x, y} in the shape
  """
  def translate(points, adjustment \\ {0, 0})

  def translate(points, {0, 0}), do: points

  def translate(points, {dx, dy}) do
    Enum.map(points, fn {x, y} ->
      {x + dx, y + dy}
    end)
  end

  @spec rotate(t, degrees) :: t

  @doc """
    rotate 90 degrees as per adjustment
  """
  def rotate(shape, 0), do: shape

  def rotate(shape, adjustment) do
    shape
    |> rotate_90()
    |> rotate(adjustment - 90)
  end

  @spec rotate_90(t) :: t

  @doc """
    transpose |> mirror 
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
end
