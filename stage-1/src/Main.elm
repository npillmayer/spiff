module Main exposing(..)

import Playground exposing (..)

main =
  game view update (0,0)

view computer (x,y) =
  [ rectangle (rgb 135 135 130) computer.screen.width computer.screen.height
  , square green 40 |> move x y
--  , spaceship 0.2 |> move x (y + 70)
  , words black (coords (x,y))
  ]

update computer (x,y) =
  ( x + (toX computer.keyboard)
  , y + (toY computer.keyboard)
  )

coords (x,y) =
  "coords : (" ++ String.fromFloat x ++ "," ++ String.fromFloat y ++ ")"

spaceship scale =
  image (932 * scale) (430 * scale) "/assets/gfx/sprites/spaceship/fly.png"
