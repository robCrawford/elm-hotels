module Models exposing (..)

import Http exposing (..)


type alias Model =
    { hotels : HotelsList
    , filterCriteria : FilterCriteria
    , sortCriteria : SortCriteria
    , pageIndex : Int
    }


type
    Msg
    -- All `Msg` types are handled by the `update` function
    = SetHotelResults (Result Http.Error HotelsList)
    | SetFilters (FilterCriteria -> FilterCriteria)
    | SetSortBy SortCriteria
    | PageNext
    | PagePrevious


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
