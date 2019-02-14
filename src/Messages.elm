module Messages exposing (Msg(..))

import Keyboard exposing (RawKey)


type Msg
    = TimeUpdate Float
    | KeyDown RawKey
    | Next
    | Previous
    | ToggleCode
