defmodule ShapeTest do
  use ExUnit.Case
  import Tetris.Shape
  alias Tetris.Brick

  

  test "should translate shape" do
    shapes = Brick.all_shapes()
    actual = 
      Brick.from([name: :t])
      |> Brick.shape
      |> translate({1, 1})

    expected = 
      shapes[:t]
      |> Enum.map( fn {x, y} ->  {x + 1, y + 1} end)

    assert actual == expected
  end

  test "should not translate" do
    shapes = Brick.all_shapes()
    actual = 
      Brick.from([name: :t])
      |> Brick.shape
      |> translate

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


  defp assert_point([actual], expected) do
    assert actual == expected
    [actual]
  end
  
end