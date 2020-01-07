defmodule ShapeTest do
  use ExUnit.Case
  import Tetris.Shape
  alias Tetris.Brick

  @shapes Application.get_env(:tetris, :shapes)

  test "translate shape" do
    actual = 
      Brick.from([name: :t])
      |> Brick.shape()
      |> translate({1, 1})

    expected = 
      @shapes[:t]
      |> Enum.map( fn {x, y} ->  {x + 1, y + 1} end)

    assert actual == expected
  end
  
end