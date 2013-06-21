#' Select discriminant gene expression values.
#'
#' Apply the T-Test to the gene expression values.
#'
#' @export
#' @param dataset training set to be filtered
#' @param method character string specifing the method to use.
#'               Choices are "limma".
#' @param number maximum number of genes to list
#' @param p.value cutoff value for adjusted p-values. Only genes with lower p-values are listed.
#' @return filtered dataset
gfilter <- function(dataset, method = "limma", number = NULL, p.value = NULL){
    switch(method,
           limma = gfilter.limma(dataset, number, p.value),
           stop("unsupported method"))
}


#' Select discriminant gene expression values using the LIMMA package.
#'
#' @references Smyth, G. K. (2004). Linear models and empirical Bayes methods for assessing differential expression in microarray experiments. Statistical Applications in Genetics and Molecular Biology, Vol. 3, No. 1, Article 3.
#' http://www.bepress.com/sagmb/vol3/iss1/art3
#'
#' @param dataset training set to be filtered
#' @param number maximum number of genes to list. \code{number=Inf} for list all genes with adjusted p-values below a specified value.
#' @param p.value cutoff value for adjusted p-values. Only genes with lower p-values are listed.
#' @return filtered dataset
gfilter.limma <- function(dataset, number = 10, p.value = 1) {
    ## prepare the dataset
    dataset2 <- dataset
    dataset2$class <- NULL
    dataset2 <- t(dataset2)             # class(dataset2) == matrix

    ## build a design matrix
    levels <- dataset$class
    f <- factor(levels)
    design <- model.matrix(~f)

    ## call limma's function
    fit <- lmFit(dataset2, design=design)
    fit2 <- eBayes(fit)
    top <- topTable(fit2, adjust.method="BH", number=number, p.value=p.value)

    ## filtered dataset
    dataset[c("class", as.vector(t(top["ID"])))]
}
