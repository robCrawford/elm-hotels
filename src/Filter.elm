module Filter exposing (..)

import Models exposing (..)
import String exposing (..)
import Regex exposing (..)


filterResults : HotelsList -> FilterCriteria -> HotelsList
filterResults results filterCriteria =
    results
        |> filterByName filterCriteria.name
        |> filterByDistance filterCriteria.distance
        |> filterByStars filterCriteria.stars
        |> filterByRating filterCriteria.rating
        |> filterByPrice filterCriteria.minPrice


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


setDistanceFilter : String -> Msg
setDistanceFilter value =
    SetFilters (\filterCriteria -> { filterCriteria | distance = validateFloatInput value 0 100 })


setNameFilter : String -> Msg
setNameFilter value =
    SetFilters (\filterCriteria -> { filterCriteria | name = value })


setStarsFilter : String -> Msg
setStarsFilter value =
    SetFilters (\filterCriteria -> { filterCriteria | stars = validateFloatInput value 0 5 })


setRatingFilter : String -> Msg
setRatingFilter value =
    SetFilters (\filterCriteria -> { filterCriteria | rating = validateFloatInput value 0 10 })


setMinPriceFilter : String -> Msg
setMinPriceFilter value =
    SetFilters (\filterCriteria -> { filterCriteria | minPrice = validateFloatInput value 0 100000 })
