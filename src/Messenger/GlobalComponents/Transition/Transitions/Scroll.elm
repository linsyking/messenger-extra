module Messenger.GlobalComponents.Transition.Transitions.Scroll exposing
    ( scrollIn, scrollOut
    , scrollOutWithRenderable, scrollInWithRenderable
    )

{-| Scroll Transition

@docs scrollIn, scrollOut
@docs scrollOutWithRenderable, scrollInWithRenderable

-}

import Canvas exposing (Renderable, group, shapes)
import Canvas.Settings exposing (fill)
import Canvas.Settings.Advanced exposing (GlobalCompositeOperationMode(..), compositeOperationMode, fillLinear, reverseOrder)
import Color exposing (Color)
import Messenger.Coordinate.Coordinates exposing (lengthToReal)
import Messenger.GlobalComponents.Transition.Transitions.Base exposing (SingleTrans)
import Messenger.Render.Shape exposing (rect)


{-| Scroll Out
-}
scrollOut : Color -> SingleTrans
scrollOut col gd rd v =
    group []
        [ rd
        , shapes
            [ fillLinear { x0 = 0, y0 = 0, x1 = lengthToReal gd gd.virtualWidth, y1 = 0 }
                [ ( 0, Color.rgba 0 0 0 0 )
                , ( if 0.95 - v >= 0 then
                        0.95 - v

                    else
                        0
                  , Color.rgba 0 0 0 0
                  )
                , ( 1 - v, Color.rgba 0 0 0 1 )
                , ( 1, Color.rgba 0 0 0 1 )
                ]
            , compositeOperationMode DestinationOut
            ]
            [ rect gd ( 0, 0 ) ( gd.virtualWidth, gd.virtualHeight )
            ]
        , shapes
            [ fill col, compositeOperationMode DestinationOver ]
            [ rect gd ( 0, 0 ) ( gd.virtualWidth, gd.virtualHeight )
            ]
        ]


{-| Scroll In
-}
scrollIn : Color -> SingleTrans
scrollIn col gd rd v =
    group []
        [ rd
        , shapes
            [ fillLinear { x0 = 0, y0 = 0, x1 = lengthToReal gd gd.virtualWidth, y1 = 0 }
                [ ( 0, Color.rgba 0 0 0 1 )
                , ( if v >= 0.95 then
                        0

                    else
                        0.95 - v
                  , Color.rgba 0 0 0 1
                  )
                , ( 1 - v, Color.rgba 0 0 0 0 )
                , ( 1, Color.rgba 0 0 0 0 )
                ]
            , compositeOperationMode DestinationOut
            ]
            [ rect gd ( 0, 0 ) ( gd.virtualWidth, gd.virtualHeight )
            ]
        , shapes
            [ fill col, compositeOperationMode DestinationOver ]
            [ rect gd ( 0, 0 ) ( gd.virtualWidth, gd.virtualHeight )
            ]
        ]


{-| Scroll Out with Renderable
-}
scrollOutWithRenderable : Renderable -> SingleTrans
scrollOutWithRenderable tord gd rd v =
    group []
        [ rd
        , shapes
            [ fillLinear { x0 = 0, y0 = 0, x1 = lengthToReal gd gd.virtualWidth, y1 = 0 }
                [ ( 0, Color.rgba 0 0 0 0 )
                , ( if 0.95 - v >= 0 then
                        0.95 - v

                    else
                        0
                  , Color.rgba 0 0 0 0
                  )
                , ( 1 - v, Color.rgba 0 0 0 1 )
                , ( 1, Color.rgba 0 0 0 1 )
                ]
            , compositeOperationMode DestinationOut
            ]
            [ rect gd ( 0, 0 ) ( gd.virtualWidth, gd.virtualHeight )
            ]
        , group
            [ compositeOperationMode DestinationOver, reverseOrder ]
            [ tord
            ]
        ]


{-| Scroll In with Renderable
-}
scrollInWithRenderable : Renderable -> SingleTrans
scrollInWithRenderable tord gd rd v =
    group []
        [ rd
        , shapes
            [ fillLinear { x0 = 0, y0 = 0, x1 = lengthToReal gd gd.virtualWidth, y1 = 0 }
                [ ( 0, Color.rgba 0 0 0 1 )
                , ( if v >= 0.95 then
                        0

                    else
                        0.95 - v
                  , Color.rgba 0 0 0 1
                  )
                , ( 1 - v, Color.rgba 0 0 0 0 )
                , ( 1, Color.rgba 0 0 0 0 )
                ]
            , compositeOperationMode DestinationOut
            ]
            [ rect gd ( 0, 0 ) ( gd.virtualWidth, gd.virtualHeight )
            ]
        , group
            [ compositeOperationMode DestinationOver, reverseOrder ]
            [ tord
            ]
        ]
