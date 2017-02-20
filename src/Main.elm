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
    }


init : ( Model, Cmd Msg )
init =
    ( model
    , getHotelsData
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchHotels (Ok hotels) ->
            ( { model | hotels = hotels }, Cmd.none )

        FetchHotels (Err _) ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    Views.page model


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
