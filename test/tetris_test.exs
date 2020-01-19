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
    next_brick = Brick.new
    bottom = %{}
    expected =
      %{
        brick: Brick.down(brick),
        bottom: %{},
        score: 1,
        game_over: false
      }
    actual = drop(brick, next_brick, bottom, :red)
    assert actual.brick == expected.brick
    assert actual.bottom == expected.bottom
    assert actual.score == expected.score
    assert actual.game_over == expected.game_over
  end

  test "drops and merges" do
    brick = Brick.from [location: {5, 16}]
    next_brick = Brick.new
    bottom = %{}
    %{score: score,
      bottom: new_bottom} = drop(brick, next_brick, bottom, :red)
    assert Map.get(new_bottom, {7, 20}) == {7, 20, :red}
    assert score == 0

  end

  test "drops to bottom and compresses" do
    brick = Brick.from [location: {5, 16}]
    next_brick = Brick.new
    bottom =
      for x <- 1..10, y <- 17..20, x != 7 do
        {{x, y}, {x, y, :red}}
      end
      |> Map.new

   %{score: score,
     bottom: new_buttom} = drop(brick, next_brick, bottom, :red)

    assert new_buttom == %{}
    assert score == 1600
  end


end
