rm(list = ls())

## Loading Libraries
library(tidytext)
library(stringi)
library(qdap)
library(tm)
library(SnowballC)
library(caret)
library(sentimentr)
library(textshape)
library(textclean)
library(plyr)
library(NLP)
library(openNLP)
library(xgboost)

library(data.table)
library(dplyr)
library(stringr)
library(ngram)
library(tokenizers)
library(tidyverse)
library(magrittr)
library(text2vec)
library(glmnet)
library(doParallel)
registerDoParallel(2)

setwd("C:\\Users\\HP LAP\\Desktop\\Kaggle\\Data\\train") #mention your WD
getwd()



#Saving Training and Test Sets****************************************

#save(all_comments.features, file= "Train.Rdata")
#save(all_comments.features_test, file= "Test.Rdata")
#save.image(file="Init.Rdata")

load("Init.Rdata")
load("Train.Rdata")
load("Test.Rdata")



