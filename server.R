setwd("C:\\Users\\Lee\\Documents\\R\\10. Captstone\\FinalProjectCapstone-WordPredictionApp\\WordPredictionApp")
suppressWarnings(library(tm))
suppressWarnings(library(stringr))
suppressWarnings(library(shiny))
suppressWarnings(library(wordcloud))

load(".\\CleanData\\df_tdm_1.RData")
load(".\\CleanData\\df_tdm_2.RData")
load(".\\CleanData\\df_tdm_3.RData")
load(".\\CleanData\\df_tdm_4.RData")

source(".\\CleanInputString.R")
source(".\\PredNextTerm.R")

shinyServer(function(input, output) {
  
  ##output$PredictQuiz_term <- renderText({ 
  ##  paste("You have selected", PredNextTerm(input$PredictQuiz)[1,1])
  ##
  ##})
  
  output$PredictQuizResult <- renderUI({
    nextWord<-PredNextTerm(input$PredictQuiz)
    str1 <- paste("You have selected")
    str2 <- paste("<strong>",input$PredictQuiz," </strong></br>")
    str3 <- paste("Next word is <strong>", nextWord[1,1]," </strong>")    
    str4 <- paste(nextWord[1,2],"</br>")
    str5 <- paste("Full sentence: ", input$PredictQuiz, "<strong>", nextWord[1,1] ," </strong></br>")    
    HTML(paste(str1, str2, str3, str4, str5, sep = '<br/>'))    
  })  
  
  output$PredictQuizAllResult <- renderDataTable({    
    (PredAllNextTerm(input$PredictQuiz))    
  }, options = list(paging = TRUE,searching = FALSE,pageLength = 10))
  
  output$PredictQuizAllResultPlot <- renderPlot({     
    df <-(PredAllNextTerm(input$PredictQuiz))   
    wordcloud(df$Terms, df$Frequency, random.order=FALSE, max.words=100, colors=brewer.pal(7, "Dark2"))    
  })
  
  
  #text prediction
  output$PredictTextResult <- renderUI({
    nextWord<-PredNextTerm(input$PredictText)
    str1 <- paste("You have entered")
    str2 <- paste("<strong>",input$PredictText," </strong></br>")
    str3 <- paste("Next word is <strong>", nextWord[1,1]," </strong>")    
    str4 <- paste(nextWord[1,2],"</br>")
    str5 <- paste("Full sentence: ", input$PredictText, "<strong>", nextWord[1,1] ," </strong></br>")    
    HTML(paste(str1, str2, str3, str4, str5, sep = '<br/>'))    
  })  
  
  output$PredictTextAllResult <- renderDataTable({    
    (PredAllNextTerm(input$PredictText))    
  }, options = list(paging = TRUE,searching = FALSE,pageLength = 10))
  
  output$PredictTextAllResultPlot <- renderPlot({     
    df <-(PredAllNextTerm(input$PredictText))   
    if( nrow(df) > 0)
    {
      wordcloud(df$Terms, df$Frequency, random.order=FALSE, max.words=100, colors=brewer.pal(7, "Dark2"))    
    }
  })
  
  
})
