module Results exposing (..)

import Models exposing (..)
import Http exposing (..)
import Json.Decode as Json


getHotelsData : Cmd Msg
getHotelsData =
    Http.send SetHotelResults getHotelsRequest


getHotelsRequest : Http.Request HotelsResponse
getHotelsRequest =
    Http.get "data/hotels.json" hotelsDecoder


hotelsDecoder : Json.Decoder HotelsResponse
hotelsDecoder =
    Json.field "Establishments" (Json.list mapEstablishments)


mapEstablishments : Json.Decoder Hotel
mapEstablishments =
    Json.map3 Hotel
        (Json.field "Distance" Json.float)
        (Json.field "Name" Json.string)
        (Json.field "ImageUrl" Json.string)
