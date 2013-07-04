context("discretization with CACC")

test_that("cacc.value works well", {
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


test_that("the cut points are correctly computed", {
    values <- c(3, 6, 11, 2, 9, 11, 5, 3, 15, 6, 9, 2, 9, 9)

    classes <- c(0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 0)
    expected.cut.points <- c(4, 7.5)
    expect_equal(cacc.cut.points(values, classes), expected.cut.points)

    classes <- c(0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0)
    expected.cut.points <- c(4, 10 )
    expect_equal(cacc.cut.points(values, classes), expected.cut.points)
})


test_that("gdiscretize.cacc works well", {
    ## build a dataset for tests
    X1 = c(0.0, 6.57, 4.32)
    X2 = c(1.0, 7.01, 9.70)
    X3 = c(1.0, 9.38, 9.90)
    X4 = c(0.0, 8.26, 10.54)
    X5 = c(1.0, 8.71, 1.00)
    test.df <- data.frame(X1 = X1, X2 = X2, X3 = X3, X4 = X4, X5 = X5)
    row.names(test.df) <- c("class", "X85750_at", "U63842_at")
    test.df <- as.data.frame(t(test.df))

    ## execute gdiscretize.cacc
    res <- gdiscretize.cacc(test.df)
    discretized.df <- res$dataset
    intervals <- res$intervals

    ## test results
    ##
    ## test results' format
    exp.genes <- c("X85750_at", "U63842_at")
    exp.columns <- c("class", exp.genes)
    expect_that(colnames(discretized.df), equals(exp.columns))
    expect_that(names(intervals), equals(exp.genes))
    for(interval in names(intervals)){
        expect_that(intervals[[interval]], is_a("list"))
    }
    ## test dataset content
    exp.df <- test.df
    exp.df["X85750_at"] <- c(1, 2, 4, 3, 4)
    exp.df["U63842_at"] <- c(2, 3, 3, 4, 1)
    expect_equal(discretized.df, exp.df)
    ## test intervals content
    exp.intervals <- list()
    exp.intervals[["X85750_at"]] <- list(c(-Inf, 6.79), c(6.79, 7.635),
                                         c(7.635, 8.485), c(8.485, Inf))
    exp.intervals[["U63842_at"]] <- list(c(-Inf, 2.66), c(2.66, 7.01),
                                         c(7.01, 10.22), c(10.22, Inf))
    expect_equal(intervals, exp.intervals)
})
