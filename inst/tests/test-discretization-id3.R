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
    values <- c(2, 2, 3, 3, 5, 6, 6, 9, 9, 9, 9, 11, 11, 15)
    classes <- c(0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1)
    expected.cut.points <- c(2.5, 4, 7.5, 13)
    expect_equal(id3.cut.points(values, classes), expected.cut.points)
})
