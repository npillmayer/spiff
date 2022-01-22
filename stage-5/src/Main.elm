module Main exposing(..)

import Gaming exposing (..)


main =
  videogame view update initWorld
  --videogame view update (0,0)


type alias World =
  { ship : Ship
  }

type alias Ship =
  { location : (Float,Float)
  , sprite : String
  , scale : Float
  , behaviour : List Behaviour
  }

type Behaviour
  = Controllable
  | Collidable


initWorld : World
initWorld =
  { ship =
    { location = (0, 0)
    , sprite = "/assets/gfx/sprites/spaceship/fly.png"
    , scale = 0.2
    , behaviour = [ Controllable ]
    }
  }

-- UPDATE ----------------------------------------------------------

update computer world =
  let
    (x, y) = world.ship.location
    --y = world.ship.location.y
    loc = ( x + 2 *(toX computer.keyboard)
          |> boundX computer.screen.width
        , y + 2 * (toY computer.keyboard)
          |> boundY computer.screen.height)
    ship = world.ship
    ship_ = { ship | location = loc }
    in
    { world | ship = ship_ }


-- VIEW ------------------------------------------------------------

view computer world =
  let
    (x, y) = world.ship.location
  in
  [ rectangle (rgb 135 135 130) computer.screen.width computer.screen.height
  , drawShip world.ship |> move x y
  , words black (screenInfo computer x y)
  ]


drawShip ship =
  group
    [ image (932 * ship.scale) (430 * ship.scale) ship.sprite
    , square green 70
    ]


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



screenInfo computer x y =
  (coords (computer.screen.width, computer.screen.height)) ++ "\n" ++
    (coords (x,y))
