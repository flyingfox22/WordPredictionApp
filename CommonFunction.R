#Function get sample data
getSmpl <- function(fData, pSmplSize)
{
  nData <- length(fData)
  smplSize <- as.integer(pSmplSize*nData)/100
  smplIndx <- sample(1:nData, size = smplSize, replace = F)
  smplData <- fData[smplIndx]
  return(smplData)
}

#Function merge DF
mergeDFs <- function (df1, df2){
  df1 <- df1[order(df1$terms),]
  df2 <- df2[order(df2$terms),]
  
  df1$freq[df1$terms %in% df2$terms] <- df1$freq[df1$terms %in% df2$terms] + df2$freq[df2$terms %in% df1$terms]
  df3 <- rbind(df1, df2[!(df2$terms %in% df1$terms),])
  df3
}