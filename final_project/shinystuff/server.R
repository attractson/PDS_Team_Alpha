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
library(DT)

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
            labs(x="Date", y="Cases", title=paste("Cases over time for", str_replace(input$stateSelect, "_", " ")))
    })
    
    output$approvalTrendPlot <- renderPlot({
        ggplot(passStateData(), mapping=aes(x=as.Date(date)))+
            geom_line(aes(y = net_approval)) +
            labs(x="Date", y="Net Approval", title=paste("Net approval over time for", str_replace(input$stateSelect, "_", " ")))
    })
    
    output$mortalityTrendPlot <- renderPlot({
        ggplot(passStateData(), mapping=aes(x=as.Date(date)))+
            geom_line(aes(y = death_rate)) +
            labs(x="Date", y="Death Rate(deaths/cases)", title=paste("Death rate over time for", str_replace(input$stateSelect, "_", " ")))
    })
    
    output$casesApproval_corr_coeff <- reactive({
        corr<-(as.double((correlation_between_cases_net_approval %>% filter(state==input$stateSelect))$corr))
        return(paste("correlation coeff between cases and net approval is:", corr))
    })
    
    output$deathsApproval_corr_coeff <- reactive({
        corr<-(as.double((correlation_between_deaths_net_approval %>% filter(state==input$stateSelect))$corr))
        return(paste("correlation coeff between deaths and net approval is:", corr))
    })
    
    output$dayData<-reactive({
        d<-combined_data %>% filter(state==input$stateSelect, as.character(date)==as.character(input$dateSelect)) %>%
            mutate(date=as.character(date))
        paste0("Date: ", d[1], "; Net Approval: ", d[3], "; Cases: ", d[5], "; Deaths:", d[6],
              "; Death Rate: ", d[7], "; Cases Percent Change: ", d[10], "; Deaths Percent Change: ", d[13],
              "; Approval Percent Change: ", d[16])
    })
    
    #output$dayData<-DT::renderDataTable({data.frame(c("1","2"), c("a","b"))})
    
    output$approvalDT<-DT::renderDataTable({combined_data})

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
