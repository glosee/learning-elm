import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

-- MAIN

main =
  Browser.sandbox { init = init, update = update, view = view }

-- MODEL

type alias Model =
  {
    name: String
  , password: String
  , passwordAgain: String
  }

init: Model
init =
  Model "" "" ""

-- UPDATE
-- This is something similar to { type: "Name", payload: String } if JS had types
type Msg
  = Name String
  | Password String
  | PasswordAgain String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password pw ->
      { model | password = pw }

    PasswordAgain pw ->
      { model | passwordAgain = pw }

-- VIEW

view : Model -> Html Msg

view model =
  div []
    [ viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password
    , viewInput "password" "Re-Enter Password" model.passwordAgain PasswordAgain
    , viewValidation model
    ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
-- viewInput t p v toMsg =
--   input [ type_ t, placeholder p, value v, onInput toMsg ] []

viewInput t p v toMsg =
  div [ style "padding" "5px" ]
    [
      label [ for p ] [ text p ++ ": " ],
      input [ name p, type_ t, placeholder p, value v, onInput toMsg ] []
    ]

viewValidation : Model -> Html Msg
viewValidation model =
  -- password and passwordAgain must match
  if arePasswordsValid model.password model.passwordAgain then
    div [ style "color" "green" ] [ text "ok" ]
  else
    div [ style "color" "red" ] [ text "passwords do not match!" ]

validateLength : String -> Int -> Bool
validateLength str len =
  String.length str == len

validate8 : String -> Bool
validate8 str =
  validateLength str 8

doStringsMatch : String -> String -> Bool
doStringsMatch a b =
  a == b

arePasswordsValid : String -> String -> Bool
arePasswordsValid pw1 pw2 =
  validate8 pw1 && doStringsMatch pw1 pw2
