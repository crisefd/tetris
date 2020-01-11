defmodule Tetris do
  alias Tetris.{Bottom, Brick, Shape}
  @type brick :: Brick.t()
  @type bottom :: map

  @spec prepare(brick) :: brick

  def prepare(brick) do
    brick
    |> Brick.prepare()
    |> Shape.traslate(brick.location)
  end

  @spec try_move(brick, bottom, function) :: brick

  def try_move(brick, bottom, fun) do
    new_brick = fun.(brick)
    if Bottom.collides?(bottom, prepare(new_brick)) do
      brick
    else
      new_brick
    end
  end

  for {name, fun} <-
        [try_left: &Brick.left/1,
         try_right: &Brick.right/1, 
         try_rotate: &Brick.rotate/1] do

    @spec unquote(name)(brick, bottom) :: brick

    def unquote(name)(brick, bottom), do: try_move(brick, bottom, unquote(Macro.escape(fun)))
  end
end
