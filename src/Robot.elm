module Robot exposing (..)

import Browser
import Browser.Events
import Html
import Html.Attributes as Attributes exposing (style)
import Html.Events exposing (onClick)
import Json.Decode



--main =
--Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


type alias Model =
    { x : Float
    , y : Float
    , up : Int
    , down : Int
    , left : Int
    , right : Int
    }


type Msg
    = KeyDown Int


init : Float -> Float -> Int -> Int -> Int -> Int -> Model
init x y up down left right =
    { x = x, y = y, up = up, down = down, left = left, right = right }


subscriptions : Model -> Sub Msg
subscriptions model =
    Browser.Events.onKeyDown (Json.Decode.map KeyDown Html.Events.keyCode)


update : Msg -> Model -> Model
update msg model =
    let
        _ =
            Debug.log "msg" msg
    in
    case msg of
        KeyDown code ->
            case code of
                38 ->
                    { model | x = model.x - 1 }

                40 ->
                    { model | y = model.y - 1 }

                39 ->
                    { model | x = model.x + 1 }

                37 ->
                    { model | y = model.y + 1 }

                87 ->
                    { model | x = model.x - 1 }

                83 ->
                    { model | y = model.y - 1 }

                69 ->
                    { model | x = model.x + 1 }

                65 ->
                    { model | y = model.y + 1 }

                defualt ->
                    model


view : String -> Model -> Html.Html Msg
view name model =
    Html.div
        [ style "background-color" "black"
        , style "width" "30px"
        , style "height" "30px"
        , style "position" "absolute"
        , style "left" (String.fromFloat model.x ++ "px")
        , style "top" (String.fromFloat model.y ++ "px")
        ]
        [ Html.text name ]
