module Filters exposing (..)

import Models exposing (..)
import String exposing (..)
import Regex exposing (..)


filterResults : HotelsList -> FilterCriteria -> HotelsList
filterResults results filters =
    results
        |> filterByName filters.name
        |> filterByDistance filters.distance
        |> filterByStars filters.stars
        |> filterByRating filters.rating
        |> filterByPrice filters.minPrice


filterByName : String -> HotelsList -> HotelsList
filterByName name hotels =
    List.filter (\h -> Regex.contains (caseInsensitive (regex name)) h.name) hotels


filterByDistance : Float -> HotelsList -> HotelsList
filterByDistance distance hotels =
    List.filter (\h -> h.distance <= distance || distance == 0) hotels


filterByStars : Float -> HotelsList -> HotelsList
filterByStars stars hotels =
    List.filter (\h -> h.stars == stars || stars == 0) hotels


filterByRating : Float -> HotelsList -> HotelsList
filterByRating rating hotels =
    List.filter (\h -> h.rating >= rating || rating == 0) hotels


filterByPrice : Float -> HotelsList -> HotelsList
filterByPrice minPrice hotels =
    List.filter (\h -> h.minPrice >= minPrice || minPrice == 0) hotels


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
