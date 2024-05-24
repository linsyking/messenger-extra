module Messenger.Layer.LayerExtra exposing (BasicUpdater, Distributor)

{-|


# Layer extra features

@docs BasicUpdater, Distributor

-}

import Messenger.Base exposing (Env, UserEvent)
import Messenger.GeneralModel exposing (MMsg)


{-| Basic Update Type

A basic updater type used to update the basic data of the layer with event.

Users can use it as the first step of the update process

-}
type alias BasicUpdater data cdata userdata tar msg scenemsg =
    Env cdata userdata -> UserEvent -> data -> ( data, List (MMsg tar msg scenemsg userdata), ( Env cdata userdata, Bool ) )


{-| Distributor Type

A distributor is used to generate several list of Component Msgs for corresponding components list.

The `cmsgpacker` is a custom type to store the component msgs and their targets. Specifically, a `cmsgpacker` type should be
a record of different `List ( ComponentTarget, ComponentMsg )`.

-}
type alias Distributor data cdata userdata tar msg scenemsg cmsgpacker =
    Env cdata userdata -> UserEvent -> data -> ( data, ( List (MMsg tar msg scenemsg userdata), cmsgpacker ), Env cdata userdata )
