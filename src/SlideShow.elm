module SlideShow exposing (simple, slideShow)

import Array exposing (fromList)
import Html exposing (Html, div, h1, h2, text)
import Markdown exposing (toHtml)
import Messages exposing (Msg)
import Models exposing (Slide(..))


asHtml : String -> Html Msg
asHtml content =
    toHtml [] content


simple : String -> Slide
simple md =
    Simple (asHtml md)


slideShow : Array.Array Slide
slideShow =
    fromList
        [ simple """
# Elm Present

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

[https://github.com/jamesporter/Elm-Present](https://github.com/jamesporter/Elm-Present)
"""
        ]
