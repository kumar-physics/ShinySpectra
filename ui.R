
library(ggvis)

shinyUI(fluidPage(
  br(),
  titlePanel(h1("Simulated 1H-15N HSQC spectra from BMRB",align="center",style = "color:black")),
  br(),
  fluidRow(
    column(4,textInput("bmrbId",label="BMRB ID (single ID or list in csv)",value="17074,17076,17077")),
    column(4,actionButton("goButton",label=strong("Update"))),
    column(4,checkboxInput("line",label=strong("Connet them by Comp_index_ID"),value=F))
  ),

  fluidRow(
    column(12,
           ggvisOutput("plot1"))
    
  )
))

