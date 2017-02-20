module Results exposing (..)

import Models exposing (..)
import Http exposing (..)
import Json.Decode as Json


getHotelsData : Cmd Msg
getHotelsData =
    --        (Result Error a -> msg) -> Request a -> Cmd msg
    Http.send FetchHotels getHotelsRequest


getHotelsRequest : Http.Request HotelsResponse
getHotelsRequest =
    --       String -> Decoder a -> Request a
    Http.get "data/hotels.json" hotelsDecoder


hotelsDecoder : Json.Decoder HotelsResponse
hotelsDecoder =
    --         String -> Decoder a -> Decoder a
    Json.field "Establishments" (Json.list mapEstablishments)


mapEstablishments : Json.Decoder Hotel
mapEstablishments =
    --       (a -> value) -> Decoder a -> Decoder value
    Json.map2 Hotel
        (Json.field "Name" Json.string)
        (Json.field "ImageUrl" Json.string)
