context("classification-lib")

test_that("apply.on.items works well", {
    model <- list(class1 =
                  list(list(1, 2, 3, 4),
                       list(4, 3, 2, 1)),
                  class2 =
                  list(list(10, 20, 30, 40),
                       list(7, 8, 9, 10)))
    fun <- function(item){
        item + 1
    }
    exp.model <- list(class1 =
                      list(list(2, 3, 4, 5),
                           list(5, 4, 3, 2)),
                      class2 =
                      list(list(11, 21, 31, 41),
                           list(8, 9, 10, 11)))
    expect_equal(apply.on.items(model, fun), exp.model)
})


test_that("undiscretize.item works well", {
    item <- list(gene = "X67951_at", value = 3)
    intervals <- build.intervals(c(2,4,5,6,7))
    intervals <- list("X67951_at" = intervals)

    exp.item <- list(gene="X67951_at", lower=4, upper=5)
    expect_equal(undiscretize.item(item, intervals), exp.item)
})


test_that("score works well", {
    sample <- list(gene1 = 9.4, gene2 = 2.7, gene3 = 78.1)
    rule1 <- list(list(gene = "gene1", lower = 8, upper = 10),
                  list(gene = "gene2", lower = 2.5, upper = 3),
                  list(gene = "gene3", lower = 78.1, upper = 100))
    rule2 <- list(list(gene = "gene1", lower = 8, upper = 10),
                  list(gene = "gene3", lower = 70, upper = 78.1))

    exp.score1 <- 3 / 3 * log(3)
    exp.score2 <- 1 / 2 * log(2)
    expect_equal(score(sample, rule1), exp.score1)
    expect_equal(score(sample, rule2), exp.score2)
})


test_that("supp works well", {
    test.df <- data.frame(class = c(1, 0, 0, 0, 0, 1),
                          "gene1" = c(1, 3, 3, 2, 1, 2),
                          "gene2" = c(2, 3, 1, 4, 1, 4),
                          "gene3" = c(1, 2, 3, 2, 1, 4))

    itemset1 <- list(list(gene = "gene1", value = 1),
                     list(gene = "gene2", value = 2),
                     list(gene = "gene3", value = 1))
    exp.supp1 <- 1
    expect_equal(supp(itemset1, test.df), exp.supp1)

    itemset2 <- list(list(gene = "gene1", value = 1),
                     list(gene = "gene3", value = 1))
    exp.supp2 <- 2
    expect_equal(supp(itemset2, test.df), exp.supp2)

    itemset3 <- list(list(gene = "gene1", value = 1),
                     list(gene = "gene3", value = 2))
    exp.supp3 <- 0
    expect_equal(supp(itemset3, test.df), exp.supp3)
})


test_that("filter.rules works well", {
    ## define a training set
    test.df <- data.frame(class = c(1, 0, 0, 0, 1, 0, 1),
                          "gene1" = c(1, 3, 3, 2, 1, 2, 3),
                          "gene2" = c(2, 3, 3, 4, 1, 4, 3),
                          "gene3" = c(1, 2, 3, 2, 1, 4, 1))
    ## define a model
    itemset1 <- list(list(gene = "gene1", value = 2),
                     list(gene = "gene2", value = 4))
    itemset2 <- list(list(gene = "gene1", value = 3),
                     list(gene = "gene2", value = 3))
    itemset3 <- list(list(gene = "gene1", value = 1),
                     list(gene = "gene3", value = 1))
    itemset4 <- list(list(gene = "gene1", value = 3),
                     list(gene = "gene3", value = 2))
    model <- list("0" = list(itemset1, itemset2),
                  "1" = list(itemset3, itemset4))

    ## test filter.rules
    exp.model <- list("0" = list(itemset1),
                      "1" = list(itemset3))
    expect_equal(filter.rules(model, test.df), exp.model)

    ## test filter.rules with a lower confidence
    confidence <- 0.5
    exp.model[["0"]] <- c(exp.model[["0"]], list(itemset2))
    expect_equal(filter.rules(model, test.df, confidence), exp.model)
})
