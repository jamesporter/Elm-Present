module Models exposing (Position(..), Presentation, Slide(..), progress, slides)

import Array exposing (Array, get)
import Html exposing (Html)
import Messages exposing (Msg)


type Slide
    = Simple (Html Msg)


type Position
    = At Int
    | Forward Int Int Float
    | Backward Int Int Float


type alias Presentation =
    { position : Position
    , slides : Array Slide
    }


slides : Presentation -> List ( Slide, Float )
slides pres =
    let
        position =
            pres.position

        slds =
            pres.slides
    in
    case position of
        At n ->
            let
                slide =
                    get n slds
            in
            cleanSlides [ ( slide, 0.0 ) ]

        Forward from to p ->
            cleanSlides
                [ ( get from slds, -p )
                , ( get to slds, 1.0 - p )
                ]

        Backward from to p ->
            cleanSlides
                [ ( get from slds, p )
                , ( get to slds, p - 1.0 )
                ]


cleanSlides : List ( Maybe Slide, Float ) -> List ( Slide, Float )
cleanSlides rawSlides =
    List.filterMap
        (\( rs, f ) ->
            case rs of
                Just s ->
                    Just ( s, f )

                Nothing ->
                    Nothing
        )
        rawSlides


progress : Presentation -> Float
progress pres =
    let
        position =
            pres.position

        total =
            toFloat <| Array.length pres.slides

        current =
            case position of
                At n ->
                    toFloat <| n + 1

                Forward from to p ->
                    toFloat (1 + from) + toFloat (to - from) * p

                Backward from to p ->
                    toFloat (1 + from) - toFloat (from - to) * p
    in
    current / total
