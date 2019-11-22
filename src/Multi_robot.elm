module Multi_robot exposing (main)

import Browser
import Html
import Robot


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
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


init : flags -> ( Model, Cmd Msg )
init _ =
    ( { robot1 = Robot.init 50 50 87 83 68 65 "red"
      , robot2 = Robot.init 100 100 38 40 39 37 "blue"
      , robot3 = Robot.init 150 150 104 98 102 100 "green"
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map Robot1Msg <| Robot.subscriptions model.robot1
        , Sub.map Robot2Msg <| Robot.subscriptions model.robot2
        , Sub.map Robot3Msg <| Robot.subscriptions model.robot3
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Robot1Msg robotMsg ->
            ( { model | robot1 = Robot.update robotMsg model.robot1 }, Cmd.none )

        Robot2Msg robotMsg ->
            ( { model | robot2 = Robot.update robotMsg model.robot2 }, Cmd.none )

        Robot3Msg robotMsg ->
            ( { model | robot3 = Robot.update robotMsg model.robot3 }, Cmd.none )


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ Html.map Robot1Msg <| Robot.view "1" model.robot1
        , Html.map Robot2Msg <| Robot.view "2" model.robot2
        , Html.map Robot3Msg <| Robot.view "3" model.robot3
        ]
