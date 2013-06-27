context("discretization with CACC")



test_that("cacc.value works", {
    values <- c(2, 2, 3, 4, 6, 6, 6, 8, 8, 9)
    classes <- c(0, 1, 0, 1, 1, 1, 1, 0, 0, 0)
    cut.points <- c(3, 6, 8)

   expect_equal(cacc.value(values, classes, cut.points), 0.549609,
                 tolerance=0.000001)

    classes <- c(0, 1, 0, 1, 1, 1, 0, 0, 0, 0)
    cut.points <- c(3, 6)
    expect_equal(cacc.value(values, classes, cut.points), 0.1570379,
                 tolerance=0.000001)
})
