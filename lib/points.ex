defmodule Tetris.Points do
  alias Tetris.Brick

  @type point :: Brick.point

  @spec translate([point], point) :: [point]

  def translate(points, adjustment \\ {0, 0})

  def translate(points, {dx, dy}) do
    Enum.map(points, fn {x, y} -> 
      {x + dx, y + dy}
    end)
  end
end