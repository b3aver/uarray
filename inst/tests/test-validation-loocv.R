context("validation with loocv")

test_that("loocv works well", {
    ## build a dataset for tests
    test.df <- data.frame(class = c(1, 0, 0, 0, 0, 1),
                          "gene1" = c(1, 3, 3, 2, 1, 2),
                          "gene2" = c(2, 3, 1, 4, 1, 4),
                          "gene3" = c(1, 2, 3, 2, 1, 4))
    ## test loocv
    exp.cm <- matrix(c(2, 2, 2, 0), nrow=2, byrow=T)
    rownames(exp.cm) <- c("0", "1")
    colnames(exp.cm) <- c("0", "1")
    expect_equal(loocv(test.df), exp.cm)

    ## build another dataset for tests
    X1 = c(0.0, 6.57, 4.32)
    X2 = c(1.0, 7.01, 9.70)
    X3 = c(1.0, 9.38, 9.90)
    X4 = c(0.0, 8.26, 10.54)
    X5 = c(1.0, 8.71, 1.00)
    test.df <- data.frame(X1 = X1, X2 = X2, X3 = X3, X4 = X4, X5 = X5)
    row.names(test.df) <- c("class", "X85750_at", "U63842_at")
    test.df <- as.data.frame(t(test.df))
    ## test loocv
    exp.cm <- matrix(c(0, 2, 2, 1), nrow=2, byrow=T)
    rownames(exp.cm) <- c("0", "1")
    colnames(exp.cm) <- c("0", "1")
    expect_equal(loocv(test.df), exp.cm)
})
