# This syntax file is for reading the csv file for mplus analyses, then
#      dropping a char var and creating two lagged interaction terms,
#      then reading out a .dat file for mplus
#               redoing this on 12 Sept 2020 to include controls and exclude attn check failures
# After this step, to prep for analysis, I open .csv file in excel, delete missing obs, remove colnames

library(tidyverse)

#df <- read.csv("experiments/study2-prolific/data/200813_Longformat.csv")
df <- read.csv("experiments/study2-prolific/data/200908_Longformat.csv")

df$newhours <- as.numeric(substr(df$HOW, start=1, stop=2))

#subset to remove attention check failures
df <- subset(df, df$Attention_check_1 == "4" & df$Attention_check2 == "4")

 df <- mutate (df, int_lag= Meanval1* lag(Meanval1))
 df <- mutate (df, int_fwd= Meanval1* lead(Meanval1))

 write.csv(df,file = "../Full-study-prolific/data/prolific-mplus-attchecks.csv")

 # version 2 - because different interactvar

#df2 <- read.csv("experiments/study2-prolific/data/200813_Longformat.csv")
 df2 <- read.csv("experiments/study2-prolific/data/200908_Longformat.csv")

 df2$newhours <- as.numeric(substr(df2$HOW, start=1, stop=2))

 #subset to remove attention check failures
 df2 <- subset(df2, df2$Attention_check_1 == "4" & df2$Attention_check2 == "4")

 df2  <- mutate (df2, int_lag= statval* lag(statval))
 df2 <- mutate (df2, int_fwd= statval* lead(statval))

 write.csv(df2,file = "../Full-study-prolific/data/prolific-mplus-statval-attchecks.csv")
