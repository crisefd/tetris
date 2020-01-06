defmodule BrickTest do
  use ExUnit.Case
  import Tetris.Brick

  @shapes Application.get_env(:tetris, :shapes)

  test "new brick" do
    brick = new()
    assert brick == %Tetris.Brick{name: :i, location: {40, 0}, rotation: 0, reflection: false}
  end

  test "new brick from attributes" do
    assert from([name: :l]).name == :l
    assert from([name: :z]).name == :z
    assert from([rotation: 90]).rotation == 90
  end

  test "get brick shape" do
    [:i, :o, :l, :z, :t]
    |> Enum.each(fn name -> 
      assert (from([name: name]) |> shape) == @shapes[name]
    end)
  end

  test "brick up movement" do
    brick = new() |> up()
    assert brick.location == {40, 1}

    brick = new() |> up(3)
    assert brick.location == {40, 3}
  end

  test "brick down movement" do
    brick = new() |> down()
    assert brick.location == {40, -1}

    brick = new() |> down(3)
    assert brick.location == {40, -3}
  end

  test "brick left movement" do
    brick = new() |> left()
    assert brick.location == {39, 0}

    brick = new() |> left(3)
    assert brick.location == {37, 0}
  end

  test "brick right movement" do
    brick = new() |> right()
    assert brick.location == {41, 0}

    brick = new() |> right(3)
    assert brick.location == {43, 0}
  end

  test "brick rotate movement" do
    assert (new() |> rotate()).rotation == 90
    assert (new() |> rotate(2)).rotation == 180
    assert (new() |> rotate(3)).rotation == 270
    assert (new() |> rotate(4)).rotation == 0
  end

end
