defmodule Tetris do
  alias Tetris.{Bottom, Brick, Shape}
  @type brick :: Brick.t()
  @type color :: Brick.color()
  @type bottom :: map
  @type shape :: Shape.t

  @spec prepare(brick) :: shape

  def prepare(brick) do
    brick
    |> Brick.prepare()
    |> Shape.traslate(brick.location)
  end

  @spec drop(brick, bottom, color) :: map

  def drop(brick, bottom, color) do
    new_brick = Brick.down(brick)
    bottom
    |> Bottom.collides?(prepare(new_brick))
    |> drop_helper(bottom, brick, new_brick, color)
  end




  for {name, fun} <-
        [try_left: &Brick.left/1,
         try_right: &Brick.right/1, 
         try_rotate: &Brick.rotate/1] do

    @spec unquote(name)(brick, bottom) :: brick

    def unquote(name)(brick, bottom), do: try_move(brick, bottom, unquote(Macro.escape(fun)))
  end

  @spec try_move(brick, bottom, function) :: brick

  defp try_move(brick, bottom, fun) do
    new_brick = fun.(brick)
    if Bottom.collides?(bottom, prepare(new_brick)) do
      brick
    else
      new_brick
    end
  end

  @spec drop_helper(boolean, bottom, brick, brick, color) :: map

  defp drop_helper(collided?, bottom, brick, new_brick, color)

  defp drop_helper(true, bottom, brick, _new_brick, color) do
    new_brick = Brick.new :random
    shape =
      brick
      |> prepare
      |> Shape.with_color(color)

    {count, new_bottom} =
      bottom
      |> Bottom.merge(shape)
      |> Bottom.full_collapse
    %{
      brick: new_brick, 
      bottom: new_bottom, 
      score: score(count),
      game_over: Bottom.collides?(new_bottom, prepare(new_brick))
    }
  end

  defp drop_helper(false, bottom, _brick, new_brick, _color) do
    %{brick: new_brick, bottom: bottom, score: 1, game_over: false}
  end

  defp score(0), do: 0
  defp score(count), do: 100 * round(:math.pow(2, count))

end
