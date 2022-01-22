module Main exposing(..)

import Gaming exposing (..)


main =
  videogame view update initWorld


type alias World =
  { objects : List Object
  }

type alias Object =
  { name : String
  , location : (Float,Float)
  , sprite : String
  , scale : Float
  , behaviour : List Behaviour
  }

type Behaviour
  = Controllable
  | Collidable


initWorld : World
initWorld =
  { objects =
    [ { name = "Spaceship"
      , location = (0, 0)
      , sprite = "/assets/gfx/sprites/spaceship/fly.png"
      , scale = 0.2
      , behaviour = [ Controllable ]
      }
    ]
  }

-- UPDATE ----------------------------------------------------------

update computer world =
  let
    dx = (toX computer.keyboard)
    dy = (toY computer.keyboard)
    w = computer.screen.width
    h = computer.screen.height
    objs = behaving Controllable world.objects
    objs_ = List.map
      (\obj -> moveObject obj dx dy w h)
      world.objects  -- TODO
  in
    { world | objects = objs_ }


behaving : Behaviour -> List Object -> List Object
behaving beh objs =
  List.filter (hasBehaviour beh) objs

hasBehaviour : Behaviour -> Object -> Bool
hasBehaviour beh obj =
  List.member beh obj.behaviour


moveObject obj dx dy w h =
  let
    (x, y) = obj.location
    loc =
      ( x + 2 * dx |> boundX w
      , y + 2 * dy |> boundY h
      )
  in
    Debug.log "moved OBJ" { obj | location = loc }

-- VIEW ------------------------------------------------------------

view computer world =
  let
    x = computer.mouse.x
    y = computer.mouse.y
  in
    [ rectangle (rgb 135 135 130) computer.screen.width computer.screen.height
    , words black (screenInfo computer x y) |> move 0 250
    ]
    ++ List.map drawObject world.objects


drawObject obj =
  let
    (x, y) = obj.location
  in
    group
      [ image (932 * obj.scale) (430 * obj.scale) obj.sprite
      , square green 70
      ] |> move x y

drawShip ship =
  group
    [ image (932 * ship.scale) (430 * ship.scale) ship.sprite
    , square green 70
    ]


boundX w x =
  bound w (90, 200) x

boundY h y =
  bound h (30, 30) y

bound w (l, r) x =
  let
    mn = (-w / 2) + l
    mx = (w / 2) - r
  in
  if x < mn then mn
  else if x > mx then mx
  else x


coords label (x,y) =
  label ++ " : (" ++ String.fromFloat x ++ "," ++ String.fromFloat y ++ ")"


screenInfo computer x y =
  (coords "screen" (computer.screen.width, computer.screen.height)) ++ "; " ++
    (coords "mouse" (x,y))
