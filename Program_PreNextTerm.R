setwd("C:\\Users\\Lee\\Documents\\R\\10. Captstone\\FinalProjectCapstone-WordPredictionApp\\WordPredictionApp")

suppressWarnings(library(tm))
suppressWarnings(library(stringr))
suppressWarnings(library(shiny))

load(".\\CleanData\\df_tdm_1.RData")
load(".\\CleanData\\df_tdm_2.RData")
load(".\\CleanData\\df_tdm_3.RData")
load(".\\CleanData\\df_tdm_4.RData")

source("CleanInputString.R")
source("PredNextTerm.R")

#String for testing the code
input4 <- "i am a boy"
input3 <- "i am a"
input2 <- "i am"
input1 <- "i"

nextWord4 <- PredNextTerm(input4);
nextWord3 <- PredNextTerm(input3);
nextWord2 <- PredNextTerm(input2);
nextWord1 <- PredNextTerm(input1);

nextWord4
nextWord3
nextWord2
nextWord1

# The predicted next word
nextSingleWord4 <- word(nextWord4[1,1], -1);
nextSingleWord3 <- word(nextWord3[1,1], -1);
nextSingleWord2 <- word(nextWord2[1,1], -1);
nextSingleWord1 <- word(nextWord1[1,1], -1);

nextSingleWord4
nextSingleWord3
nextSingleWord2
nextSingleWord1







