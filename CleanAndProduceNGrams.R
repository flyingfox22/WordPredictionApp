setwd("C:\\Users\\Lee\\Documents\\R\\10. Captstone\\FinalProjectCapstone-WordPredictionApp\\WordPredictionApp")

#Load required packages
options(java.parameters = "-Xmx3g")
library(ggplot2)
library(wordcloud)
library('NLP')
library('tm')
suppressWarnings(library(tm))
suppressWarnings(library(tau))
suppressWarnings(library(stringr))
suppressWarnings(library(R.utils))
suppressWarnings(library(SnowballC))
suppressWarnings(library(RWeka))
suppressWarnings(library(pryr))
suppressWarnings(library(markdown))
suppressWarnings(library(ggplot2))
suppressWarnings(library(MASS))
suppressWarnings(library(data.table))

#Load required data into corpus
Dataset <- "./Coursera-SwiftKey/final/en_US"
corpus <- VCorpus(DirSource(Dataset, "UTF-8"),  readerControl = list(language = "en"))

source("CommonFunction.R")

# Empty data frames
wf1_old <- data.frame(terms=NA, freq=NA)[numeric(0), ]
wf2_old <- data.frame(terms=NA, freq=NA)[numeric(0), ]
wf3_old <- data.frame(terms=NA, freq=NA)[numeric(0), ]
wf4_old <- data.frame(terms=NA, freq=NA)[numeric(0), ]

# Create term document matrix
tok1 <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))
tok2 <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
tok3 <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
tok4 <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))

fDF_nameA <- "./InputData/DF1_"
fDF_nameB <- "./InputData/DF2_"
fDF_nameC <- "./InputData/DF3_"
fDF_nameD <- "./InputData/DF4_"

#Load 7% of the dataset (you can change how many percentage of the sample data that you want to train)
corpus[[1]]$content <- getSmpl(corpus[[1]]$content, 7)
corpus[[2]]$content <- getSmpl(corpus[[2]]$content, 7)
corpus[[3]]$content <- getSmpl(corpus[[3]]$content, 7)

#Create content transformers which modify the content of an R object.
removeSpecialChar <- content_transformer(function(x, pattern) gsub(pattern, " ", x)) 

#Remove special characters
corpus <- tm_map(corpus, removeSpecialChar, "[^[:graph:]]")

#Convert to Lower Case
corpus <- tm_map(corpus, content_transformer(tolower))

#Eliminating Extra Whitespace
corpus <- tm_map(corpus, stripWhitespace)

#Remove Punctuation
corpus <- tm_map(corpus, removePunctuation)

#Remove Numbers
corpus <- tm_map(corpus, removeNumbers)

#Remove Stopwords
corpus <- tm_map(corpus, removeWords, stopwords("english"))

profanityList <- (readLines("swearWords.txt"))
#Remove Pofanity Words
corpus <- tm_map(corpus, removeWords, profanityList)
rm( profanityList)

#TermDocumentMatrix (4 levels)
tdm1 <- TermDocumentMatrix(corpus, control = list(tokenize = tok1))
tdm2 <- TermDocumentMatrix(corpus, control = list(tokenize = tok2))
tdm3 <- TermDocumentMatrix(corpus, control = list(tokenize = tok3))
tdm4 <- TermDocumentMatrix(corpus, control = list(tokenize = tok4))
  
#Sorting
freq1 <- sort(rowSums(as.matrix(tdm1)), decreasing=TRUE)
freq2 <- sort(rowSums(as.matrix(tdm2)), decreasing=TRUE)
freq3 <- sort(rowSums(as.matrix(tdm3)), decreasing=TRUE)
freq4 <- sort(rowSums(as.matrix(tdm4)), decreasing=TRUE)
  
#put into data table
wf1 <- data.table(terms=names(freq1), freq=freq1)
wf2 <- data.table(terms=names(freq2), freq=freq2)
wf3 <- data.table(terms=names(freq3), freq=freq3)
wf4 <- data.table(terms=names(freq4), freq=freq4)
  
