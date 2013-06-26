context("discretization with EWIB")

test_that("the cut points are correctly computed", {
    values <- c(3, 6, 11, 2, 9, 11, 5, 3, 18, 6, 9, 2, 9, 9)
    num.bin <- 4
    expected.cut.points <- c(6, 10, 14)
    expect_equal(ewib.cut.points(values, num.bin), expected.cut.points)
})


test_that("gdiscretize.ewib works well", {
    ## build a dataset for tests
    X1 = c(0.0, 6.57, 4.32)
    X2 = c(1.0, 7.01, 9.70)
    X3 = c(1.0, 9.38, 9.90)
    X4 = c(0.0, 8.26, 10.54)
    X5 = c(1.0, 8.71, 1.00)
    test.df <- data.frame(X1 = X1, X2 = X2, X3 = X3, X4 = X4, X5 = X5)
    row.names(test.df) <- c("class", "X85750_at", "U63842_at")
    test.df <- as.data.frame(t(test.df))

    ## execute gdiscretize.ewib
    num.bin <- 3
    res <- gdiscretize.ewib(test.df, num.bin)
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
    exp.df["X85750_at"] <- c(1, 1, 3, 2, 3)
    exp.df["U63842_at"] <- c(2, 3, 3, 3, 1)
    expect_equal(discretized.df, exp.df)
    ## test intervals content
    exp.intervals <- list()
    min1 <- 6.57
    max1 <- 9.38
    delta1 <- (max1 - min1)/num.bin
    exp.intervals[["X85750_at"]] <- list(c(-Inf, min1 + delta1),
                                         c(min1 + delta1, min1 + 2*delta1),
                                         c(min1 + 2*delta1, Inf))
    exp.intervals[["U63842_at"]] <- list(c(-Inf, 4.18), c(4.18, 7.36),
                                         c(7.36, Inf))
    expect_equal(intervals, exp.intervals)
})
