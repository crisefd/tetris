defmodule Tetris.Shape do
  alias Tetris.Brick

  @type point :: Brick.point()
  @type t :: [point]
  @type degrees :: Brick.degrees()

  @spec translate(t, point) :: t

  def translate(points, adjustment \\ {0, 0})

  def translate(points, {0, 0}), do: points

  def translate(points, {dx, dy}) do
    Enum.map(points, fn {x, y} ->
      {x + dx, y + dy}
    end)
  end

  @spec rotate(t, degrees) :: t

  def rotate(shape, 0), do: shape

  def rotate(shape, adjustment) do
    shape
    |> rotate_90()
    |> rotate(adjustment - 90)
  end

  @spec rotate_90(t) :: t

  defp rotate_90(shape) do
    shape
    |> transpose()
    |> mirror()
  end

  @spec transpose(t) :: t

  @doc """
      +
      +     --->  + + +
      + +         +   
  """
  defp transpose(shape) do
    shape |> Enum.map(fn {x, y} -> {y, x} end)
  end

  @doc """
      +            +
      +     --->   +
      + +        + +    
  """
  @spec mirror(t) :: t

  defp mirror(shape) do
    shape |> Enum.map(fn {x, y} -> {4 - x, y} end)
  end

  @spec flip(t) :: t

  @doc """
      +           + +
      +     --->  +
      + +         +
  """
  defp flip(shape) do
    shape |> Enum.map(fn {x, y} -> {x, 4 - y} end)
  end
end
