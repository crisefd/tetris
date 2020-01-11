defmodule BottomTest do
    use ExUnit.Case
    import Tetris.Bottom

    setup_all do
        {:ok, 
        bottom: %{{1, 1} => {1, 1, :blue}} }
    end

    test "various collisions", state do
        bottom = state[:bottom]
        assert collides?(bottom, {1, 1})
        refute collides?(bottom, {1, 2})
        assert collides?(bottom, {1, 1, :blue})
        assert collides?(bottom, {1, 1, :red})
        assert collides?(bottom, [{1, 1, :red}, {1, 2, :orange}])
        refute collides?(bottom, [{1, 2, :red}, {1, 3, :orange}])
    end

    test "simple merge", state do
        bottom = state[:bottom]
        actual = merge bottom, [{1, 2, :red}, {1, 3, :red}]
        expected = %{
            {1, 1} => {1, 1, :blue},
            {1, 2} => {1, 2, :red},
            {1, 3} => {1, 3, :red}
        }
        assert actual == expected
    end

end