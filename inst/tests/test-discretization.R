context("discretization")

test_that("gdiscretize stops passing a wrong method", {
    expect_that(gdiscretize("anything", method="wrong method"), throws_error())
})


test_that("gdiscretize calls the id3 method", {
    ## build a dataset for tests
    X1 = c(0.0, 6.57, 4.32)
    X2 = c(1.0, 7.01, 9.70)
    X3 = c(1.0, 9.38, 9.90)
    X4 = c(0.0, 8.26, 10.54)
    X5 = c(1.0, 8.71, 1.00)
    test.df <- data.frame(X1 = X1, X2 = X2, X3 = X3, X4 = X4, X5 = X5)
    row.names(test.df) <- c("class", "X85750_at", "U63842_at")
    test.df <- as.data.frame(t(test.df))

    ## test gdiscretize
    expect_equal(gdiscretize(test.df, "id3"), gdiscretize.id3(test.df))
})
