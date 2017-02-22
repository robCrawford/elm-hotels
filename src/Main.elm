module Main exposing (..)

import Models exposing (..)
import Request exposing (..)
import View exposing (..)
import Html exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


model : Model
model =
    { hotels = []
    , filterCriteria = FilterCriteria 10 "" 0 3 0
    , sortCriteria = Distance
    , pageIndex = 0
    }


init : ( Model, Cmd Msg )
init =
    ( model
    , Request.fetchHotels
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetHotelResults (Ok hotels) ->
            ( { model | hotels = hotels }, Cmd.none )

        SetHotelResults (Err _) ->
            ( model, Cmd.none )

        SetFilters updateFn ->
            ( { model
                | filterCriteria = updateFn model.filterCriteria
                , pageIndex = 0
              }
            , Cmd.none
            )

        SetSortBy sortCriteria ->
            ( { model | sortCriteria = sortCriteria }, Cmd.none )

        PageNext ->
            ( { model | pageIndex = model.pageIndex + 1 }, Cmd.none )

        PagePrevious ->
            ( { model | pageIndex = max (model.pageIndex - 1) 0 }, Cmd.none )


view : Model -> Html Msg
view model =
    View.page model


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
