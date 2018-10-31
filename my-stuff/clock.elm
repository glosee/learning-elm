import Browser
import Html exposing (..)
import Html.Events exposing (onClick)
import Task
import Time

-- MAIN

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

-- MODEL

type alias Model =
  { zone : Time.Zone
  , time : Time.Posix
  , paused: Bool
  }

init : () -> (Model, Cmd Msg)
init _ =
  ( Model Time.utc (Time.millisToPosix 0) False
  , Task.perform AdjustTimeZone Time.here
  )

-- UPDATE

type Msg
  = Tick Time.Posix
  | AdjustTimeZone Time.Zone
  | TogglePause

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      ( { model | time = newTime }
      , Cmd.none
      )

    AdjustTimeZone newZone ->
      ( { model | zone = newZone }
      , Cmd.none
      )

    TogglePause ->
      ( { model | paused = not model.paused }
      , Cmd.none
      )

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  if model.paused then
    Sub.none
  else
    Time.every 1000 Tick

-- VIEW

view : Model -> Html Msg
view model =
  let
    h = Time.toHour   model.zone model.time
    m = Time.toMinute model.zone model.time
    s = Time.toSecond model.zone model.time
  in
    div []
    [ h1 [] [text (makeTimeString h m s) ]
    , button [ onClick TogglePause ] [
        text (if model.paused then "Start" else "Pause") ]
    ]


makeTimeString : Int -> Int -> Int -> String
makeTimeString h m s =
  (addLeadingZeroAndMakeString h)
    ++ ":"
    ++ (addLeadingZeroAndMakeString m)
    ++ ":"
    ++ (addLeadingZeroAndMakeString s)

addLeadingZeroAndMakeString : Int -> String
addLeadingZeroAndMakeString to =
  let stringed = String.fromInt to
  in
    if String.length stringed > 1 then
      stringed
    else
      "0" ++ stringed
