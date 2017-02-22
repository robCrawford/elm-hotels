module Filters exposing (..)

import Models exposing (..)
import String exposing (..)
import Regex exposing (..)


filterResults : HotelsResponse -> FilterCriteria -> HotelsResponse
filterResults results filters =
    results
        |> filterByName filters.name
        |> filterByDistance filters.distance
        |> List.take 9


filterByName : String -> HotelsResponse -> HotelsResponse
filterByName name hotels =
    List.filter (\h -> Regex.contains (caseInsensitive (regex name)) h.name) hotels


filterByDistance : Float -> HotelsResponse -> HotelsResponse
filterByDistance distance hotels =
    List.filter (\h -> h.distance < distance) hotels


validateFloatInput : String -> Float -> Float -> Float
validateFloatInput inputStr min max =
    case String.toFloat inputStr of
        Err msg ->
            0

        Ok value ->
            if value < min then
                0
            else if value > max then
                max
            else
                value


updateDistanceFilter : String -> Msg
updateDistanceFilter value =
    SetFilters (\filters -> { filters | distance = validateFloatInput value 0 100 })


updateNameFilter : String -> Msg
updateNameFilter value =
    SetFilters (\filters -> { filters | name = value })


updateStarsFilter : String -> Msg
updateStarsFilter value =
    SetFilters (\filters -> { filters | stars = validateFloatInput value 0 5 })


updateRatingFilter : String -> Msg
updateRatingFilter value =
    SetFilters (\filters -> { filters | rating = validateFloatInput value 0 10 })


updateMinPriceFilter : String -> Msg
updateMinPriceFilter value =
    SetFilters (\filters -> { filters | minPrice = validateFloatInput value 0 100000 })
