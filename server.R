library(shiny)
library(dplyr)
library(rworldmap)

Happiness <- read.csv("data/Happiness.csv")

Comp_Data <- select(Happiness, Country, Ladder) %>%
    mutate(Country=as.character(Country)) %>% 
    mutate(Country=replace(Country,Country=="Palestinian Territories","Palestine")) %>%
    mutate(Country=replace(Country,Country=="Taiwan Province of China","Taiwan")) %>% 
    mutate(Country=replace(Country, Country=="Hong Kong S.A.R., China","Hong Kong"))
colnames(Comp_Data)<-c("Country","National Happiness Score")

colourPalette <- RColorBrewer::brewer.pal(7,'OrRd')
finalmodel <- lm(Ladder ~ log(GDP)+PosAffect+Freedom+Support, data=Happiness)
sPDF <- joinCountryData2Map(Comp_Data, joinCode = "NAME",nameJoinColumn = "Country", verbose="TRUE")

server <- function(input, output, session) {
    
    output$map <- renderPlot({
        mapParams <- mapCountryData(sPDF, nameColumnToPlot = "National Happiness Score", 
                                    colourPalette = colourPalette,
                                    addLegend = FALSE)
        do.call(addMapLegend, c(mapParams, legendWidth=0.8, legendLabels="all",
                                legendShrink=0.6, sigFigs=2))
    })
    
    output$prediction <- renderText({
        input$recalc
        isolate(
        predict(finalmodel, newdata=data.frame(GDP=input$GDP,Support=input$Support,
                                                       Freedom=input$Freedom, PosAffect=input$PosAffect)) %>% 
            round(1))
        })
}
