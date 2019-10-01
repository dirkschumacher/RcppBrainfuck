
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RcppBrainfuck

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of `RcppBrainfuck` is to compile
[brainfuck](https://en.wikipedia.org/wiki/Brainfuck) code to C++ code
that can be run from R.

*NOT ENTERPRISE READY*

## Installation

You can install the released version of RcppBrainfuck from
[CRAN](https://CRAN.R-project.org) with:

``` r
remotes::install_github("dirkschumacher/RcppBrainfuck")
```

The package essentially just implements the translated brainfuck \<-\> C
OP codes from
[Wikipedia](https://en.wikipedia.org/wiki/Brainfuck#Commands). It is
just for fun and was an evening hack.

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(RcppBrainfuck)
```

Here is a “Hello World” program:

``` r
code <- "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++."
fun <- compile(code)
invisible(fun())
#> Hello World!
```

But you can also communicate with the Brainfuck code using a shared
Memory.

``` r
# add 2 to the first cell and then add 3 to the second cell
# and then while the second cell is not 0, decrement it and increment the first one
code <- "++>+++[<+>-]" 
fun <- compile(code)
cells <- fun()
as.integer(cells[[1L]])
#> [1] 5
```

In order to input values we need to construct our own cell raw array and
pass it to the function.

``` r
cells2 <- fun(cells)
# passing in 7 for the first value we expect 10 as the final result
as.integer(cells2[[1L]])
#> [1] 10
```

## References

  - <https://en.wikipedia.org/wiki/Brainfuck>

## Related Projects

  - <https://bitbucket.org/richierocks/brainfuck>
