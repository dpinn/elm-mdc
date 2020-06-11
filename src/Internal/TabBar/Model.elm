module Internal.TabBar.Model exposing
    ( Geometry
    , Model
    , Msg(..)
    , Tab
    , defaultGeometry
    , defaultModel
    )

import Dict exposing (Dict)
import Internal.Ripple.Model as Ripple
import Internal.Keyboard as Keyboard exposing (Meta, Key, KeyCode)


type alias Model =
    { geometry : Maybe Geometry
    , translateOffset : Float
    , ripples : Dict Int Ripple.Model
    , activeTab : Int
    , focusedTab : Maybe Int
    }


defaultModel : Model
defaultModel =
    { geometry = Nothing
    , translateOffset = 0
    , ripples = Dict.empty
    , activeTab = 0
    , focusedTab = Nothing
    }


type Msg m
    = NoOp
    | Dispatch (List m)
    | RippleMsg Int Ripple.Msg
    | Init Geometry
    | SetActiveTab String Int Float
    | FocusTab String Int
    | ResetFocusedTab
    | Left String Int
    | Right String Int
    | SelectTab (Int -> m) Int


type alias Tab =
    { offsetLeft : Float
    , offsetWidth : Float
    , contentLeft : Float
    , contentRight : Float
    }


type alias Geometry =
    { tabs : List Tab
    , scrollContent : { offsetWidth : Float }
    , tabBar : { offsetWidth : Float }
    }


defaultGeometry : Geometry
defaultGeometry =
    { tabs = []
    , scrollContent = { offsetWidth = 0 }
    , tabBar = { offsetWidth = 0 }
    }
