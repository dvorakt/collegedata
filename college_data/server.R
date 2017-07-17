
library(shiny)
library(tidyverse)
library(ggvis)

plot <- read_csv("C:/Users/dvorakt/Documents/research/shiny/college search/www/plot.csv")

shinyServer(function(input, output) {
  data <- reactive({
    data <- plot
    data <- filter(data, CONTROL %in% input$ownershiptype)
    data <- filter(data, type %in% input$type)
    #data <- filter(data, (is.na(online) == input$online) | (!is.na(online) == input$online))
    #print(input$online)
    #if(!input$online){data <- filter(data, is.na(online))}
    #else{}
    
    })

 tooltip <- function(x) {
    if (is.null(x)) return(NULL)
    all <- plot
    tip <- all[all$UNITID == x$UNITID, ]
    paste0("<b>", tip$INSTNM, "</b> <br>",tip$type)
    }
 
 viz <- reactive({
  xvar <- prop("x", as.symbol(input$xvar))
  yvar <- prop("y", as.symbol(input$yvar))
  colorvar <- prop("fill", as.symbol(input$colorvar))
  sizevar <- prop("size", as.symbol(input$sizevar))
  
  data() %>% 
    ggvis(x=xvar, y=yvar,  fill=colorvar, size=sizevar, key := ~UNITID) %>%
    layer_points() %>%
    add_tooltip(tooltip) %>%
    add_legend("fill") %>%
    add_legend("size") %>%
    set_options(width="100%", height="100%")
  })
 viz %>% bind_shiny("viz")
})
  
