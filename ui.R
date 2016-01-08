
library(ggvis)

shinyUI(fluidPage(
  br(),
  titlePanel(img(src="logo_bmrb.jpg",height=120,width=120,align="left")),
  titlePanel(h1("Biological Magnetic Resonance Data Bank",align="center")),
  titlePanel(h2("Simulated ",HTML(paste(tags$sup(1),"H-",sep="")),HTML(paste(tags$sup(15),"N",sep=""))," HSQC spectra from BMRB",align="center",style = "color:black")),
  br(),
  br(),
  tags$head(tags$style("#status1{color:red")),
  fluidRow(
    column(6,textInput("bmrbId",label="BMRB ID (single ID or list in csv)",value="17074,17076,17077")),
    column(6,textOutput("status1"))
    #column(4,actionButton("goButton",label=strong("Update"))),
    #column(4,checkboxInput("line",label=strong("Connet them by Comp_index_ID"),value=F))
  ),

  fluidRow(
    column(12,
           ggvisOutput("plot1"))

  ),
  fluidRow(
    column(6,actionButton("goButton",label=strong("Update"))),
    column(6,checkboxInput("line",label=strong("Connet them by Comp_index_ID"),value=F))
  )
))

