module Models exposing (..)

import Http exposing (..)


type alias Model =
    { hotels : HotelsList
    , filters : FilterCriteria
    , sortBy : SortCriteria
    }


type Msg
    = SetHotelResults (Result Http.Error HotelsList)
    | SetFilters (FilterCriteria -> FilterCriteria)
    | SetSortBy SortCriteria


type alias Hotel =
    { distance : Float
    , name : String
    , stars : Float
    , rating : Float
    , minPrice : Float
    , imageUrl : String
    }


type alias HotelsList =
    List Hotel


type alias FilterCriteria =
    { distance : Float
    , name : String
    , stars : Float
    , rating : Float
    , minPrice : Float
    }


type SortCriteria
    = Distance
    | Name
    | Stars
    | Rating
    | MinPrice
