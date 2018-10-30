# Quantify

[![Build Status](https://travis-ci.org/GlobalWebIndex/quantify.svg?branch=master)](https://travis-ci.org/GlobalWebIndex/quantify)

Allows you to quantify list, set, dict or a single value according to a predicate.

Returns `None`, `Some` or `All`.

Feedback and contributions to both code and documentation are very welcome.

## Installation

Usual elm package install:

```
$ elm package install GlobalWebIndex/quantify
```

## Usage

```elm
    isEven : Int -> Bool
    isEven number =
        number % 2 == 0

    Quantify.list isEven [1,3,5,7]
    --> None
```
