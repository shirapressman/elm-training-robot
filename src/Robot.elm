module Robot exposing (..)

import Browser
import Browser.Events
import Html
import Html.Attributes as Attributes exposing (style)
import Html.Events exposing (onClick)
import Json.Decode


type alias Model =
    { x : Float
    , y : Float
    , up : Int
    , down : Int
    , left : Int
    , right : Int
    , color : String
    }


type Msg
    = KeyDown Int


init : Float -> Float -> Int -> Int -> Int -> Int -> String -> Model
init x y up down left right color =
    { x = x, y = y, up = up, down = down, left = left, right = right, color = color }


subscriptions : Model -> Sub Msg
subscriptions model =
    Browser.Events.onKeyDown (Json.Decode.map KeyDown Html.Events.keyCode)


update : Msg -> Model -> Model
update msg model =
    case msg of
        KeyDown button ->
            if button == model.up then
                { model | y = model.y - 7 }

            else if button == model.down then
                { model | y = model.y + 7 }

            else if button == model.right then
                { model | x = model.x - 7 }

            else if button == model.left then
                { model | x = model.x + 7 }

            else
                model


view : String -> Model -> Html.Html Msg
view name model =
    Html.div
        [ style "background-color" model.color
        , style "width" "30px"
        , style "height" "30px"
        , style "position" "absolute"
        , style "left" (String.fromFloat model.x ++ "px")
        , style "top" (String.fromFloat model.y ++ "px")
        ]
        [ Html.text name ]
