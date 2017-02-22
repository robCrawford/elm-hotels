module Models exposing (..)

import Http exposing (..)


type alias Model =
    { hotels : HotelsResponse
    , filters : FilterCriteria
    }


type Msg
    = SetHotelResults (Result Http.Error HotelsResponse)
    | SetFilters (FilterCriteria -> FilterCriteria)


type alias Hotel =
    { distance : Float
    , name : String
    , stars : Float
    , rating : Float
    , minPrice : Float
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
