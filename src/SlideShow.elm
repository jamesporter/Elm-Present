module SlideShow exposing (asHtml, simple, slideShow, withCode)

import Array exposing (fromList)
import Html exposing (Html, div, h1, h2, text)
import Markdown exposing (toHtml)
import Messages exposing (Msg)
import Models exposing (Slide(..))
import Visuals exposing (..)


asHtml : String -> Html Msg
asHtml content =
    toHtml [] content


simple : String -> Slide
simple md =
    Simple (asHtml md)


withCode : String -> String -> Slide
withCode md code =
    WithCode (asHtml md) code


slideShow : Array.Array Slide
slideShow =
    fromList
        [ simple """
# Elm Data

## James Porter

@complexview
"""
        , simple """
# Types of Data Vis

* Exploratory
* Static publication
* Interactive (web?)

Only focusing on last one
"""
        , simple """
# Frameworks

* Easy/simple (Chart.js)
* Low level (D3?)
* Balanced (Victory?)
* No Framework (React, Elm)
"""
        , simple """
# A few minutes

If you already know Elm can learn enough to do interactive datavis
"""
        , withCode """
# This is Elm

All the slides are in Elm (most with Markdown)

[elm-data.amimetic.co.uk](http://elm-data.amimetic.co.uk)

(Datavis, making a game and making a slide show framework all great ways to learn Elm.)
""" """
type Slide
    = Simple (Html Msg)
    | WithCode (Html Msg) String

--Elm Markdown
import Markdown exposing (toHtml)

--simplify
asHtml : String -> Html Msg

--make it ergonomic for easy slides
simple : String -> Slide

withCode : String -> String -> Slide
withCode md code =
    WithCode (asHtml md) code
"""
        , withCode """
# Transitions

Usually this is the hard bit

(or the bit with unstructured magical messiness)
""" """
type Position
    = At Int
    | Forward Int Int Float
    | Backward Int Int Float

Sub.batch <|
    [ Keyboard.downs KeyDown
    , AnimationFrame.diffs TimeUpdate ]
"""
        , simple """
# SVG Primatives

* g group
* rect rectangle
* circle
* ellipse
* polygon
* text_ (text tag, use text for content)

Look these up details later, Elm has very direct support like for HTML.
        """
        , WithCode (container "SVG" [])
            """
container : List (Html Msg) -> Html Msg
container content =
    div [ class "example" ]
        [ svg [ viewBox "0 0 100 100" ] content
        ]
"""
        , WithCode (container "Lines" [ background ]) """
g [ strokeWidth "0.4", stroke "white" ]

((oneToNine |> List.map (
 n -> line [ x1 (toString (10 * n)),
             x2 (toString (10 * n)),
             y1 "0",
             y2 "100" ] []))
"""
        , WithCode (container "Circles" [ background, circles ]) """
let
    specs =
        [ ( "45", "white" ), ( "35", "blue" ), ( "25", "red" )]
in
    g [ opacity "0.8" ] <|
        List.map
            ( n ->
                circle
                    [ cx "50"
                    , cy "50"
                    , r (first n)
                    , fill (second n)
                    ]
                    []
            )
            specs
"""
        , WithCode (container "Data" [ background, data False ]) """
calories =
    [ 349, 370, 488, 641, 672, 518, 832 ]

caloriesWithIndex =
    enumerated calories

[...]

bar value sx dx withColours =
    rect
        [ x (toString sx)
        , y (toString ((toFloat (1000 - value)) / 10.0))
        , height (toString ((toFloat (value)) / 10.0))
        , width (toString (dx - 2.0))
        , fill  "#64B5CA"
        ]
        []
"""
        , WithCode (container "Data II" [ background, data True ]) """
colour : Int -> String
colour value =
    if value < 400 then
        "#CA6464"
    else if value < 550 then
        "#64B5CA"
    else
        "#64CA7A"
"""
        , simple """# Generally works well

* Full control (D3 style, but without dependency)
* Type checking really helpful
* Easy to extract functions when things become complicated
* Particularly good for transitions (as just another part of state)
* All usual strengths of Elm
"""
        , simple """# Frustrations
* Types: low level API expects strings
    * Could trivially create Float or Integer versions
    * But actually probably want both (and can be encapsulated)
* Slower to get started

"""
        , simple """
# Thanks

## James Porter

Follow me *@complexview*, for the slides:

[elm-data.amimetic.co.uk](http://elm-data.amimetic.co.uk)

Source code:

[github.com/jamesporter/elm-present-data](https://github.com/jamesporter/elm-present-data)
"""
        ]
