context("classification")

test_that("train stops passing a wrong method", {
    expect_that(train("anything", method="wrong method"), throws_error())
})


test_that("train works well", {
    ## build a dataset for tests
    X1 = c(0.0, 6.57, 4.32)
    X2 = c(1.0, 7.01, 9.70)
    X3 = c(1.0, 9.38, 9.90)
    X4 = c(0.0, 8.26, 10.54)
    X5 = c(1.0, 8.71, 1.00)
    test.df <- data.frame(X1 = X1, X2 = X2, X3 = X3, X4 = X4, X5 = X5)
    row.names(test.df) <- c("class", "X85750_at", "U63842_at")
    test.df <- as.data.frame(t(test.df))

    res <- gdiscretize(test.df)
    trainingset <- res$dataset
    intervals <- res$intervals

    ## test train
    exp.model <- list("0" = list(
                          list(list(gene="X85750_at", lower=-Inf, upper=6.79),
                               list(gene="U63842_at", lower=2.66, upper=7.01)),
                          list(list(gene="X85750_at", lower=7.635, upper=8.485),
                               list(gene="U63842_at", lower=10.22, upper=Inf))),
                      "1" = list(
                          list(list(gene="X85750_at", lower=6.79, upper=7.635),
                               list(gene="U63842_at", lower=7.01, upper=10.22)),
                          list(list(gene="X85750_at", lower=8.485, upper=Inf),
                               list(gene="U63842_at", lower=-Inf, upper=2.66)),
                          list(list(gene="X85750_at", lower=8.485, upper=Inf),
                               list(gene="U63842_at", lower=7.01, upper=10.22)))
                      )
    expect_equal(train(trainingset, intervals, "arules"), exp.model)
})


test_that("classify works well", {
    sample <- list(gene1 = 9.4, gene2 = 2.7, gene3 = 78.1)
    ## satisfied
    rule1 <- list(list(gene = "gene1", lower = 8, upper = 10),
                  list(gene = "gene2", lower = 2.5, upper = 3),
                  list(gene = "gene3", lower = 78.1, upper = 100))
    ## satisfied
    rule2 <- list(list(gene = "gene1", lower = 9, upper = 10),
                  list(gene = "gene3", lower = 70, upper = 80))
    ## unsatisfied
    rule3 <- list(list(gene = "gene1", lower = 8, upper = 9),
                  list(gene = "gene2", lower = 2.5, upper = 3))
    ## satisfied
    rule4 <- list(list(gene = "gene2", lower = 2, upper = 4),
                  list(gene = "gene3", lower = 75, upper = 87))
    ## unsatisfied
    rule5 <- list(list(gene = "gene1", lower = 7, upper = 9.5),
                  list(gene = "gene2", lower = 2, upper = 3.5),
                  list(gene = "gene3", lower = 80, upper = 95))
    ## unsatisfied
    rule6 <- list(list(gene = "gene1", lower = 7, upper = 9.5),
                  list(gene = "gene3", lower = 80, upper = 95))

    model <- list("class1" = list(rule1, rule2, rule3),
                  "class2" = list(rule4, rule5, rule6))

    exp.class <- "class1"
    expect_equal(classify(sample, model), exp.class)
})
