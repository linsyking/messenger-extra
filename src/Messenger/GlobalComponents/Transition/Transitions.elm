module Messenger.GlobalComponents.Transition.Transitions exposing
    ( fadeIn, fadeInWithColor, fadeInWithRenderable, fadeOut, fadeOutWithColor, fadeOutWithRenderable
    , fadeMix, fadeImgMix
    , fadeOutImg, fadeInImg
    )

{-|


# Builtin Transitions

@docs fadeIn, fadeInWithColor, fadeInWithRenderable, fadeOut, fadeOutWithColor, fadeOutWithRenderable
@docs fadeMix, fadeImgMix
@docs fadeOutImg, fadeInImg

-}

import Color
import Messenger.GlobalComponents.Transition.Base exposing (DoubleTrans, SingleTrans)
import REGL
import REGL.BuiltinPrograms as P
import REGL.Compositors as Comp


{-| Fade out transition.
-}
fadeOut : SingleTrans
fadeOut r t =
    Comp.linearFade t r (P.clear Color.black)


{-| Fade in transition.
-}
fadeIn : SingleTrans
fadeIn r t =
    Comp.linearFade t (P.clear Color.black) r


{-| Fade out transition using mask image.
-}
fadeOutImg : String -> SingleTrans
fadeOutImg mask r t =
    Comp.imgFade mask t r (P.clear Color.black)


{-| Fade in transition using mask image.
-}
fadeInImg : String -> SingleTrans
fadeInImg mask r t =
    Comp.imgFade mask t (P.clear Color.black) r


{-| Fade out transition with a color.
-}
fadeOutWithColor : Color.Color -> SingleTrans
fadeOutWithColor c r t =
    Comp.linearFade t r (P.clear c)


{-| Fade in transition with a color.
-}
fadeInWithColor : Color.Color -> SingleTrans
fadeInWithColor c r t =
    Comp.linearFade t (P.clear c) r


{-| Fade out transition with a renderable.
-}
fadeOutWithRenderable : REGL.Renderable -> SingleTrans
fadeOutWithRenderable c r t =
    Comp.linearFade t r c


{-| Fade in transition with a renderable.
-}
fadeInWithRenderable : REGL.Renderable -> SingleTrans
fadeInWithRenderable c r t =
    Comp.linearFade t c r


{-| Fading transition used in mixed mode.
-}
fadeMix : DoubleTrans
fadeMix r1 r2 t =
    Comp.linearFade t r1 r2


{-| Fading transition based on mask image used in mixed mode.
-}
fadeImgMix : String -> DoubleTrans
fadeImgMix mask r1 r2 t =
    Comp.imgFade mask t r1 r2