#concat file name
fDF_name1 <- paste(fDF_nameA,'token_1',sep="")
fDF_name2 <- paste(fDF_nameB,'token_2',sep="")
fDF_name3 <- paste(fDF_nameC,'token_3',sep="")
fDF_name4 <- paste(fDF_nameD,'token_4',sep="")
  
#write to data table
write.table(wf1, fDF_name1, col.names = TRUE)
write.table(wf2, fDF_name2, col.names = TRUE)
write.table(wf3, fDF_name3, col.names = TRUE)
write.table(wf4, fDF_name4, col.names = TRUE)

wf1_old <- data.frame(terms=NA, freq=NA)[numeric(0), ]
wf2_old <- data.frame(terms=NA, freq=NA)[numeric(0), ]
wf3_old <- data.frame(terms=NA, freq=NA)[numeric(0), ]
wf4_old <- data.frame(terms=NA, freq=NA)[numeric(0), ]

#read from data table
wf1 <- read.table(fDF_name1, header = TRUE)
wf2 <- read.table(fDF_name2, header = TRUE)
wf3 <- read.table(fDF_name3, header = TRUE)
wf4 <- read.table(fDF_name4, header = TRUE)

#merge data table
wf1_new <- mergeDFs(wf1_old, wf1)
wf2_new <- mergeDFs(wf2_old, wf2)
wf3_new <- mergeDFs(wf3_old, wf3)
wf4_new <- mergeDFs(wf4_old, wf4)

wf1_old <- wf1_new
wf2_old <- wf2_new
wf3_old <- wf3_new
wf4_old <- wf4_new

fDF1_final <- "./InputData/fDF1_final"
fDF2_final <- "./InputData/fDF2_final"
fDF3_final <- "./InputData/fDF3_final"
fDF4_final <- "./InputData/fDF4_final"

fName1 = "./InputData/fDF1_final.RData"
fName2 = "./InputData/fDF2_final.RData"
fName3 = "./InputData/fDF3_final.RData"
fName4 = "./InputData/fDF4_final.RData"

#sorting
wf1_new <- wf1_new[with(wf1_new, order(-freq)), ]
wf2_new <- wf2_new[with(wf2_new, order(-freq)), ]
wf3_new <- wf3_new[with(wf3_new, order(-freq)), ]
wf4_new <- wf4_new[with(wf4_new, order(-freq)), ]

write.table(wf1_new, fDF1_final, col.names = TRUE)
write.table(wf2_new, fDF2_final, col.names = TRUE)
write.table(wf3_new, fDF3_final, col.names = TRUE)
write.table(wf4_new, fDF4_final, col.names = TRUE)

save(wf1_new, file=fName1);
save(wf2_new, file=fName2);
save(wf3_new, file=fName3);
save(wf4_new, file=fName4);

View(head(wf1_new))
View(head(wf2_new))
View(head(wf3_new))
View(head(wf4_new))

fDF1 <- read.table(fName1, header = TRUE, stringsAsFactors = FALSE)
fDF2 <- read.table(fName2, header = TRUE, stringsAsFactors = FALSE)
fDF3 <- read.table(fName3, header = TRUE, stringsAsFactors = FALSE)
fDF4 <- read.table(fName4, header = TRUE, stringsAsFactors = FALSE)

fDF1 <- fDF1[fDF1$freq > 100,]
fDF2 <- fDF2[fDF2$freq > 100,]
fDF3 <- fDF3[fDF3$freq > 100,]
fDF4 <- fDF4[fDF4$freq > 100,]

#brand new dataset
save(fDF1, file="./CleanData/df_tdm_1.RData")
save(fDF2, file="./CleanData/df_tdm_2.RData")
save(fDF3, file="./CleanData/df_tdm_3.RData")
save(fDF4, file="./CleanData/df_tdm_4.RData")

