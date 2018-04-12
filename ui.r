library(shiny)
library(shinydashboard)
library(plotly)
library(wordcloud)
library(bubbles)
library(DT)
library(rmarkdown)
library(c3)
library(timevis)


ui <- dashboardPage(
  dashboardHeader(title ="RESUME",
                  dropdownMenu(type = "messages"),
                  dropdownMenu(type = "notifications"),
                  dropdownMenu(type = "tasks")
  ),
  dashboardSidebar(
    sidebarUserPanel("Shashikanth Bhat",
                     subtitle = a(href = "#", "Statistician"),
                     image = "SHASHIKANTH BHAT.png"
    ),
    #TAB ITEMS
    sidebarMenu(
      #contactmenu
      menuItem("contact", icon=icon("send", lib = "glyphicon" ), startExpanded = TRUE,
               menuSubItem("gmail", href="https://mail.google.com/mail/?view=cm&fs=1&to=shashi120992@gmail.com&su=SUBJECT&body=BODY", icon = icon("envelope", lib = "glyphicon"),selected = TRUE),
               menuSubItem("LinkedIn", href="https://www.linkedin.com/in/shashikanth-bhat-44376bb3", icon = icon("linkedin")),
               menuSubItem("+91 9886226207", icon=icon("earphone", lib = "glyphicon" ))),
    
      #dashboard menu
      menuItem("summary", tabName = "summary", icon = icon("dashboard")),
      menuItem("skils", tabName = "skills", icon = icon("refresh")),
      menuItem("work", tabName = "work", icon = icon("th")),
      menuItem("education", tabName = "education", icon = icon("calendar")),
      menuItem("code",tabName = "code",icon=icon("edit", lib = "glyphicon" )),
      menuItem("Resumes", icon=icon("save-file", lib = "glyphicon" ), startExpanded = TRUE,
               menuSubItem("infografic",tabName ="info" ,icon=icon("save-file", lib = "glyphicon" )),
               menuSubItem("C.V",tabName ="cv" ,icon=icon("save-file", lib = "glyphicon" )))
      
      
      
    )
  ),
  dashboardBody(
    #Dashboard Conternts
    tabItems(
      # dashboard tab content
      tabItem(tabName = "summary",
        fluidRow(
    # A static valueBox
    valueBox(2.3, h4("Expirience",br(), "(in Years)"), icon = icon("credit-card"),color = "red"),
    valueBox(25, h4("Age",br(),"(in Years)"), icon = icon("download"),color = "green"),
    valueBox(1, h4("No of compenies",br(),"handald"), icon("users"),color = "blue")
               ),
  timevisOutput("timeline"),
  fluidRow(
    box(title = "Professional Skills", width =6,
        plotlyOutput("prgmcht",width = "100%",height = "250px")
        ),
    box(title = "Intrests", width = 6,
        fluidRow(
          column(width = 4,
                 img(src = "statistics.png",width = "96Px",height = "96px"),
                 "STATISTICS" ),
          column(width = 4,
                 img(src = "books.png",width = "96px",height = "96px"),br(),
                 "BOOKS"),
          column(width = 4,
                 img(src = "music.png",width = "96px",height = "96px"),br(),
                 "MUSIC")),
    fluidRow(
      column(width = 4,
             img(src = "coocking.png",width = "96Px",height = "96px"),
             "COOKING" ),
      column(width = 4,
             img(src = "football.png",width = "96px",height = "96px"),br(),
             "FOOTBALL"),
      column(width = 4,
             img(src = "rubik.png",width = "96px",height = "96px"),br(),
             "RUBIK CUBE")),br())
    ),
  fluidRow(
    box(title = "reach me",width = 12,
        column(width = 3,
               a(img(src = "github.png",width = "96Px",height = "96px"),href = "https://github.com/shashi120992"
                )),
        column(width = 3,
               a(img(src = "gmail.png",width = "96Px",height = "96px"),href = "https://mail.google.com/mail/?view=cm&fs=1&to=shashi120992@gmail.com&su=SUBJECT&body=BODY"
               )),
        column(width = 3,
               a(img(src = "linkedin.png",width = "96Px",height = "96px"),href = "https://www.linkedin.com/in/shashikanth-bhat-44376bb3"
               )),
        column(width = 3,
               a(img(src = "facebook.png",width = "96Px",height = "96px"),href = "https://facebook.com/shashi120992"
               ))
        )
    
  )),

  # education tab content
  tabItem(tabName = "education",
          fluidRow(box(title="Educational Qualification",width=12,DT::dataTableOutput("table"))),
          fluidRow(plotlyOutput('myplot'))
  ),
  
  #skill tab contents
  tabItem(tabName = "skills",
    fluidRow(
      box(title = "Statistical Skills",width = 6,height = "400px", plotOutput('statplot',width = "100%", height = "300px")),
      box(title = "R Programming",width = 6,height = "400px",c3Output('gaz'))
            ),

    fluidRow(
        box(title = "SAS Programming",width = 8,height = "550px",bubblesOutput("bblplot",height = "500px")),
        box(width = 4,height = "550px",DT::dataTableOutput("bbltable"))
        )

  ),
  #work expirience tab
  tabItem(tabName = "work",
  includeMarkdown("www/workexp.rmd")
  ),
  
  #code panel
  tabItem(tabName = "code",
          fluidRow(
          tabBox(
            title = "First tabBox",width = 12,height = NULL,
             #The id lets us use input$tabset1 on the server to find the current tab
            id = "tabset1", 
            tabPanel("Ui.R",includeMarkdown("www/ui.rmd")),
            tabPanel("Server.R", includeMarkdown("www/server.rmd")),
            tabPanel("App.R",includeMarkdown("www/app.rmd")))
          )),
  tabItem(tabName = "info",
          tags$iframe(style="height:900px; width:100%; scrolling=yes", 
                      src="myinfo.pdf")),
          
  tabItem(tabName = "cv",
          tags$iframe(style="height:900px; width:100%; scrolling=yes", 
                      src="mycv.pdf")
          )
)))
