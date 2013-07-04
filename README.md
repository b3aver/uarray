# Microarray data classification

## Quick start
### Installation
    library(devtools)
    install_github("uarray", username="b3aver")

### Training
    trainingsetFN <- "data/trainingset.csv"
    trainingset <- read(trainingsetFN)
    filteredTS <- gfilter(trainingset)
    discretizedTS <- gdiscretize(filteredTS)
    classificationModel <- train(discretizedTS$dataset, discretizedTS$intervals)
    
### Classification
    newsampleFN <- "data/newsample.csv"
    newsample <- read(newsampleFN)
    classify(newsample, classificationModel)
