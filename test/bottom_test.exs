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

    test "compute complete ys" do
        b = new_bottom(20, [{{19, 19}, {19, 19, :red}}])
        assert complete_ys(b) == [20]
    end

    test "collapse single row" do
        b = new_bottom(20, [{{19, 19}, {19, 19, :red}}])
        actual = Map.keys(collapse_row(b, 20))
        refute {19, 19} in actual
        assert {19, 20} in actual
        assert Enum.count(actual) == 1
    end

    test "full collapse with single row" do
        b = new_bottom(20, [{{19, 19}, {19, 19, :red}}])
        {actual_count, actual_bottom} = full_collapse(b)
        assert actual_count == 1
        assert {19, 20} in Map.keys(actual_bottom)
    end

    test "full collapse" do
        
    end

    def new_bottom(completed_row, extras) do
       extras ++
        (1..10
        |> Enum.map(fn x -> 
            {{x, completed_row}, {x, completed_row, :red}}
        end))
        |> Map.new
    end

end