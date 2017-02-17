module Hotels exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String
import Http
import Json.Decode as Json


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
    div []
        [ input [ placeholder "First Name", onInput FirstName ] []
        , input [ placeholder "Last Name", onInput LastName ] []
        , button [ onClick (Logo "img/logo.png") ] [ text "Load logo" ]
        , div [] [ text (String.concat [ model.firstName, model.lastName ]) ]
        , img [ src model.imgUrl ] []
        , br [] []
        , br [] []
        , div [] [ text (toString model.hotels) ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HTTP


getHotelsData : Cmd Msg
getHotelsData =
    Http.send FetchHotels getHotelsRequest


getHotelsRequest : Http.Request HotelsResponse
getHotelsRequest =
    Http.get "data/hotels.json" hotelsDecoder


hotelsDecoder : Json.Decoder HotelsResponse
hotelsDecoder =
    Json.field "Establishments" (Json.list mapEstablishments)


mapEstablishments : Json.Decoder Hotel
mapEstablishments =
    Json.map Hotel (Json.field "Name" Json.string)
