import Browser
import Html exposing (Html, button, div, p, text)
import Html.Events exposing (onClick)

-- This connects our app below to DOM in the browser
main =
  Browser.sandbox { init = init, update = update, view = view }

-- MODEL

-- This is our model that describes the application state. This is similar
-- to a redux store.
type alias Model = Int

-- This function describes the initial state.
init : Model
init =
  0

-- UPDATE

-- This is the same concept as actions. We declare a custom type called Msg,
-- which can have the values Increment, Decrement, or Reset. This is similar
-- to having actions like {type: "Increment"}, {type: "Decrement"}...
type Msg = Increment | Decrement | Reset

-- This is our "reducer", which updates the state given some Msg (action).
update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

    Reset ->
      0

-- VIEW

-- This function describes the view in a List that represents an HTML tree. This
-- is similar to a React component.
view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , p [] [ text (String.fromInt model) ]
    , button [ onClick Increment ] [ text "+" ]
    , button [ onClick Reset ] [ text "reset" ]
    ]
