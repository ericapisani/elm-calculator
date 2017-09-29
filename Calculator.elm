import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import String


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
    number1: Int,
    number2: Int,
    operation: Operation,
    result: Int
  }

type Operation = Addition | Subtraction | Multiplication | Division | Exponent

type Msg =
  EnteredFirstNumber String
  | EnteredSecondNumber String
  | CalculateAnswer Operation

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- INIT
init : (Model, Cmd Msg)
init =
  (Model 0 0 Addition 0, Cmd.none)


-- UPDATE
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    EnteredFirstNumber firstNumber->
      (model, Cmd.none)
    EnteredSecondNumber secondNumber ->
      (model, Cmd.none)
    CalculateAnswer selectedOperation ->
      (model, Cmd.none)

-- TODO: Add error handling since this is text
-- Will require a new message that handles both success and error states (the error state
-- displaying to the user that the input was invalid)

convertStringToInt: String -> Int
convertStringToInt newNumber =
  Result.withDefault 0 (String.toInt newNumber)

-- VIEW
view: Model -> Html Msg
view model =
  div [] [
    text "Enter the numbers you want to add:"
    , input [ type_ "text", placeholder "First number", onInput EnteredFirstNumber ] []
    , input [ type_ "text", placeholder "Second number", onInput EnteredSecondNumber ] []
    , button [ onClick (CalculateAnswer Addition) ] [ text "Calculate"]
    ,text ("The result is " ++ toString (model.result))
  ]
