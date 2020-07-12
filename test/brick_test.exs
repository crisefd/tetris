defmodule BrickTest do
  use ExUnit.Case
  import Tetris.Brick

  test "new brick" do
    brick = from([location: {40, 0}])
    assert brick == %Tetris.Brick{name: :i, location: {40, 0}, rotation: 0, reflection: false}
  end

  test "new brick from attributes" do
    assert from([name: :l]).name == :l
    assert from([name: :z]).name == :z
    assert from([rotation: 90]).rotation == 90
  end

  test "get brick shape" do
    shapes = all_shapes()
    all_names()
    |> Enum.each(fn name ->
      assert (from([name: name]) |> shape) == shapes[name]
    end)
  end

  test "brick down movement" do
    brick = from([location: {40, 0}]) |> down()
    assert brick.location == {40, 1}

    brick = from([location: {40, 0}]) |> down(3)
    assert brick.location == {40, 3}
  end

  test "brick left movement" do
    brick = from([location: {40, 0}]) |> left()
    assert brick.location == {39, 0}

    brick = from([location: {40, 0}]) |> left(3)
    assert brick.location == {37, 0}
  end

  test "brick right movement" do
    brick = from([location: {40, 0}]) |> right()
    assert brick.location == {41, 0}

    brick = from([location: {40, 0}]) |> right(3)
    assert brick.location == {43, 0}
  end

  test "brick rotate right movement" do
    assert (from([location: {40, 0}]) |> rotate_right()).rotation == 90
    assert (from([location: {40, 0}]) |> rotate_right(2)).rotation == 180
    assert (from([location: {40, 0}]) |> rotate_right(3)).rotation == 270
    assert (from([location: {40, 0}]) |> rotate_right(4)).rotation == 0
  end

  test "brick rotate left movement" do
    assert (from([location: {40, 0}]) |> rotate_left()).rotation == 270
    assert (from([location: {40, 0}]) |> rotate_left(2)).rotation == 180
    assert (from([location: {40, 0}]) |> rotate_left(3)).rotation == 90
    assert (from([location: {40, 0}]) |> rotate_left(4)).rotation == 0
  end

end
