# Microarray data classification

## Quick start
### Installation
    library(devtools)
    install_github("uarray", username="b3aver")

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

    system.file("extdata", "<dataset filename>", package="uarray")}



[MIDClass]: http://ferrolab.dmi.unict.it/midclass.html
