context("discretization with ID3")

test_that("the entropy is correctly computed", {
    classes <- c(rep("yes", 9), rep("no", 5))
    expected.entropy <- -9/14 * log2(9/14) -5/14 * log2(5/14)
    expect_equal(id3.entropy(classes), expected.entropy)
})


test_that("the entropy of a partition is correctly computed", {
    classes <- c(1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1, 1, 1)
    ##                            split point -^
    split.point <- 11
    ent.left <- -6/10 * log2(6/10) -4/10 * log2(4/10)
    ent.right <- -3/4 * log2(3/4) -1/4 * log2(1/4)
    expected.entropy <- 10/14 * ent.left + 4/14 * ent.right
    expect_equal(id3.entropy.partition(classes, split.point), expected.entropy)
})


test_that("the cut points are correctly computed", {
    values <- c(3, 6, 11, 2, 9, 11, 5, 3, 15, 6, 9, 2, 9, 9)
    classes <- c(0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 0)
    expected.cut.points <- c(2.5, 4, 7.5, 13)
    expect_equal(id3.cut.points(values, classes), expected.cut.points)
})


test_that("gdiscretize.id3 works well", {
    ## build a dataset for tests
    X1 = c(0.0, 6.57, 4.32)
    X2 = c(1.0, 7.01, 9.70)
    X3 = c(1.0, 9.38, 9.90)
    X4 = c(0.0, 8.26, 10.54)
    X5 = c(1.0, 8.71, 1.00)
    test.df <- data.frame(X1 = X1, X2 = X2, X3 = X3, X4 = X4, X5 = X5)
    row.names(test.df) <- c("class", "X85750_at", "U63842_at")
    test.df <- as.data.frame(t(test.df))

    ## execute gdiscretize.id3
    res <- gdiscretize.id3(test.df)
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
