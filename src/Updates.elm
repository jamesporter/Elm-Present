module Updates exposing (update)

import Array exposing (length)
import Debug
import Keyboard exposing (RawKey(..))
import Messages exposing (Msg(..))
import Models exposing (Position(..), Presentation, Slide(..))
import Platform.Cmd
import Time exposing (Posix)


update : Msg -> Presentation -> ( Presentation, Cmd Msg )
update msg presentation =
    case msg of
        TimeUpdate dt ->
            ( timeUpdate dt presentation, Cmd.none )

        KeyDown key ->
            ( keyDown key presentation, Cmd.none )

        Next ->
            ( next presentation, Cmd.none )

        Previous ->
            ( prev presentation, Cmd.none )


prev : Presentation -> Presentation
prev presentation =
    let
        slidesLength =
            length presentation.slides
    in
    case presentation.position of
        At n ->
            if n > 0 then
                { presentation | position = Backward n (n - 1) 0.0 }

            else
                presentation

        Backward a b progress ->
            { presentation | position = Backward a (clamp 0 slidesLength (b - 1)) progress }

        Forward from to progress ->
            { presentation | position = Backward to from (1.0 - progress) }


next : Presentation -> Presentation
next presentation =
    let
        slidesLength =
            length presentation.slides
    in
    case presentation.position of
        At n ->
            if n + 1 < slidesLength then
                { presentation | position = Forward n (n + 1) 0.0 }

            else
                presentation

        Forward a b progress ->
            { presentation | position = Forward a (clamp 0 (slidesLength - 1) (b + 1)) progress }

        Backward from to progress ->
            { presentation | position = Forward to from (1.0 - progress) }


timeUpdate : Float -> Presentation -> Presentation
timeUpdate time presentation =
    let
        ds =
            0.002 * time
    in
    case presentation.position of
        At n ->
            presentation

        Forward from to progress ->
            let
                newProgress =
                    progress + ds
            in
            if newProgress > 1.0 then
                { presentation | position = At to }

            else
                { presentation | position = Forward from to newProgress }

        Backward from to progress ->
            let
                newProgress =
                    progress + ds
            in
            if newProgress > 1.0 then
                { presentation | position = At to }

            else
                { presentation | position = Backward from to newProgress }


keyDown : RawKey -> Presentation -> Presentation
keyDown key presentation =
    case Keyboard.rawValue key of
        "ArrowLeft" ->
            prev presentation

        "ArrowRight" ->
            next presentation

        "Escape" ->
            { presentation | position = At 0 }

        _ ->
            presentation
