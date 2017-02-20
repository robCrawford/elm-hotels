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



-- MODEL


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
    Views.page model



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
