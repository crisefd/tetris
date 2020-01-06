use Mix.Config

config :tetris,
       shapes: [
        l: [{2, 1}, {2, 2}, {2, 3}, {3, 3}],
        o: [{2, 2}, {3, 2}, {2, 3}, {3, 3}],
        i: [{2, 1}, {2, 2}, {2, 3}, {2, 4}],
        z: [{2, 2}, {2, 3}, {3, 3}, {3, 4}],
        t: [{2, 1}, {2, 2}, {3, 2}, {2, 3}]
      ]