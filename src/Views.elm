module Views exposing (next, opacitySpec, prev, progressView, transformSpec, view, viewSlide, widthSpec)

import Browser
import Html exposing (Html, div, h1, h2, h3, pre, text)
import Html.Attributes exposing (class, id, style)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models exposing (Presentation, Slide(..), progress, slides)


view : Presentation -> Browser.Document Msg
view presentation =
    let
        currentSlides =
            slides presentation
    in
    { title = "Present"
    , body =
        [ div []
            (List.map (\( s, p ) -> viewSlide s p) currentSlides
                ++ [ progressView presentation, prev, next ]
            )
        ]
    }


prev : Html Msg
prev =
    div [ id "prev", onClick Previous ] []


next : Html Msg
next =
    div [ id "next", onClick Next ] []


viewSlide : Slide -> Float -> Html Msg
viewSlide slide position =
    let
        containerStyle =
            [ style "transform" (transformSpec position)
            , style "opacity" (opacitySpec position)
            ]

        content =
            case slide of
                Simple c ->
                    c
    in
    div ([ class "slide" ] ++ containerStyle) [ content ]


transformSpec : Float -> String
transformSpec amount =
    let
        scale =
            String.fromFloat <| 0.8 + 0.2 * (1.0 - abs amount)

        translate =
            String.fromFloat (amount * 100)
    in
    "translate(" ++ translate ++ "vw, 0%) scale(" ++ scale ++ ")"


opacitySpec : Float -> String
opacitySpec amount =
    String.fromFloat <| 1.0 - abs amount


progressView : Presentation -> Html Msg
progressView presentation =
    let
        width =
            widthSpec <| progress presentation
    in
    div [ class "progress-bar", style "width" width ] []


widthSpec : Float -> String
widthSpec progress =
    String.fromFloat (progress * 100) ++ "%"
