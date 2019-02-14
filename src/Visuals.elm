module Visuals exposing (background, bar, circles, colour, container, data, enumerated, zip)

import Html exposing (Html, div, h1)
import Html.Attributes exposing (class)
import Messages exposing (Msg)
import Svg exposing (circle, g, line, path, rect, svg, text, text_)
import Svg.Attributes exposing (cx, cy, d, dy, fill, fontSize, height, opacity, r, stroke, strokeWidth, textAnchor, viewBox, width, x, x1, x2, y, y1, y2)
import Tuple exposing (first, second)


container : String -> List (Html Msg) -> Html Msg
container title content =
    div []
        [ h1 [] [ text title ]
        , div [ class "example" ]
            [ svg [ viewBox "0 0 100 100" ] content
            ]
        ]


background : Html Msg
background =
    let
        oneToNine =
            List.range 1 9
    in
    g [ strokeWidth "0.4", stroke "white", opacity "0.6" ]
        ((oneToNine |> List.map (\n -> line [ x1 (String.fromInt (10 * n)), x2 (String.fromInt (10 * n)), y1 "0", y2 "100" ] []))
            ++ (oneToNine |> List.map (\n -> line [ y1 (String.fromInt (10 * n)), y2 (String.fromInt (10 * n)), x1 "0", x2 "100" ] []))
        )


circles : Html Msg
circles =
    let
        specs =
            [ ( "45", "white" )
            , ( "30", "blue" )
            , ( "15", "red" )
            ]
    in
    g [ opacity "0.8" ] <|
        List.map
            (\n ->
                circle
                    [ cx "50"
                    , cy "50"
                    , r (first n)
                    , fill (second n)
                    ]
                    []
            )
            specs


data : Bool -> Html Msg
data withColours =
    let
        -- was away at weekend... lazy
        calories =
            [ 349, 370, 488, 641, 672, 518, 832 ]

        caloriesWithIndex =
            enumerated calories

        len =
            List.length calories

        dx =
            90.0 / toFloat len

        sx =
            5.0
    in
    g [ opacity "0.8" ] <|
        List.map
            (\( idx, c ) ->
                bar c (sx + dx * toFloat idx) dx withColours
            )
            caloriesWithIndex


bar : Int -> Float -> Float -> Bool -> Html Msg
bar value sx dx withColours =
    rect
        [ x (String.fromFloat sx)
        , y (String.fromFloat (toFloat (1000 - value) / 10.0))
        , height (String.fromFloat (toFloat value / 10.0))
        , width (String.fromFloat (dx - 2.0))
        , fill
            (if withColours then
                colour value

             else
                "#64B5CA"
            )
        ]
        []


colour : Int -> String
colour value =
    if value < 400 then
        "#CA6464"

    else if value < 550 then
        "#64B5CA"

    else
        "#64CA7A"


zip : List a -> List b -> List ( a, b )
zip =
    List.map2 (\a b -> ( a, b ))


enumerated : List a -> List ( Int, a )
enumerated list =
    let
        indexes =
            List.range 0 (List.length list - 1)
    in
    zip indexes list
