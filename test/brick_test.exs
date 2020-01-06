defmodule BrickTest do
  use ExUnit.Case
  doctest Tetris
  alias Tetris.Brick


  test "new brick" do
    brick = Brick.new()
    assert brick == %Brick{name: :i,
                           location: {40, 0},
                           rotation: 0,
                           reflection: false}
   
  end

end