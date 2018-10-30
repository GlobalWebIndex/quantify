# Quantify

[![Build Status](https://travis-ci.org/GlobalWebIndex/quantify.svg?branch=master)](https://travis-ci.org/GlobalWebIndex/quantify)

Allows you to quantify List, Set, Dict or a single value according to a predicate, by returning a `Quantifier`:

```elm
type Quantifier
    = None
    | Some
    | All
```

## Example usage

```elm
isEven : Int -> Bool
isEven number =
    number % 2 == 0

Quantify.list isEven [1,3,5,7]
--> None

Quantify.list isEven [1,2,3,4]
--> Some

Quantify.list isEven [2,4,6,8]
--> All
```

Feedback and contributions to both code and documentation are very welcome.

## Installation

```
$ elm install GlobalWebIndex/quantify
```
