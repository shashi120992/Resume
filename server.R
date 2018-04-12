library(shiny)
library(shinydashboard)
library(plotly)
library(wordcloud)
library(bubbles)
library(DT)
library(rmarkdown)
library(c3)
library(timevis)

server <- function(input, output) {
 
  
  #sample gezplot
  output$gaz <- renderC3({
    donut.chart <- data.frame("Predictive modelling"=20,"Importing and cleaning data sets"=20,"visualisation & tabular presentation"=10,"R markdown"=10,"R Shiny"=10,"Healthcare related data analysis"=30) %>% 
      c3(colors=list("Predictive modelling"='hotpink',"Importing and cleaning data sets"='turquoise',"visualisation & tabular presentation"='slateblue',"R markdown"='gold',"R Shiny"='tomato',"Healthcare related data analysis"='cyan2')) %>% 
      c3_donut()
  })
  

  
  #education
  #Data
  tab1 <- data.frame(Year<-c("2008","2008-2010","2010-2013","2013-2015"),
                     passyear<-c(2008,2010,2013,2015),
                     Course<-c("S.S.L.C","P.U.C","Bacholer Of Science (B.Sc)","Master Of Science (M.Sc)"),
                     collage<-c("Jawahar Navodaya Vidyalaya","Jawahar Navodaya Vidyalaya","Bandarkars' collage kundapura","Mangalore university"),
                     percent<-c(76,66,80,70))
  #plot
  output$myplot <- renderPlotly({plot_ly(tab1,
                                         x=~passyear,y=~percent,
                                         type = 'scatter', 
                                         mode = 'lines+markers',
                                         line = list(shape = "spline",
                                                     color = 'rgba(49,130,189, 1)', width = 3),
                                         marker = list(color = 'rgba(49,130,189,1)', size = 12))
                                        })
  
  #table
  output$table <- DT::renderDataTable(tab1,
                                      colnames = c('Duration', 'Year of Passing', 'Name Of the Course', 'Name of the Collage', 'Percentage Obtained'),options = list(
    dom = 't',
    initComplete= JS("function(settings, json) {",
                     "$(this.api().table().header()).css({'background-color': '#000', 'color': '#fff'});",
                     "}")
    
  )
  )
  
  #statistical skills
  
  output$statplot <- renderPlot({
    
    stattab<-data.frame( statskills<-c("Statistical modeling","Designs of Experiments (DOE)","Power and sample size analysis","Multivariate data analysis","Time series analysis","Quality control tools","Operational research","Supervised Learning","Regression Analysis","Generalized Linear Model","Decision Trees","Cluster And segmentation","Factor Analysis","Principle component analysis"),
                         statval<-c(48,47,46,45,44,43,42,41,40,39,38,37,36,35))
    
    wordcloud(stattab$statskills, stattab$statval ,scale=c(1.1,0.7),
              min.freq = 1, max.words=50,random.order = TRUE,
              colors=brewer.pal(8, "Dark2"))
              })
    
  #SAS 
  #SAS Data
  bbl1code<-c("LNM","MER","SET","EXD","SLT","DEL","MOD","KEP","PCR","EXP","FRQ","GLM","IMPT","LOG","MNS","PRT","RPT","SQL","TAB","TSP")
  bbl1name<-c("LIBNAME","MERGE","SET","EXCLUDE","SELECT","DELETE","MODIFY","KEEP","PROC COMPARE","PROC EXPORT","PROC FREQ","PROC GLM","PROC IMPORT","PROC LOGISTIC","PROC MEANS","PROC PRINT","PROC REPORT","PROC SQL","PROC TABULATRE","PROC TRANSPOSE")
  bbl1val<-c(13,22,8,23,10,14,21,21,8,20,24,6,14,11,23,6,8,9,16,12)
  bbl1<-data.frame(bbl1code,bbl1name,bbl1val)
  bbl2<-data.frame(bbl1code,bbl1name)
  
  #sas plot
  output$bblplot <- renderBubbles({
      bubbles(bbl1$bbl1val,bbl1$bbl1code,key = bbl1$bbl1code)
      })
    
 #SAS table
output$bbltable <- DT::renderDataTable(bbl2, colnames = c('Code', 'Name'),options = list(
  list(visible=FALSE, targets=bbl1val),
  dom = 'tip',
  initComplete= JS("function(settings, json) {",
                   "$(this.api().table().header()).css({'background-color': '#000', 'color': '#fff'});",
                   "}")
))

  #Timeline
  output$timeline <- renderTimevis({
    data <- data.frame(
      id      = 1:9,
      content = c("S.S.L.C (77%)","Higher Secondory","P.U.C (67%)","Bacholer  Of Science (B.Sc)","B.Sc compilited (80%)","Mastor Of Science (M.Sc)"," M.Sc complited (70%)","Started working","Presently working as Statistician"),
      start   = c("2008-05-31","2008-06-1","2010-05-31","2010-06-1","2013-05-31","2013-06-1","2013-05-31","2015-01-1","2015-11-1"),
      end     = c(NA,"2010-05-31",NA,"2013-05-31",NA,"2013-05-31",NA,NA,"2017-11-30")
    )
    timevis(data)
  })
#programming skills
  output$prgmcht <-renderPlotly({
    
    prmpl<-data.frame(
      nm <- c("R","SAS","SPSS","Excel(Macro)","Python","H.T.M.L"),
      vl1 <- c(90,80,80,70,70,60),
      vl2 <- c(10,20,20,30,30,40)
    )
    
    plot_ly(x = ~vl1, y = ~nm,type = 'bar', orientation = 'h')%>%
      add_trace(x = ~vl2, y = ~nm,type = 'bar', orientation = 'h',marker = list(color = 'rgba(128, 128, 128, 0.4)'))%>%
      layout(xaxis = list(title = "",
                          showgrid = FALSE,
                          showline = FALSE,
                          showticklabels = FALSE,
                          zeroline = FALSE,
                          domain = c(0.15, 1)),
             yaxis = list(title = "",
                          showgrid = FALSE,
                          showline = FALSE,
                          zeroline = FALSE,
                          font = list(size = 20),
                          bold= TRUE
                          ),
             barmode = 'stack',
             showlegend = FALSE,
             autosize = F, width = 500, height = 250
             )
  })

         
  
  
  
}
