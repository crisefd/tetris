defmodule Tetris.Bottom do
    alias Tetris.Shape
    @type point :: Shape.point
    @type shape :: Shape.t
    @type bottom :: map

    @max_width 10
    @min_width 1
    @max_height 20

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
        !!Map.get(bottom, {x, y}) || x < @min_width || x > @max_width || y >  @max_height
    end

    def collides?(bottom, points) when is_list(points) do
        Enum.any?(points, &collides?(bottom, &1))
    end

    @spec complete?(bottom, integer) :: boolean

    def complete?(bottom, row) do
        bottom
        |> bad_keys(row)
        |> Enum.count
        |> (&(&1 == @max_width)).()
    end

    @spec full_collapse(bottom) :: bottom

    def full_collapse(bottom) do
        bottom
        |> complete_ys
        |> Enum.reduce(bottom, &collapse_row(&2, &1))
    end

    @spec complete_ys(bottom) :: list

    def complete_ys(bottom) do
        bottom
        |> Map.keys
        |> Enum.map(&elem(&1, 1))
        |> Enum.uniq
        |> Enum.filter(fn y -> complete?(bottom, y) end)
    end

    @spec collapse_row(bottom, integer) :: bottom

    def collapse_row(bottom, row) do
        bottom
        |> Map.drop(bad_keys(bottom, row))
        |> Enum.map(&move_bad_points_up(&1, row))
        |> Map.new
    end

    @spec move_bad_points_up(tuple, integer) :: tuple

    defp move_bad_points_up({{x, y}, {x, y, color}}, row) when y < row do
        {{x, y + 1}, {x, y + 1, color}}
    end

    defp move_bad_points_up(key_value, _row)  do
       key_value 
    end

    @spec bad_keys(bottom, integer) :: list

    defp bad_keys(bottom, row) do
        bottom
        |> Map.keys
        |> Enum.filter(fn {_x, y} -> y == row end)
    end
end