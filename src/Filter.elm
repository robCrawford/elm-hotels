module Filter exposing (..)

import Models exposing (..)
import Regex exposing (..)


getFilters : FilterCriteria -> HotelsList -> HotelsList
getFilters filterCriteria =
    -- This returns a function `HotelsList -> HotelsList`
    -- See http://stackoverflow.com/questions/27441648/what-does-the-operator-mean-in-elm
    filterByName filterCriteria.name
        >> filterByDistance filterCriteria.distance
        >> filterByStars filterCriteria.stars
        >> filterByRating filterCriteria.rating
        >> filterByMinPrice filterCriteria.minPrice


filterByName : String -> HotelsList -> HotelsList
filterByName name =
    List.filter (\h -> Regex.contains (caseInsensitive (regex name)) h.name)


filterByDistance : Float -> HotelsList -> HotelsList
filterByDistance distance =
    List.filter (\h -> h.distance <= distance || distance == 0)


filterByStars : Float -> HotelsList -> HotelsList
filterByStars stars =
    List.filter (\h -> h.stars == stars || stars == 0)


filterByRating : Float -> HotelsList -> HotelsList
filterByRating rating =
    List.filter (\h -> h.rating >= rating || rating == 0)


filterByMinPrice : Float -> HotelsList -> HotelsList
filterByMinPrice minPrice =
    List.filter (\h -> h.minPrice >= minPrice || minPrice == 0)


toFloatClamp : String -> Float -> Float -> Float
toFloatClamp inputStr min max =
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
    SetFilters (\filterCriteria -> { filterCriteria | distance = toFloatClamp value 0 100 })


setNameFilter : String -> Msg
setNameFilter value =
    SetFilters (\filterCriteria -> { filterCriteria | name = value })


setStarsFilter : String -> Msg
setStarsFilter value =
    SetFilters (\filterCriteria -> { filterCriteria | stars = toFloatClamp value 0 5 })


setRatingFilter : String -> Msg
setRatingFilter value =
    SetFilters (\filterCriteria -> { filterCriteria | rating = toFloatClamp value 0 10 })


setMinPriceFilter : String -> Msg
setMinPriceFilter value =
    SetFilters (\filterCriteria -> { filterCriteria | minPrice = toFloatClamp value 0 100000 })
