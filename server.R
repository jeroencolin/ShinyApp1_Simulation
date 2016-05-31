
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
  
  # You can access the value of the widget with input$slider1, e.g.
  output$TransactionFee.Income <- renderPrint({GetIncomeFromTransactionFee(input$Transaction.Treshold,input$Trans.1,input$Trans.2) })
  
  # You can access the values of the second widget with input$slider2, e.g.
  output$Transaction.fee1 <- renderPrint({ input$Trans.1 })
})

GetIncomeFromTransactionFee <- function(Treshold,fee1,fee2){
  Transactions %>% 
    summarise(sum(ifelse(Transaction<Treshold,fee1,fee2))) %>% as.numeric()
}
