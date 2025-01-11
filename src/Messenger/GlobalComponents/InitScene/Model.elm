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
    {}


type alias Data =
    {}


init : InitOption -> GlobalComponentInit userdata scenemsg Data
init opt _ _ =
    ( {}
    , { dead = False
      , postProcessor = identity
      }
    )


update : GlobalComponentUpdate userdata scenemsg Data
update env _ data bdata =
    let
        dead =
            loadedResourceNum env.globalData == env.globalData.internalData.totResNum
    in
    ( ( data, { bdata | dead = dead } ), [], ( env, False ) )


updaterec : GlobalComponentUpdateRec userdata scenemsg Data
updaterec env _ data bdata =
    ( ( data, bdata ), [], env )


view : GlobalComponentView userdata scenemsg Data
view env data _ =
    REGL.group []
        (P.clear Color.black
            :: List.map
                (\i ->
                    let
                        x =
                            15 * cos ((pi / 4) * toFloat i)

                        y =
                             15 * sin ((pi / 4) * toFloat i)
                    in
                    P.circle ( 30 + x, env.globalData.internalData.virtualHeight - 30 + y ) (2 + sin (env.globalData.globalStartTime * 0.005 + 2 * pi * toFloat i / 8)) Color.white
                )
                (List.range 0 7)
        )


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
genGC : Maybe GCTarget -> GlobalComponentStorage userdata scenemsg
genGC =
    genGlobalComponent (gcCon {}) E.null
