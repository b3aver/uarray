context("validation")

test_that("validate stops passing a wrong method", {
    expect_that(validate("anything", method="wrong method"), throws_error())
})


test_that("validate calls the loocv method", {
    X1 = c(0.0, 6.57, 4.32)
    X2 = c(1.0, 7.01, 9.70)
    X3 = c(1.0, 9.38, 9.90)
    X4 = c(0.0, 8.26, 10.54)
    X5 = c(1.0, 8.71, 1.00)
    test.df <- data.frame(X1 = X1, X2 = X2, X3 = X3, X4 = X4, X5 = X5)
    row.names(test.df) <- c("class", "X85750_at", "U63842_at")
    test.df <- as.data.frame(t(test.df))

    ## test validate
    expect_equal(validate(test.df, method="loocv"), loocv(test.df))
})


test_that("accuracy works well", {
    confusion.matrix1 <- matrix(c(10, 2, 4, 11), nrow=2, byrow=T)
    exp.acc1 <- 21/27
    expect_equal(accuracy(confusion.matrix1), exp.acc1)

    confusion.matrix2 <- matrix(c(10, 2, 3, 4, 11, 2, 4, 5, 8), nrow=3, byrow=T)
    exp.acc2 <- 29/49
    expect_equal(accuracy(confusion.matrix2), exp.acc2)
})
