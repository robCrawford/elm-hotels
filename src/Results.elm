module Results exposing (..)

import Models exposing (..)
import Http exposing (..)
import Json.Decode as Json


getHotelsData : Cmd Msg
getHotelsData =
    Http.send SetHotelResults getHotelsRequest


getHotelsRequest : Http.Request HotelsList
getHotelsRequest =
    Http.get "data/hotels.json" hotelsDecoder


hotelsDecoder : Json.Decoder HotelsList
hotelsDecoder =
    Json.field "Establishments" (Json.list mapEstablishments)


mapEstablishments : Json.Decoder Hotel
mapEstablishments =
    Json.map6 Hotel
        (Json.field "Distance" Json.float)
        (Json.field "Name" Json.string)
        (Json.field "Stars" Json.float)
        (Json.field "UserRating" Json.float)
        (Json.field "MinCost" Json.float)
        (Json.field "ImageUrl" Json.string)
