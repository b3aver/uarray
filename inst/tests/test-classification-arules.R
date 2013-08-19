context("classification with arules")

test_that("parse.item works well", {
    item <- "X67951_at=3"

    exp.item <- list(gene="X67951_at", value=3)
    expect_equal(parse.item(item), exp.item)
})


test_that("mfi.arules works well", {
    ## build a dataset for tests
    test.df <- data.frame(class = c(1, 0, 0, 0, 0, 1, 2),
                          "gene1" = c(1, 3, 3, 2, 1, 2, 3),
                          "gene2" = c(2, 3, 1, 4, 1, 4, 4),
                          "gene3" = c(1, 2, 3, 2, 1, 4, 5))
    exp.mfi <- list("1" = list(),
                    "0" =
                    list(list(list(gene="gene1", value=3)),
                         list(list(gene="gene3", value=2)),
                         list(list(gene="gene2", value=1))))
    ## test mfi.arules
    expect_equal(mfi.arules(test.df), exp.mfi)
})
