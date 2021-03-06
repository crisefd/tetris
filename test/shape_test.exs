defmodule ShapeTest do
  use ExUnit.Case
  import Tetris.Shape
  alias Tetris.Brick

  test "should traslate shape" do
    shapes = Brick.all_shapes()
    actual = 
      Brick.from([name: :t])
      |> Brick.shape
      |> traslate({1, 1})

    expected = 
      shapes[:t]
      |> Enum.map( fn {x, y} ->  {x + 1, y + 1} end)

    assert actual == expected
  end

  test "should not traslate" do
    shapes = Brick.all_shapes()
    actual = 
      Brick.from([name: :t])
      |> Brick.shape
      |> traslate

    assert actual == shapes[:t]
  end

  test "should mirror flip  and rotate 180 degrees" do
      [{1, 1}]
      |> mirror
      |> assert_point({4, 1})
      |> flip
      |> assert_point({4, 4})
      |> rotate_90
      |> assert_point({1, 4})
      |> rotate_90
      |> assert_point({1, 1})
  end

  test "adding color to a shape" do
    color = Brick.all_colors |> Enum.random
      Brick.new(:random)
      |> Brick.shape
      |> with_color(color)
      |> Enum.each(fn {_, _, c} -> 
        assert c == color
      end)
  end


  defp assert_point([actual], expected) do
    assert actual == expected
    [actual]
  end
  
end