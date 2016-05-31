library(AER)
library(dplyr)
data("CreditCard")

# Aux functions -----------------------------------------------------------
randomsumint <- function(nb, sum) {
  if(nb==1){
    return(sum)  
  }
  tmp <- sort(runif(nb-1))
  tmp <- c(min(tmp), diff(tmp), 1-max(tmp))
  res <- as.vector(quantile(0:sum, probs=tmp))
  res <- round(res)
  res[length(res)] <- res[length(res)]+(sum-sum(res))
  res
}

# Generate Mastercard Data ------------------------------------------------
CreditCard <- CreditCard %>% 
  mutate(CardholderID = row_number()) %>%
  select(CardholderID, age, income,share) %>%
  mutate(
    income = income*10000
  )
Transactions <- do.call("rbind",lapply(1:nrow(CreditCard),function(i) {
  print(i)
  Monthly_budget <- rnorm(12,CreditCard[i,]$share*CreditCard[i,]$income,CreditCard[i,]$share*CreditCard[i,]$income*0.2)
  Monthly_Transactions <- ceiling(rlnorm(12,meanlog = 1.8))
  do.call("rbind",lapply(1:12,function(j){
    Month <- seq(lubridate::dmy(paste0("01-",j,"-2016",tz="CET")),lubridate::dmy(paste0("30-",j,"-2016",tz="CET")),by="day")
    
    data.frame(
      CardholderID=i,
      age=CreditCard[i,]$age,
      Transaction = randomsumint(Monthly_Transactions[j],Monthly_budget[j]),
      Day=sample(Month,Monthly_Transactions[j],replace=TRUE),
      MerchantID=sample(1:500,Monthly_Transactions[j])
      )
  }))
}))

save(Transactions,file="Data/Transactions.RData")
  

 
