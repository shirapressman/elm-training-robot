module Main exposing (..)

import Browser
import Browser.Events
import Html
import Html.Attributes as Attributes exposing (style)
import Html.Events exposing (onClick)
import Json.Decode


main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


type alias Model =
    { x : Int, y : Int }


type Msg
    = KeyDown Int


init : () -> ( Model, Cmd Msg )
init _ =
    ( { x = 50, y = 50 }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Browser.Events.onKeyDown (Json.Decode.map KeyDown Html.Events.keyCode)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyDown code ->
            case code of
                37 ->
                    ( { model | x = model.x - 1 }, Cmd.none )

                38 ->
                    ( { model | y = model.y - 1 }, Cmd.none )

                39 ->
                    ( { model | x = model.x + 1 }, Cmd.none )

                40 ->
                    ( { model | y = model.y + 1 }, Cmd.none )

                defualt ->
                    ( model, Cmd.none )


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.div
            [ style "background-color" "black"
            , style "width" "30px"
            , style "height" "30px"
            , style "position" "absolute"
            , style "left" (String.fromInt model.x ++ "%")
            , style "top" (String.fromInt model.y ++ "%")
            ]
            []
        ]
