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
    age: String
  , name: String
  , password: String
  , passwordAgain: String
  }

init: Model
init =
  Model "" "" "" ""

-- UPDATE

type Msg
  = Name String
  | Password String
  | PasswordAgain String
  | Age String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password pw ->
      { model | password = pw }

    PasswordAgain pw ->
      { model | passwordAgain = pw }

    Age age ->
      { model | age = age }

-- VIEW

view : Model -> Html Msg

view model =
  div []
    [ viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password
    , viewInput "password" "Re-Enter Password" model.passwordAgain PasswordAgain
    , viewInput "number" "Age" model.age Age
    , viewValidation model
    ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []

viewValidation : Model -> Html Msg
viewValidation model =
  -- password and passwordAgain must match
  if doStringsMatch model.password model.passwordAgain
    -- password must be longer than 8 chars
    && validate8 model.password
    then
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
