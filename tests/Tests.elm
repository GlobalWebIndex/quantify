module Tests exposing (..)

import Dict exposing (Dict)
import Expect
import Quantify exposing (Quantifier(..))
import Set exposing (Set)
import Test exposing (..)


isEven : Int -> Bool
isEven number =
    number % 2 == 0


testList : Test
testList =
    describe "Quantify.list"
        [ test "Empty list returns None" <|
            \() ->
                Quantify.list isEven []
                    |> Expect.equal None
        , test "None" <|
            \() ->
                Quantify.list isEven [ 1, 3, 5, 7 ]
                    |> Expect.equal None
        , test "Some" <|
            \() ->
                Quantify.list isEven [ 0, 1, 2, 3 ]
                    |> Expect.equal Some
        , test "All" <|
            \() ->
                Quantify.list isEven [ 0, 2, 4, 6 ]
                    |> Expect.equal All
        ]


testSet : Test
testSet =
    describe "Quantify.set"
        [ test "Empty set returns None" <|
            \() ->
                Quantify.set isEven Set.empty
                    |> Expect.equal None
        , test "None" <|
            \() ->
                Quantify.set isEven (Set.fromList [ 1, 3, 5, 7 ])
                    |> Expect.equal None
        , test "Some" <|
            \() ->
                Quantify.set isEven (Set.fromList [ 0, 1, 2, 3 ])
                    |> Expect.equal Some
        , test "All" <|
            \() ->
                Quantify.set isEven (Set.fromList [ 0, 2, 4, 6 ])
                    |> Expect.equal All
        ]


isEvenValue : comparable -> Int -> Bool
isEvenValue _ number =
    isEven number


testDict : Test
testDict =
    describe "Quantify.dict"
        [ test "Empty dict returns None" <|
            \() ->
                Quantify.dict isEvenValue Dict.empty
                    |> Expect.equal None
        , test "None" <|
            \() ->
                Quantify.dict isEvenValue (Dict.fromList [ ( 0, 1 ), ( 1, 3 ), ( 2, 5 ), ( 3, 7 ) ])
                    |> Expect.equal None
        , test "Some" <|
            \() ->
                Quantify.dict isEvenValue (Dict.fromList [ ( 0, 0 ), ( 1, 1 ), ( 2, 2 ), ( 3, 3 ) ])
                    |> Expect.equal Some
        , test "All" <|
            \() ->
                Quantify.dict isEvenValue (Dict.fromList [ ( 0, 0 ), ( 1, 2 ), ( 2, 4 ), ( 3, 6 ) ])
                    |> Expect.equal All
        ]


testSingle : Test
testSingle =
    describe "Quantify.single"
        [ test "True -> All" <|
            \() ->
                Quantify.single isEven 0
                    |> Expect.equal All
        , test "False -> None" <|
            \() ->
                Quantify.single isEven 1
                    |> Expect.equal None
        ]
