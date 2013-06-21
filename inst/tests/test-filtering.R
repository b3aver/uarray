context("filtering")

test_that("gfilter stops with a wrong method", {
    expect_that(gfilter("anything", method="wrong method"), throws_error())
})


test_that("gfilter.limma works", {
    ## build a dataset for tests
    X1 = c(0.0, 6.57, 4.32)
    X2 = c(1.0, 7.01, 9.70)
    X3 = c(1.0, 9.38, 9.90)
    X4 = c(0.0, 8.26, 10.54)
    X5 = c(1.0, 8.71, 1.00)
    test.df <- data.frame(X1 = X1, X2 = X2, X3 = X3, X4 = X4, X5 = X5)
    row.names(test.df) <- c("class", "X85750_at", "U63842_at")
    test.df <- as.data.frame(t(test.df))

    ## execute gfilter
    filtered.df <- gfilter.limma(test.df, number=1)

    ## test results
    expected.columns <- c("class", "X85750_at")
    expect_that(colnames(filtered.df), equals(expected.columns))
    for(column in expected.columns){
        expect_that(filtered.df[column], equals(test.df[column]))
    }
})
