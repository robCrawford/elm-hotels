module View exposing (..)

import Models exposing (..)
import Filter exposing (..)
import Sort exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


getHotelsHtml : Model -> List (Html Msg)
getHotelsHtml model =
    applyFilters model.filterCriteria model.hotels
        |> sortHotels model.sortCriteria
        |> List.take 9
        |> List.map hotelDetailsHtml


page : Model -> Html Msg
page model =
    div [ class "container main-container" ]
        [ div [ class "row" ]
            [ header
            ]
        , div [ class "row" ]
            [ div [ class "col-lg-3 col-md-3 col-sm-12" ]
                [ filterUI
                ]
            , div [ class "col-lg-9 col-md-9 col-sm-12" ]
                [ div [ class "clearfix hotel-header" ]
                    [ h2 [] [ text "HOTELS" ]
                    ]
                , div [ class "clearfix" ]
                    [ div [ class "pull-right" ]
                        [ sortUI
                        ]
                    ]
                , div [ class "row hotel-results xsResponse clearfix", id "results" ]
                    (getHotelsHtml model)
                , pagingUI
                ]
            ]
        ]


header : Html Msg
header =
    div [ class "col-lg-12" ]
        [ ul [ class "breadcrumb" ]
            [ li []
                [ a [ href "index.html" ]
                    [ text "Home" ]
                ]
            , li [ class "active" ]
                [ text "HOTELS" ]
            ]
        ]


filterUI : Html Msg
filterUI =
    div [ class "panel-group" ]
        [ div [ class "panel panel-default" ]
            [ div [ class "panel-heading" ]
                [ h4 [ class "panel-title" ]
                    [ text "Filters" ]
                ]
            , div [ class "panel-body" ]
                [ ul [ class "filters" ]
                    [ li []
                        [ text "Within Distance"
                        , input [ onInput setDistanceFilter ] []
                        ]
                    , li []
                        [ text "Name"
                        , input [ onInput setNameFilter ] []
                        ]
                    , li []
                        [ text "Star Rating"
                        , input [ onInput setStarsFilter ] []
                        ]
                    , li []
                        [ text "Minimum User Rating"
                        , input [ onInput setRatingFilter ] []
                        ]
                    , li []
                        [ text "Minimum Price"
                        , input [ onInput setMinPriceFilter ] []
                        ]
                    ]
                ]
            ]
        ]


sortUI : Html Msg
sortUI =
    div [ class "change-order pull-right" ]
        [ select
            [ class "form-control"
            , onInput setSortBy
            ]
            [ option [ value "distance" ]
                [ text "Sort by distance" ]
            , option [ value "name" ]
                [ text "Sort by name" ]
            , option [ value "stars" ]
                [ text "Sort by stars" ]
            , option [ value "rating" ]
                [ text "Sort by rating" ]
            , option [ value "minPrice" ]
                [ text "Sort by minPrice" ]
            ]
        ]


pagingUI : Html Msg
pagingUI =
    div [ class "pagination pull-right no-margin-top" ]
        [ ul [ class "pagination no-margin-top" ]
            [ li [] [ a [] [ text "«" ] ]
            , li [ class "active" ] [ a [] [ text "1" ] ]
            , li [] [ a [] [ text "2" ] ]
            , li [] [ a [] [ text "3" ] ]
            , li [] [ a [] [ text "4" ] ]
            , li [] [ a [] [ text "5" ] ]
            , li [] [ a [] [ text "»" ] ]
            ]
        ]


hotelDetailsHtml : Hotel -> Html Msg
hotelDetailsHtml hotel =
    div [ class "item col-sm-4 col-lg-4 col-md-4 col-xs-6" ]
        [ div [ class "hotel-details" ]
            [ div [ class "image" ]
                [ img
                    [ src hotel.imageUrl
                    , class "img-responsive"
                    ]
                    []
                ]
            ]
        , div [ class "description" ]
            [ ul []
                [ li [ class "hotel-title" ] [ (text hotel.name) ]
                , li [] [ (text ("Distance: " ++ getDistanceString hotel.distance)) ]
                , li [] [ (text ("Star rating: " ++ (toString hotel.stars))) ]
                , li [] [ (text ("User rating: " ++ (toString hotel.rating))) ]
                , li [] [ (text ("From: £" ++ (toString hotel.minPrice))) ]
                ]
              -- , div []
              --     [ a [ class "btn btn-primary" ] [ text "More info" ]
              --     ]
            ]
        ]


getDistanceString : Float -> String
getDistanceString distance =
    (distance * 10 |> round |> toFloat)
        / 10
        |> toString
