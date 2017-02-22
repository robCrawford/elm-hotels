module Sort exposing (..)

import Models exposing (..)


sortHotels : SortCriteria -> HotelsList -> HotelsList
sortHotels sortCriteria =
    case sortCriteria of
        Distance ->
            List.sortBy .distance

        Name ->
            List.sortBy .name

        Stars ->
            List.sortBy .stars

        Rating ->
            List.sortBy .rating

        MinPrice ->
            List.sortBy .minPrice


setSortBy : String -> Msg
setSortBy value =
    case value of
        "distance" ->
            SetSortBy Distance

        "name" ->
            SetSortBy Name

        "stars" ->
            SetSortBy Stars

        "rating" ->
            SetSortBy Rating

        "minPrice" ->
            SetSortBy MinPrice

        _ ->
            SetSortBy Distance
