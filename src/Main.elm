module Main exposing (..)

import Models exposing (..)
import Results exposing (..)
import Views exposing (..)
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
    , filters = FilterCriteria 10 "" 0 3 0
    , sortBy = Distance
    }


init : ( Model, Cmd Msg )
init =
    ( model
    , getHotelsData
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetHotelResults (Ok hotels) ->
            ( { model | hotels = hotels }, Cmd.none )

        SetHotelResults (Err _) ->
            ( model, Cmd.none )

        SetFilters updateFn ->
            ( { model | filters = updateFn model.filters }, Cmd.none )

        SetSortBy sortCriteria ->
            ( { model | sortBy = sortCriteria }, Cmd.none )


view : Model -> Html Msg
view model =
    Views.page model


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
