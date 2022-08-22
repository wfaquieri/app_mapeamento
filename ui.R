
# ui ----------------------------------------------------------------------

logo = "https://portal.fgv.br/sites/portal.fgv.br/themes/portalfgv/logo.png"

ui <- shiny::navbarPage(
  title = div(
    img(
      src = logo,
      style = "margin-top: -14px;
                  padding-right:10px;
                  padding-bottom:10px",
      height = 50
    )
  ),
  windowTitle = "MAPEAMENTO EMPRESAS",
  
  
  #MAIN TAB~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  tabPanel("Mapeamento Empresas", DT::DTOutput("dtable")),
  # tabPanel("Summary", verbatimTextOutput("summary")),
  tabPanel("Ranking", 
           fluidRow(
             column(4,DT::DTOutput("table1")), 
             column(4,DT::DTOutput("table2")),
             column(4,DT::DTOutput("table3"))
           )
  )
  
)
