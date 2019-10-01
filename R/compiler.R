#' Compiles a brainfuck program to a function
#'
#' @param brainfuck_code the brainfuck code
#'
#' @return It returns a function that expects a raw vectors which
#' is the internal memory of the brainfuck program.
#' According to Wikipedia you should pass in a raw vector of size 30,000 or larger.
#'
#' @export
compile <- function(brainfuck_code) {
  offset <- 2L
  instructions <- character(nchar(brainfuck_code) + offset)
  brainfuck_code <- strsplit(brainfuck_code, "", fixed = TRUE)[[1L]]
  n <- length(brainfuck_code)
  instructions[[1L]] <- "auto array = clone(cells);"
  instructions[[2L]] <- "auto ptr = array.begin();"
  for (op_idx in seq_len(n)) {
    instructions[[op_idx + offset]] <- get_cpp_instruction(brainfuck_code[[op_idx]])
  }
  instructions <- Filter(function(x) nchar(x) > 0, instructions)
  cpp_code <- paste0(instructions, collapse = "\n")
  cpp_code <- paste0(
    "Rcpp::RawVector wat(Rcpp::RawVector cells) {",
    cpp_code,
    "return array;",
    "}", collapse = "\n"
  )
  wat <- 0
  Rcpp::cppFunction(plugins = "cpp11", code = cpp_code)
  function(cells = raw(30000L)) {
    wat(cells)
  }
}

get_cpp_instruction <- function(op) {
  switch(op,
    ">" = "++ptr;",
    "<" =	"--ptr;",
    "+" =	"++*ptr;",
    "-" =	"--*ptr;",
    "." =	"Rcout << *ptr;",
    "," =	"*ptr=std::getchar();",
    "[" =	"while (*ptr) {",
    "]" =	"};",
    ""
  )
}
