module Models exposing (..)

import Http exposing (..)


type alias Model =
    { hotels : HotelsResponse
    , filters : FilterCriteria
    }


type Msg
    = FetchHotels (Result Http.Error HotelsResponse)


type alias Hotel =
    { name : String
    , imageUrl : String
    }


type alias HotelsResponse =
    List Hotel


type alias FilterCriteria =
    { distance : Float
    , name : String
    , stars : Float
    , rating : Float
    , minPrice : Float
    }
