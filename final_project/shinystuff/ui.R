#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(DT)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("What Covid Thinks About the President?"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "stateSelect", # Different input
                        label = "Choose state to display",
                        choices=c("alabama","alaska","arizona","arkansas","california","colorado","connecticut","delaware","florida","georgia","hawaii","idaho","illinois","indiana","iowa","kansas","kentucky","louisiana","maine","montana","nebraska","nevada","new_hampshire","new_jersey","new_mexico","new_york","north_carolina","north_dakota","ohio","oklahoma","oregon","maryland","massachusetts","michigan","minnesota","mississippi","missouri","pennsylvania","rhode_island","south_carolina","south_dakota","tennessee","texas","utah","vermont","virginia","washington","west_virginia","wisconsin","wyoming"),
                        multiple=FALSE
            ), # End of selectInput
            
            sliderInput("dateSelect",
                        "Data from date:",
                        min = as.Date("2020-01-20","%Y-%m-%d"),
                        max = as.Date("2020-04-30","%Y-%m-%d"),
                        value=as.Date("2020-04-29","%Y-%m-%d"),
            ), # End of sliderInput
            
            helpText(textOutput("dayData")),
            
            
            
            # sliderInput("bins",
            #             "Number of bins:",
            #             min = 1,
            #             max = 50,
            #             value = 30),
            helpText(                     "Table 1 illustrates change in the net approval in the state from the first incident of covid-19 to April 30th. Net approval is measured by subtracting disapproval rate to the approval rate.",
                                          br(),
                                          
                     "Table 2 shows the increase in the number of cases from the first incident of covid-19 to April 30th in the state.",
                     br(),
                     "Table 3 shows the change in death rate over time in the state. It implies the fatality of Coronavirus in the States and potentially evaluate the effectiveness of the state government responding to the Covid-19.",
                     #  br(),
                     #   "Table 4",
                     #  br(),
                     # "")

            ),
        ),



        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("approvalTrendPlot"),
            plotOutput("casesTrendPlot"),
            plotOutput("mortalityTrendPlot"),
            helpText(textOutput("casesApproval_corr_coeff")),
            helpText(textOutput("deathsApproval_corr_coeff")),
            hr(),
            h2("The Process"),
            h4("Getting the Approval Data"),
            p(
                "We got the job approval data for Trump by state and over time from:",
                 br(),
                a("https://civiqs.com/results/approve_president_trump?annotations=true&uncertainty=true&zoomIn=true"),
                br(),
                "where we manual scraped json files for each state. We compiled all the data into a single dataframe",
              
            ),
            
            h4("Getting the Covid-19 Data"),
            p(
                "We got the covid-19 data for states over time from:",
                br(),
                a("https://raw.githubusercontent.com/jakevdp/data-USstates/master/state-population.csv"),
                br(),
                "where we found the cases, deaths, and rates for states over time",
            ),
            
            h4("Combining the Data"),
            p(
                "The data was then combined into the following dataframe:",
                DT::dataTableOutput("approvalDT")
            ),
            p(
                "The graphs above use data from this data frame"
            ),
            
        )
    )
))
