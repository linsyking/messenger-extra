module Messenger.GlobalComponents.InitScene.Model exposing (InitOption, genGC)

{-| Global component configuration module

A Global Component to show initial loading screen.

@docs InitOption, genGC

-}

import Color
import Json.Encode as E
import Messenger.Base exposing (UserEvent(..), loadedResourceNum)
import Messenger.Component.GlobalComponent exposing (genGlobalComponent)
import Messenger.Scene.Scene exposing (ConcreteGlobalComponent, GCTarget, GlobalComponentInit, GlobalComponentStorage, GlobalComponentUpdate, GlobalComponentUpdateRec, GlobalComponentView)
import REGL
import REGL.BuiltinPrograms as P


{-| Init Options
-}
type alias InitOption =
    { bgColor : Color.Color
    }


type alias Data =
    { bgColor : Color.Color
    }


init : InitOption -> GlobalComponentInit userdata scenemsg Data
init opt _ _ =
    ( { bgColor = opt.bgColor
      }
    , { dead = False
      , postProcessor = identity
      }
    )


update : GlobalComponentUpdate userdata scenemsg Data
update env _ data bdata =
    let
        dead =
            env.globalData.sceneStartFrame > 0
    in
    ( ( data, { bdata | dead = dead } ), [], ( env, False ) )


updaterec : GlobalComponentUpdateRec userdata scenemsg Data
updaterec env _ data bdata =
    ( ( data, bdata ), [], env )


view : GlobalComponentView userdata scenemsg Data
view env data _ =
    REGL.group []
        [ P.clear data.bgColor
        , P.textbox ( 0, env.globalData.internalData.virtualHeight ) 30 ("Loaded asset: " ++ String.fromInt (loadedResourceNum env.globalData)) "arial" Color.black
        ]


gcCon : InitOption -> ConcreteGlobalComponent Data userdata scenemsg
gcCon opt =
    { init = init opt
    , update = update
    , updaterec = updaterec
    , view = view
    , id = "initscene"
    }


{-| Generate a global component.
-}
genGC : InitOption -> Maybe GCTarget -> GlobalComponentStorage userdata scenemsg
genGC opt =
    genGlobalComponent (gcCon opt) E.null
