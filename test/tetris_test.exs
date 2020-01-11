defmodule TetrisTest do
  use ExUnit.Case
  alias Tetris.Brick
  import Tetris

  test "try to move right successfully" do
    brick = Brick.from [location: {5, 1}]
    bottom = %{}
    expected = brick |> Brick.right
    actual = try_right(brick, bottom)

    assert actual == expected
  end

  test "try to move right unsuccessfully" do
    brick = Brick.from [location: {8, 1}]
    bottom = %{}
    actual = try_right(brick, bottom)
    expected = brick

    assert actual == expected
  end


end
