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

  test "drops without merging" do
    brick = Brick.from [location: {5, 5}]
    bottom = %{}
    expected =
      %{
        brick: Brick.down(brick),
        bottom: %{},
        score: 1
      }
    actual = drop(brick, bottom, :red)
    assert actual == expected
  end

  test "drops and merges" do
    brick = Brick.from [location: {5, 16}]
    bottom = %{}
    actual = drop(brick, bottom, :red)
    assert Map.get(actual.bottom, {7, 20}) == {7, 20, :red}
  end


end
