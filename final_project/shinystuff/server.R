#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(jsonlite)
library(tidyverse)

source("useThis.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    passStateData<-reactive({ 
        stateData<-combined_data %>% filter(state == input$stateSelect)
        return(stateData)
    })
    
    output$casesTrendPlot <- renderPlot({
        ggplot(passStateData(), mapping=aes(x=as.Date(date)))+
            geom_line(aes(y = cases)) +
            labs(x="Date", y="cases", title=paste0("netapproval and cases over time for ",input$stateSelect))
    })
    
    output$approvalTrendPlot <- renderPlot({
        ggplot(passStateData(), mapping=aes(x=as.Date(date)))+
            geom_line(aes(y = net_approval)) +
            labs(x="Date", y="Net Approval and log(Cases)", title=paste0("netapproval and cases over time for ",input$stateSelect))
    })
    
    output$corr_coeff <- reactive({
        corr<-(as.double((correlation_between_cases_net_approval %>% filter(state==input$stateSelect))$corr))
        return(paste("correlation coeff between net approval and cases is:", corr))
    })

    # output$distPlot <- renderPlot({
    # 
    #     # generate bins based on input$bins from ui.R
    #     x    <- faithful[, 2]
    #     bins <- seq(min(x), max(x), length.out = input$bins + 1)
    # 
    #     # draw the histogram with the specified number of bins
    #     hist(x, breaks = bins, col = 'darkgray', border = 'white')
    # 
    # })

})
