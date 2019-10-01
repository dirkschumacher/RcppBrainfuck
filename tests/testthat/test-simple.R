test_that("hello world works", {
  # from Wikipedia https://en.wikipedia.org/wiki/Brainfuck
  code <- "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++."
  fun <- compile(code)
  expect_output(fun(raw(30000)), "Hello World")
})

test_that("ignores unknown ops", {
  code <- "[->+<] lol wat wat"
  fun <- compile(code)
  expect_silent(fun())
})

test_that("can access memory", {
  code <- "++>+++[<+>-]" #add 2 + 3
  fun <- compile(code)
  res <- fun(raw(30000))
  expect_equal(as.integer(res[[1]]), 5L)
})
