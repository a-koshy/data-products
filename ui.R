ui <- fluidPage(
    titlePanel("National Happiness and Socio-Economic Factors"),
    
    sidebarLayout(position="right",
        sidebarPanel(
            h4("Choose a value for each factor:"),
            sliderInput(inputId="GDP", 
                        label="GDP per capita ($)", 
                        min=500, max=95000, value=13000),
            sliderInput(inputId="PosAffect",
                        label="Positive emotions from the previous day",
                        min=0, max=1, value=0.70),
            sliderInput(inputId="Freedom",
                        label="Freedom",
                        min=0, max=1, value=0.77),
            sliderInput(inputId="Support", 
                        label="Social support",
                        min=0, max=1, value=0.83),
            actionButton("recalc", "Predict")
        ),
        mainPanel(
            h3("Predicting national happiness"),
            p("The World Happiness Report 2017 contains data on 141 countries. For each country it records average national life satisfaction, GDP, life expectancy, and various other socio-economic factors. "),
            p("Using this data, we can build a model that uses 4 factors (GDP per capita, freedom, social support and positive affect in the previous day) to predict the national happiness level of a country. Choose values for each factor in the side panel and click 'Predict' to see the prediction."),
            hr(),
            p("Based on your inputs, the predicted happiness score of such a country, on a scale of 1 to 10, is:"),
            textOutput("prediction"),
            hr(),
            p("This map shows the national happiness score of countries across the world."),
            plotOutput("map")
        )
    )
)
