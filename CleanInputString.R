#Clean user input before predict the next word

CleanInputString <- function(inStr)
{  
  # First remove the non-alphabatical characters
  inStr <- iconv(inStr, "latin1", "ASCII", sub=" ");
  inStr <- gsub("[^[:alpha:][:space:][:punct:]]", "", inStr);
  
  # Then convert to a Corpus
  corpus <- VCorpus(VectorSource(inStr))
  
  # Clean Data
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
  #corpus <- tm_map(corpus, removeWords, stopwords("english"))
  
  profanityList <- (readLines("swearWords.txt"))
  #Remove Pofanity Words
  corpus <- tm_map(corpus, removeWords, profanityList)
  
  inStr <- as.character(corpus[[1]])
  inStr <- gsub("(^[[:space:]]+|[[:space:]]+$)", "", inStr)  
    
  # Return the cleaned result
  if (nchar(inStr) > 0) {
    return(inStr); 
  } else {
    return("");
  }
}