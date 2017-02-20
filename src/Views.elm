module Views exposing (..)

import Models exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


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
                    [ h2 []
                        [ text "HOTELS" ]
                    ]
                , div [ class "hotelFilter clearfix" ]
                    [ div [ class "pull-right" ]
                        [ sortUI
                        ]
                    ]
                , div [ class "row hotelProduct xsResponse clearfix", id "results" ]
                    (List.map hotelDetails (filterResults model.hotels))
                , pagingUI
                ]
            ]
        ]


filterResults : HotelsResponse -> HotelsResponse
filterResults results =
    List.take 9 results


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
                        [ text "Distance"
                        , input [ id "filter-distance" ]
                            []
                        ]
                    , li []
                        [ text "Name"
                        , input [ id "filter-name" ]
                            []
                        ]
                    , li []
                        [ text "Stars"
                        , input [ id "filter-stars" ]
                            []
                        ]
                    , li []
                        [ text "Rating"
                        , input [ id "filter-rating" ]
                            []
                        ]
                    , li []
                        [ text "Minimum price"
                        , input [ id "filter-price" ]
                            []
                        ]
                    ]
                , div []
                    [ a [ class "btn btn-primary" ]
                        [ text "Update" ]
                    ]
                ]
            ]
        ]


sortUI : Html Msg
sortUI =
    div [ class "change-order pull-right" ]
        [ select [ class "form-control", id "update-sort" ]
            [ option [ value "distance-asc" ]
                [ text "Sort by distance" ]
            , option [ value "name-asc" ]
                [ text "Sort by name" ]
            , option [ value "stars-desc" ]
                [ text "Sort by stars: high to low" ]
            , option [ value "stars-asc" ]
                [ text "Sort by stars: low to high" ]
            , option [ value "rating-desc" ]
                [ text "Sort by rating: high to low" ]
            , option [ value "rating-asc" ]
                [ text "Sort by rating: low to high" ]
            , option [ value "price-desc" ]
                [ text "Sort by price: high to low" ]
            , option [ value "price-asc" ]
                [ text "Sort by price: low to high" ]
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


hotelDetails : Hotel -> Html Msg
hotelDetails hotel =
    div [ class "item col-sm-4 col-lg-4 col-md-4 col-xs-6" ]
        [ div [ class "product" ]
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
                [ li [ class "hotel-title" ]
                    [ (text hotel.name)
                    ]
                ]
            , div []
                [ a [ class "btn btn-primary" ] [ text "More info" ]
                ]
            ]
        ]
