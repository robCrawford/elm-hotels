module Hotels exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String
import Http
import Json.Decode as Json


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Hotel =
    { name : String
    , imageUrl : String
    }


type alias HotelsResponse =
    List Hotel


type alias Model =
    { firstName : String
    , lastName : String
    , imgUrl : String
    , hotels : HotelsResponse
    }


init : ( Model, Cmd Msg )
init =
    ( Model "" "" "img/generic.png" []
    , getHotelsData
    )


model : Model
model =
    { firstName = ""
    , lastName = ""
    , imgUrl = ""
    , hotels = []
    }



-- UPDATE


type Msg
    = FirstName String
    | LastName String
    | Logo String
      --          (Result Error a -> msg)
    | FetchHotels (Result Http.Error HotelsResponse)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FirstName val ->
            ( { model | firstName = val }, Cmd.none )

        LastName val ->
            ( { model | lastName = val }, Cmd.none )

        Logo val ->
            ( { model | imgUrl = val }, Cmd.none )

        FetchHotels (Ok hotels) ->
            ( { model | hotels = hotels }, Cmd.none )

        FetchHotels (Err _) ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    -- div [ class "container main-container" ]
    --     [ div
    --         [ class "row" ]
    --         [ input [ placeholder "First Name", onInput FirstName ] []
    --         , input [ placeholder "Last Name", onInput LastName ] []
    --         , button [ onClick (Logo "img/logo.png") ] [ text "Load logo" ]
    --         , div [] [ text (String.concat [ model.firstName, model.lastName ]) ]
    --         , img [ src model.imgUrl ] []
    --         , div
    --             [ id "results"
    --             , class "row hotelProduct xsResponse clearfix"
    --             ]
    --             (List.map hotelView model.hotels)
    --         ]
    --     ]
    div [ class "container main-container" ]
        [ div [ class "row" ]
            [ div [ class "col-lg-12" ]
                [ ul [ class "breadcrumb" ]
                    [ li []
                        [ a [ href "index.html" ]
                            [ text "Home" ]
                        ]
                    , li [ class "active" ]
                        [ text "HOTELS" ]
                    ]
                ]
            ]
        , div [ class "row" ]
            [ div [ class "col-lg-3 col-md-3 col-sm-12" ]
                [ div [ class "panel-group" ]
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
                ]
            , div [ class "col-lg-9 col-md-9 col-sm-12" ]
                [ div [ class "clearfix hotel-header" ]
                    [ h2 []
                        [ text "HOTELS" ]
                    ]
                , div [ class "hotelFilter clearfix" ]
                    [ div [ class "pull-right" ]
                        [ div [ class "change-order pull-right" ]
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
                        , div [ class "change-view pull-right" ]
                            [ a [ title "Grid", class "grid-view" ]
                                [ i [ class "fa fa-th-large" ] [] ]
                            , a [ title "List", class "list-view " ]
                                [ i [ class "fa fa-th-list" ] [] ]
                            ]
                        ]
                    ]
                , div [ class "row hotelProduct xsResponse clearfix", id "results" ]
                    (List.map hotelView model.hotels)
                , div [ class "pagination pull-right no-margin-top" ]
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
                ]
            ]
        ]


hotelView : Hotel -> Html Msg
hotelView hotel =
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



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HTTP


getHotelsData : Cmd Msg
getHotelsData =
    --        (Result Error a -> msg) -> Request a -> Cmd msg
    Http.send FetchHotels getHotelsRequest


getHotelsRequest : Http.Request HotelsResponse
getHotelsRequest =
    --       String -> Decoder a -> Request a
    Http.get "data/hotels.json" hotelsDecoder


hotelsDecoder : Json.Decoder HotelsResponse
hotelsDecoder =
    --         String -> Decoder a -> Decoder a
    Json.field "Establishments" (Json.list mapEstablishments)


mapEstablishments : Json.Decoder Hotel
mapEstablishments =
    --       (a -> value) -> Decoder a -> Decoder value
    Json.map2 Hotel
        (Json.field "Name" Json.string)
        (Json.field "ImageUrl" Json.string)
