source("R/AnalyseDataset.R")

shinyUI(fluidPage(
  fluidRow(
    column(4,
      
      # Copy the line below to make a slider bar 
      sliderInput("Transaction.Treshold", label = h3("Transaction Treshold"), min = min(Transactions$Transaction), 
        max = max(Transactions$Transaction), value = 200)
    ),
    column(2,
      
      ## Copy the line below to make a number input box into the UI.
      numericInput("Trans.1", label = h4("Fee per Transaction below treshold [$]"), value = 0.2,step=0.1)
    ),
    column(2,
      
      ## Copy the line below to make a number input box into the UI.
      numericInput("Trans.2", label = h4("Fee per Transaction above treshold [$]"), value = 0.8,step=0.1)
    )
  ),
  
  hr(),
  fluidRow(
    column(8,h3("Income generated from the transaction fees [$]"))
  ),
  
  fluidRow(
    column(8, wellPanel(verbatimTextOutput("TransactionFee.Income")))
  )
  # mainPanel(
  #   h3(textOutput("Transaction.Treshold"))
  # ) 
))
