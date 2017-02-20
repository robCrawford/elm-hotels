module Models exposing (..)

import Http exposing (..)


type alias Model =
    { firstName : String
    , lastName : String
    , imgUrl : String
    , hotels : HotelsResponse
    }


type Msg
    = FirstName String
    | LastName String
    | Logo String
    | FetchHotels (Result Http.Error HotelsResponse)


type alias Hotel =
    { name : String
    , imageUrl : String
    }


type alias HotelsResponse =
    List Hotel
