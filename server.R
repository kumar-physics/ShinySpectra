library(reshape2)
library(ggplot2)
library(ggvis)
library(shiny)

shinyServer(function(input, output) {

  # You can access the value of the widget with input$text, e.g.
  #output$value <- renderPrint({ input$bmrbId })
  bid<-reactive({
    input$goButton
    bbid<-isolate(input$bmrbId)
    hsqc<-N15HSQC(fetchBMRB(bbid))
    m<-as.data.frame(hsqc)
    m$key=NA
    m$key=sprintf("%d-%d-%d",m$BMRB_ID,m$Comp_index_ID,m$Assigned_chem_shift_list_ID)
    m$BMRB_ID=as.character(m$BMRB_ID)
    m$Comp_index_ID=as.character(m$Comp_index_ID)
    m$aa<-NA
    m$aa<-xx3to1(m$Comp_ID_H)
    m
  })

  bid_tooltip <- function(x) {
    if (is.null(x)) return(NULL)
    if (is.null(x$key)) return(NULL)

    # Pick out the movie with this ID
    all_bid <- isolate(bid())
    bid <- all_bid[all_bid$key == x$key, ]

    paste0("BMRB ID:",bid$BMRB_ID,
           "<br> Res Id:", bid$Comp_index_ID,
           "<br> Res Type :",bid$Comp_ID_H,
           "<br> H :",bid$H,
           "<br> N :",bid$N
    )
  }
  vis <- reactive({
    xvar <- prop("x", as.symbol("H"))
    yvar <- prop("y", as.symbol("N"))
    shapeval <- as.symbol("BMRB_ID")
    strokval <-  as.symbol("Comp_index_ID")
    if (input$line){
    bid %>%
      ggvis(~H,~N,stroke=strokval) %>%
      layer_points(stroke=shapeval,fill=shapeval,key := ~key)%>%
      #layer_text(stroke=shapeval,text:=~aa,key := ~key,fontSize := 15, fontSize.hover := 30)%>%
      layer_lines() %>%
      hide_legend("stroke")%>%
      #add_legend("fill")%>%
      #ggvis(x = xvar, y = yvar) %>%
    #mark_rect() %>%
    add_tooltip(bid_tooltip, "hover") %>%
        scale_numeric("x",reverse=T) %>%
        scale_numeric("y",reverse=T) %>%
    set_options(width = 1200, height = 600)
    }
    else{
      bid %>%
        ggvis(~H,~N,stroke=strokval) %>%
        #layer_lines(opacity = "opval") %>%
        #layer_points()%>%
        #hide_legend("stroke")%>%
        layer_text(stroke=shapeval,text:=~aa,key := ~key,fontSize := 15, fontSize.hover := 30)%>%
        #ggvis(x = xvar, y = yvar) %>%
        #mark_rect() %>%
        add_tooltip(bid_tooltip, "hover") %>%
        scale_numeric("x",reverse=T) %>%
        scale_numeric("y",reverse=T) %>%
        set_options(width = 1200, height = 600)
    }
  })

  vis2 <- reactive({
    xvar <- prop("x", as.symbol("H"))
    yvar <- prop("y", as.symbol("N"))
    shapeval <- as.symbol("Comp_ID_H")
    strokval <-  as.symbol("Comp_index_ID")
    bid %>%
      ggvis(~H,~N,stroke=strokval) %>%
      layer_lines() %>%
      #layer_points()%>%
      hide_legend("stroke")%>%
      layer_text(text:=~aa,key := ~key,fontSize := 15, fontSize.hover := 30)%>%
      #ggvis(x = xvar, y = yvar) %>%
      #mark_rect() %>%
      add_tooltip(bid_tooltip, "hover") %>%
      set_options(width = 1200, height = 1200)
  })


  vis %>% bind_shiny("plot1")


  output$xxx <- renderText({ nrow(bid()) })



})

