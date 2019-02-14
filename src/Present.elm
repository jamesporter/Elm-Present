module Present exposing (animationSubs, init, initialModel, main, subscriptions)

import Browser
import Browser.Events
import Browser.Navigation as Nav
import Html exposing (Html)
import Keyboard
import Messages exposing (Msg(..))
import Models exposing (..)
import SlideShow exposing (slideShow)
import Updates exposing (..)
import Url
import Views exposing (view)


main : Program () Presentation Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : () -> ( Presentation, Cmd Msg )
init flags =
    ( initialModel, Cmd.none )


initialModel : Presentation
initialModel =
    { position = At 0
    , slides = slideShow
    , showCode = False
    }



-- SUBSCRIPTIONS


subscriptions : Presentation -> Sub Msg
subscriptions presentation =
    Sub.batch <|
        [ Keyboard.downs KeyDown
        ]
            ++ animationSubs presentation


animationSubs : Presentation -> List (Sub Msg)
animationSubs presentation =
    case presentation.position of
        At _ ->
            []

        _ ->
            [ Browser.Events.onAnimationFrameDelta TimeUpdate ]
