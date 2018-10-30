module Quantify exposing (Quantifier(..), dict, fromBool, list, set, single)

{-| Quantify list, set, dict or a single value according to a predicate


# Type

@docs Quantifier


# Quantify

@docs list, set, dict, single, fromBool

-}

import Dict exposing (Dict)
import Set exposing (Set)


{-| Quantifier type describes the result of the quantification.
-}
type Quantifier
    = None
    | Some
    | All


{-| Quantify a list according to a predicate.

    isEven : Int -> Bool
    isEven number =
        number % 2 == 0

    Quantify.list isEven [1,3,5,7]
    --> None

    Quantify.list isEven [0,1,2,3]
    --> Some

    Quantify.list isEven [0,2,4,6]
    --> All

    Quantify.list isEven []
    --> None

-}
list : (a -> Bool) -> List a -> Quantifier
list predicate xs =
    case xs of
        [] ->
            None

        x :: xs_ ->
            listHelper (single predicate x) predicate xs_


listHelper : Quantifier -> (a -> Bool) -> List a -> Quantifier
listHelper quantifierSoFar predicate list =
    case list of
        [] ->
            quantifierSoFar

        x :: xs ->
            case ( predicate x, quantifierSoFar ) of
                -- If no value matches so far or all match so far, we have to
                -- recurse to find whether some future value breaks the pattern.
                --
                -- In all other cases we know the result will be Some and we can
                -- bail out early!
                ( False, None ) ->
                    listHelper None predicate xs

                ( True, All ) ->
                    listHelper All predicate xs

                _ ->
                    Some


{-| Quantify a set according to a predicate.

    isEven : Int -> Bool
    isEven number =
        number % 2 == 0

    Quantify.set isEven (Set.fromList [1,3,5,7])
    --> None

    Quantify.set isEven (Set.fromList [0,1,2,3])
    --> Some

    Quantify.set isEven (Set.fromList [0,2,4,6])
    --> All

    Quantify.set isEven Set.empty
    --> None

-}
set : (comparable -> Bool) -> Set comparable -> Quantifier
set predicate xs =
    let
        ( satisfying, notSatisfying ) =
            Set.partition predicate xs
    in
    if Set.isEmpty satisfying then
        None
    else if Set.isEmpty notSatisfying then
        All
    else
        Some


{-| Quantify a dict according to a predicate. The predicate gets both the key and the value.

    isEven : Int -> Bool
    isEven number =
        number % 2 == 0

    Quantify.dict (\key value -> isEven value) (Dict.fromList [(0,1),(1,3),(2,5),(3,7)])
    --> None

    Quantify.dict (\key value -> isEven value) (Dict.fromList [(0,0),(1,1),(2,2),(3,3)])
    --> Some

    Quantify.dict (\key value -> isEven value) (Dict.fromList [(0,0),(1,2),(2,4),(3,6)])
    --> All

    Quantify.dict (\key value -> isEven value) Dict.empty
    --> None

-}
dict : (comparable -> a -> Bool) -> Dict comparable a -> Quantifier
dict predicate xs =
    let
        ( satisfying, notSatisfying ) =
            Dict.partition predicate xs
    in
    if Dict.isEmpty satisfying then
        None
    else if Dict.isEmpty notSatisfying then
        All
    else
        Some


{-| Quantify a single value according to a predicate.

    isEven : Int -> Bool
    isEven number =
        number % 2 == 0

    Quantify.single isEven 1
    --> None

    Quantify.single isEven 0
    --> All

-}
single : (a -> Bool) -> a -> Quantifier
single predicate x =
    fromBool (predicate x)


{-| Quantify a Bool value according to a predicate.

    Quantify.fromBool True
    --> None

    Quantify.fromBool False
    --> All

-}
fromBool : Bool -> Quantifier
fromBool bool =
    if bool then
        All
    else
        None
