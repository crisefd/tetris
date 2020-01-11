defmodule Tetris.Bottom do
    alias Tetris.Shape
    @type point :: Shape.point
    @type shape :: Shape.t
    @type bottom :: map

    @spec merge(bottom, shape) :: bottom

    def merge(bottom, shape) do
        shape
        |> Enum.map(fn {x, y, color} -> 
            {{x, y}, {x, y, color}} 
        end)
        |> Enum.into(bottom)
    end

    @spec collides?(bottom, shape | point) :: boolean

    def collides?(bottom, {x, y, _}), do: collides?(bottom, {x, y})

    def collides?(bottom, {x, y}) do
        !!Map.get(bottom, {x, y}) || x < 1 || x > 10 || y > 20
    end

    def collides?(bottom, points) when is_list(points) do
        Enum.any?(points, &collides?(bottom, &1))
    end
end