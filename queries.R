install.packages('DBI')
install.packages('RMySQL')
install.packages('dplyr')
install.packages('ggplot2')
library(ggplot2)
library(dplyr)
library(DBI)
library(RMySQL)

db <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = 'guest',
  password = 'guest')

dbListTables(db)

dbListFields(db, "CountryLanguage")

df.db <- dbGetQuery(db, "select * from CountryLanguage")

head(df.db)

spanish <- df.db %>% filter( Language == "Spanish") 

head(spanish)
class(spanish)
str(spanish)
spanish <- mutate(spanish, IsOfficial = factor(IsOfficial))

ggplot(spanish, aes(x = Percentage, y = CountryCode, fill = IsOfficial)) +
  geom_bar(stat = "identity", position = "dodge") +
  ggtitle('Porcentaje de paises que hablan español') +
  theme_light() 
 
