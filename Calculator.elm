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
  | UpdateOperation Operation
  | CalculateAnswer

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
      ({ model | number1 = convertStringToInt firstNumber }, Cmd.none)
    EnteredSecondNumber secondNumber ->
      ({ model | number2 = convertStringToInt secondNumber }, Cmd.none)
    UpdateOperation operation ->
      ({ model | operation = operation }, Cmd.none)
    CalculateAnswer ->
      ({ model | result = calculateResult model}, Cmd.none)

-- TODO: Add error handling since this is text
-- Will require a new message that handles both success and error states (the error state
-- displaying to the user that the input was invalid)

convertStringToInt: String -> Int
convertStringToInt newNumber =
  Result.withDefault 0 (String.toInt newNumber)   -- Default the value to 0 if there's an issue parsing the string into a number

calculateResult: Model -> Int
calculateResult model =
  case model.operation of
    Addition ->
      model.number1 + model.number2

    _ ->   -- Catch all arg if the operation is not Addition
      0

createViewOption: Operation -> Html Msg
createViewOption operation =
  option [ value <| toString operation ] [ text <| toString operation]

dispatchOperationMessage: String -> Msg
dispatchOperationMessage targetValue =
  case targetValue of
    "Addition" ->
      UpdateOperation Addition
    "Subtraction" ->
      UpdateOperation Subtraction
    "Multiplication" ->
      UpdateOperation Multiplication
    "Division" ->
      UpdateOperation Division
    "Exponent" ->
      UpdateOperation Exponent
    _ ->
      UpdateOperation Addition

-- VIEW
view: Model -> Html Msg
view model =
  div [] [
    text "Enter the numbers you want to perform an operation on:"
    , input [ type_ "text", placeholder "First number", onInput EnteredFirstNumber ] []
    , input [ type_ "text", placeholder "Second number", onInput EnteredSecondNumber ] []
    , select [ onInput dispatchOperationMessage ] [
      createViewOption Addition
      , createViewOption Subtraction
      , createViewOption Multiplication
      , createViewOption Division
      , createViewOption Exponent
    ]
    , button [ onClick (CalculateAnswer) ] [ text "Calculate"]
    ,text ("The result is " ++ toString (model.result))
  ]
