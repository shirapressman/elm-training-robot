module MultiRobot exposing (main)

import Browser
import Html
import Robot


main : Program () Model Msg
main =
    Browser.element
        { init = always ( init, Cmd.none )
        , update = \a b -> ( update a b, Cmd.none )
        , view = view
        , subscriptions = subscriptions
        }


type Msg
    = Robot1Msg Robot.Msg
    | Robot2Msg Robot.Msg
    | Robot3Msg Robot.Msg


type alias Model =
    { robot1 : Robot.Model
    , robot2 : Robot.Model
    , robot3 : Robot.Model
    }


init : Model
init =
    { robot1 = Robot.init 50 50 "w" "s" "d" "a" "red"
    , robot2 = Robot.init 100 100 "ArrowUp" "ArrowDown" "ArrowRight" "ArrowLeft" "blue"
    , robot3 = Robot.init 150 150 "8" "2" "6" "4" "green"
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map Robot1Msg <| Robot.subscriptions model.robot1
        , Sub.map Robot2Msg <| Robot.subscriptions model.robot2
        , Sub.map Robot3Msg <| Robot.subscriptions model.robot3
        ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        Robot1Msg robotMsg ->
            { model | robot1 = Robot.update robotMsg model.robot1 }

        Robot2Msg robotMsg ->
            { model | robot2 = Robot.update robotMsg model.robot2 }

        Robot3Msg robotMsg ->
            { model | robot3 = Robot.update robotMsg model.robot3 }


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.map Robot1Msg <| Robot.view "1" model.robot1
        , Html.map Robot2Msg <| Robot.view "2" model.robot2
        , Html.map Robot3Msg <| Robot.view "3" model.robot3
        ]
