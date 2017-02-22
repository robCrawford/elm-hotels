module Sort exposing (..)

import Models exposing (..)


sortHotels : SortCriteria -> HotelsList -> HotelsList
sortHotels sortCriteria results =
    case sortCriteria of
        Distance ->
            List.sortBy .distance results

        Name ->
            List.sortBy .name results

        Stars ->
            List.sortBy .stars results

        Rating ->
            List.sortBy .rating results

        MinPrice ->
            List.sortBy .minPrice results


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
