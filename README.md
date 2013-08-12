# Microarray data classification

## Quick start
### Installation
    source("http://bioconductor.org/biocLite.R")
    biocLite("limma")
    library(devtools)
    install_github("uarray", username="b3aver")
    library(uarray)

### Training
    trainingsetFN <- "data/trainingset.csv"
    ## or for a dataset provided with the package
    ## trainingsetFN <- system.file("extdata", "Brain_Cancer.csv", package="uarray")
    trainingset <- read(trainingsetFN)
    filteredTS <- gfilter(trainingset)
    discretizedTS <- gdiscretize(filteredTS)
    classificationModel <- train(discretizedTS$dataset, discretizedTS$intervals)

### Classification
    newsampleFN <- "data/newsample.csv"
    newsample <- read(newsampleFN)
    classify(newsample, classificationModel)

### Validation
    accuracy(validate(trainingset))

## Datasets
With the package are provided also the following datasets from [MIDClass] []:

* Brain_Cancer.csv
* BRC_01.csv
* BRC_2.csv
* Gastric_Cancer.csv
* Lung_Cancer_1.csv
* Lung_Cancer_2.csv
* Lymphoma_Cancer.csv
* Melanoma_Cancer.csv
* Myeloma_Cancer.csv
* Pacreatic_Cancer.csv
* Prostate_Cancer.csv

the paths to them can be retrieved with

    system.file("extdata", "<dataset filename>", package="uarray")


## References

Rosalba Giugno, Alfredo Pulvirenti, Luciano Cascione, Giuseppe Pigola, Alfredo
Ferro.  
_MIDClass: Microarray Data Classification by Association Rules and Gene
Expression Intervals._  
[MIDClass] []

Smyth, G. K.  
_Linear models and empirical Bayes methods for assessing differentiale
expression in microarray experiments._  
Statistical Applications in Genetics and Molecular Biology, (2004), Vol. 3,
No. 1, Article 3.  
[Limma] []

J. Alcalá-Fdez, L. Sánchez, S. García, M.J. del Jesus, S. Ventura,
J.M. Garrell, J. Otero, C. Romero, J. Bacardit, V.M. Rivas, J.C. Fernández,
F. Herrera.  
_KEEL: A Software Tool to Assess Evolutionary Algorithms to Data Mining
Problems_.  
Soft Computing 13:3 (2009) 307-318, doi: 10.1007/s00500-008-0323-y.

J. Alcalá-Fdez, A. Fernandez, J. Luengo, J. Derrac, S. García, L. Sánchez,
F. Herrera.  
_KEEL Data-Mining Software Tool: Data Set Repository, Integration of Algorithms
and Experimental Analysis Framework._  
Journal of Multiple-Valued Logic and Soft Computing 17:2-3 (2011) 255-287.

Michael Hahsler, Christian Buchta, Bettina Grün and Kurt Hornik.  
_Introduction to arules – A computational environment for mining association
rules and frequent item sets_


[MIDClass]: http://ferrolab.dmi.unict.it/midclass.html
[Limma]: http://www.bepress.com/sagmb/vol3/iss1/art3
