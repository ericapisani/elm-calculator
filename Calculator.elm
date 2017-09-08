import Html exposing (..)

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL
type alias Model =
  {

  }

type Msg =
  EnteredNumber Int


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- INIT
init : (Model, Cmd Msg)
init =
  (Model , Cmd.none)


-- UPDATE
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  (model, Cmd.none)

-- VIEW
view: Model -> Html Msg
view model =
  div [] [
    text "Hello world!"
  ]
