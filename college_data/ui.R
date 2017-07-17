# first cut of customizable scatterplots

library(shiny)
library(ggvis)

shinyUI(bootstrapPage(theme="bootstrap.css",
                      shinyjs::useShinyjs(),                      
                      tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  column(2,
    fluidRow(
     column(4,checkboxGroupInput("ownershiptype",label=NULL,
                                       c("Public"=1,"Private non-profit"=2, "Private for-profit"=3),
                                       selected=c(1,2,3))),
     column(5, checkboxGroupInput("type", label=NULL,
                                        c("Doctoral Universities","Master's Colleges","Baccalaureate Colleges", "Associate's Colleges"),
                                        selected=c("Doctoral Universities","Master's Colleges","Baccalaureate Colleges", "Associate's Colleges"))),
     column(3, checkboxInput("online", "Online Only", TRUE))
         ),
  selectInput("xvar", "X - variable:", 
      choices = c("Undergraduate size"="size_trimmed", 
                              "Selectivity"="selectivity", "Tuition and fees"="CHG1AY3",
                              "Net Price"="netprice", "Med Salary (6yrs after)"="salary", "Graduation rate" = "gr",
                              "Retention rate"= "RET_PCF")),
  selectInput("yvar", "Y - variable:", 
              choices = c("Undergraduate size"="size_trimmed", 
                          "Selectivity"="selectivity", "Tuition and fees"="CHG1AY3",
                          "Net Price"="netprice", "Med Salary (6yrs after)"="salary", "Graduation rate" = "gr",
                          "Retention rate"= "RET_PCF")),
  selectInput("sizevar", "Size variable:", 
              choices = c("Undergraduate size"="size_trimmed", 
                          "Selectivity"="selectivity", "Tuition and fees"="CHG1AY3",
                          "Net Price"="netprice", "Med Salary (6yrs after)"="salary", "Graduation rate" = "gr",
                          "Retention rate"= "RET_PCF")),
  selectInput("colorvar", "Color variable:", 
             choices = c("Type"="ownership","Level"="type", "Testing"="testing"))),
  column(10,  
  ggvisOutput("viz"))
)
)
