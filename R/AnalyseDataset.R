rm(list=ls(all=TRUE))

library(AER)
library(dplyr)

load(file = "Data/Transactions.RData")

Transactions <- Transactions %>% filter(Transaction > 0.01)
mean(Transactions$Transaction==0)



# Characterize Cardholders ------------------------------------------------
CardHolders <- Transactions %>% 
  filter(Transaction > 0) %>%
  group_by(CardholderID) %>%
  summarise(
    MonthlyExpenditure=sum(Transaction)/12,
    AverageExpenditure=mean(Transaction)
  )


# Characterize Merchants --------------------------------------------------
Merchants <- Transactions %>% 
  filter(Transaction > 0) %>%
  group_by(MerchantID) %>%
  summarise(
    MonthlyTransactions=sum(Transaction)/12,
    AverageTransactions=mean(Transaction),
    MaxTransactions = max(Transaction),
    MinTransactions = min(Transaction),
    NbTransactions = length(Transaction)
  ) 

Clusters <- kmeans(Merchants,3)
## Plot these clusters
palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
  "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))
plot(Merchants$AverageTransactions, Merchants$MaxTransactions,col=Clusters$cluster,pch = 22, cex = 1)
par(mar = c(5.1, 4.1, 0, 1))


# Simulation Model --------------------------------------------------------


