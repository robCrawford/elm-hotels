module Request exposing (..)

import Models exposing (..)
import Http exposing (..)
import Json.Decode as Json


fetchHotels : Cmd Msg
fetchHotels =
    Http.send SetHotelResults getHotelsRequest


getHotelsRequest : Http.Request HotelsList
getHotelsRequest =
    Http.get "data/hotels.json" decodeHotelsJson


decodeHotelsJson : Json.Decoder HotelsList
decodeHotelsJson =
    Json.field "Establishments" (Json.list mapHotels)


mapHotels : Json.Decoder Hotel
mapHotels =
    Json.map6 Hotel
        (Json.field "Distance" Json.float)
        (Json.field "Name" Json.string)
        (Json.field "Stars" Json.float)
        (Json.field "UserRating" Json.float)
        (Json.field "MinCost" Json.float)
        (Json.field "ImageUrl" Json.string)
