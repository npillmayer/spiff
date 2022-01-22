module Main exposing(..)

import Gaming exposing (..)


main =
  videogame view update (0,0)


view computer (x,y) =
  [ rectangle (rgb 135 135 130) computer.screen.width computer.screen.height
  , square green 70 |> move x y
  , spaceship 0.2 |> move x y
--  , words black (coords (x,y))
  , words black (screenInfo computer x y)
  ]


update computer (x,y) =
  ( x + 2 *(toX computer.keyboard)
    |> boundX computer.screen.width
  , y + 2 * (toY computer.keyboard)
    |> boundY computer.screen.height
  )


boundX w x =
  let
    m = (-w / 2) + 90
    mx = (w / 2) - 200
  in
  if x < m then
    m
  else if x > mx then
    mx
  else
    x

boundY h y =
  let
    mn = (-h / 2) + 30
    mx = (h / 2) - 30
  in
  if y < mn then
    mn
  else if y > mx then
    mx
  else
    y


coords (x,y) =
  "coords : (" ++ String.fromFloat x ++ "," ++ String.fromFloat y ++ ")"


spaceship scale =
  image (932 * scale) (430 * scale) "/assets/gfx/sprites/spaceship/fly.png"


screenInfo computer x y =
  (coords (computer.screen.width, computer.screen.height)) ++ "\n" ++
    (coords (x,y))
