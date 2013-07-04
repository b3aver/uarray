context("uarray lib")

test_that("read function works correctly", {
    ## create a dataframe and write it
    datastring <- paste("Patient	1	2	3	4	5",
                        "	0	1	1	0	1",
                        "X85750_at	6.57	7.01	9.38	8.26	8.71",
                        "U63842_at	4.32	9.7	9.9	10.54	1",
                        sep = "\n")
    filename = tempfile()
    write(datastring, filename)

    ## build manually the expected dataframe
    X1 = c(0.0, 6.57, 4.32)
    X2 = c(1.0, 7.01, 9.70)
    X3 = c(1.0, 9.38, 9.90)
    X4 = c(0.0, 8.26, 10.54)
    X5 = c(1.0, 8.71, 1.00)
    test.df <- data.frame(X1 = X1, X2 = X2, X3 = X3, X4 = X4, X5 = X5)
    row.names(test.df) <- c("class", "X85750_at", "U63842_at")
    test.df <- as.data.frame(t(test.df))

    ## check that they correspond
    expect_that(read(filename), equals(test.df))
})
