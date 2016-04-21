library(shiny)

shinyUI(fluidPage(
  titlePanel("Word Prediction Application",br()), 
  p(("Author : Lee Wai Siong")),
  p(("Date   : 16 April 2016")),
  mainPanel(
    tabsetPanel(
      tabPanel('Introduction',
               h4('Executive Summary'),
               fluidRow(
                 br(),
                 p("Now we are entering into the brand new technology world especially we can see those new emerging technology such as mobile app, tablet devices, IoT, cloud service and so on. 
                    Human nowadays send a lot of texts and type a lot of words by using these devices. This leads to the major evolution of how human type to sending these texts. 
                    In order to improve user experience, Swiftkey has contributed significant effort to build a smart keyboard that makes it easier for people to sending the text on their mobile or tablet devices. 
                    Instead of typing, they can swipe to sending the text. Thus, the main ojbective of this capstone project is to build a predictive text product in R by using Text Mining and Natural Language Processing (NLP) techniques. 
                    At the end of this product, it will help to predict the words that user might wants to type and their next preditive word.
                    In this project, we will be using the samples data of Twitter, News and Blogs in this data exploratory session. All the text will be based on English."),
                 br()               
               ),
               h4('Objective'),               
               fluidRow(
                 br(),
                 p("1. Demonstrate that have downloaded the data and have successfully loaded it in."),
                 p("2. Create a basic report of summary statistics about the data sets."),
                 p("3. Report any interesting findings that amassed so far."),
                 p("4. Get feedback on plans for creating a prediction algorithm and Shiny app."),
                 br(),
                 p("For more details, please click the link below in order to understand the full Data Exploratory Analysis."),
                 p("Source:", a("Assignment: Milestone Report (Exploratory Analysis)", href = "http://rpubs.com/flyingfox22/MilestoneReport1"))
               )                      
      ),
      tabPanel('Prediction Algorithm',
               h4('N-Grams'),
               fluidRow(
                 p("1. Build basic n-gram model - using the exploratory analysis you performed, build a basic n-gram model for predicting the next word based on the previous 1, 2, or 3 words."),
                 p("2. Build a model to handle unseen n-grams - in some cases people will want to type a combination of words that does not appear in the corpora. Build a model to handle cases 
                    where a particular n-gram isn't observed."),
                 p("More details :", a("N-Gram model", href = "https://en.wikipedia.org/wiki/N-gram"))
                ),                   
               br(),
               h4('Back-off model'),       
               fluidRow(               
                p("Use backoff models to estimate the probability of unobserved n-grams"),               
                p("More details :", a("Back-off model", href = "https://en.wikipedia.org/wiki/Katz%27s_back-off_model"))
               ),
               br()              
      ),
      tabPanel('Quiz Prediction',
               br(),
               selectInput("PredictQuiz", 
                           label = "Please select your quiz question:",
                           choices = c(
                                       "The guy in front of me just bought a pound of bacon, a bouquet, and a case of", 
                                       "You're the reason why I smile everyday. Can you follow me please? It would mean the",
                                       "Hey sunshine, can you follow me and make me the",
                                       "Very early observations on the Bills game: Offense still struggling but the",
                                       "Go on a romantic date at the",
                                       "Well I'm pretty sure my granny has some old bagpipes in her garage I'll dust them off and be on my",
                                       "Ohhhhh #PointBreak is on tomorrow. Love that film and haven't seen it in quite some",
                                       "After the ice bucket challenge Louis will push his long wet hair out of his eyes with his little",
                                       "Be grateful for the good times and keep the faith during the",
                                       "If this isn't the cutest thing you've ever seen, then you must be",
                                       "When you breathe, I want to be the air for you. I'll be there for you, I'd live and I'd",
                                       "Guy at my table's wife got up to go to the bathroom and I asked about dessert and he started telling me about his",
                                       "I'd give anything to see arctic monkeys this",
                                       "Talking to your mom has the same effect as a hug and helps reduce your",
                                       "When you were in Holland you were like 1 inch away from me but you hadn't time to take a",
                                       "I'd just like all of these questions answered, a presentation of evidence, and a jury to settle the",
                                       "I can't deal with unsymetrical things. I can't even hold an uneven number of bags of groceries in each",
                                       "Every inch of you is perfect from the bottom to the",
                                       "I’m thankful my childhood was filled with imagination and bruises from playing",
                                       "I like how the same people are in almost all of Adam Sandler's"                                       
                                       ),
                           selected = NULL, 
                           multiple = FALSE, 
                           selectize = FALSE, 
                           width = "100%", 
                           size = NULL),                     
                           
                       
               br(),
               h4('Analysis:'),
               htmlOutput("PredictQuizResult"),
               br(),
               br(),
               h4('All Predicted Results:'),
               dataTableOutput("PredictQuizAllResult"),
               br(),
               br(),
               h4('Word Cloud:'),
               plotOutput("PredictQuizAllResultPlot"),
               br(),
               br()     
      ),
      tabPanel('Text Prediction',
               br(),                
               textInput("PredictText", "Please enter your sentence: ",value = "",width = "100%"),
               #("Next Word")               
               br(),
               h4('Analysis:'),
               htmlOutput("PredictTextResult"),
               br(),
               br(),
               h4('All Predicted Results:'),
               dataTableOutput("PredictTextAllResult"),
               br(),
               br(),
               h4('Word Cloud:'),
               plotOutput("PredictTextAllResultPlot"),
               br(),
               br()                 
      )
    )
  )
)
)

