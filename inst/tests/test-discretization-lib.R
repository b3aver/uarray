context("discretization-lib")

test_that("build.intervals works well", {
    cut.points <- c(1,2,3,4)
    expected.intervals <- list(c(-Inf, 1), c(1, 2), c(2,3), c(3,4), c(4,Inf))
    expect_equal(build.intervals(cut.points), expected.intervals)
})


test_that("discretize.values works well", {
    values <- c(-10, 1, 1.5, 2, 2.4, 3, 10)
    intervals <- build.intervals(c(1,2,3))
    expected.values.d <- c(1, 2, 2, 3, 3, 4, 4)
    expect_equal(discretize.values(values, intervals), expected.values.d)
})


test_that("discretize.attribute works well", {
    values <- c(3, 6, 11, 2, 9, 11, 5, 3, 15, 6, 9, 2, 9, 9)
    classes <- c(0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 0)
    cut.points.fun <- id3.cut.points
    expected.intervals <- list(c(-Inf, 2.5), c(2.5, 4), c(4, 7.5), c(7.5, 13),
                               c(13, Inf))
    expected.values.d <- c(2, 3, 4, 1, 4,  4, 3, 2, 5, 3, 4, 1, 4, 4)
    expect_equal(discretize.attribute(cut.points.fun, values, classes),
                 list(values=expected.values.d, intervals=expected.intervals))
})
