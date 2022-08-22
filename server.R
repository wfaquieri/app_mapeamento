function(input, output, session) {
  showNotification("Aguarde...30 seg.",
                   duration = 30
  )
  
  
  # run

  
  tab = readRDS('tab_map_cons.rds')
  
  
  # Data Wrangling
  tab %<>% relocate(Status, .before = Familia) %>%
    relocate(Familia, .before = Retorno) %>%
    relocate(`Abert/Ampl`, .before = Obs.) %<>% 
    mutate(Data = Data %>% as.Date,
           Retorno = Retorno %>% as.Date)
  
  
  dt =
    datatable(
      tab,
      extensions = c('Responsive', 'Buttons'),
      caption = htmltools::tags$caption(
        style = 'caption-side: bottom; text-align: left;',
        htmltools::em('Tabela de Mapeamento de Empresas Consolidada.')
      ),
      options = list(
        server = T,
        language = list(url = '//cdn.datatables.net/plug-ins/1.10.11/i18n/Portuguese-Brasil.json'),
        dom = 'Bfrtip',
        buttons = list(
          "copy",
          list(
            extend = "collection",
            text = 'Download',
            action = DT::JS(
              "function ( e, dt, node, config ) {
                                    Shiny.setInputValue('csvs', true, {priority: 'event'});
}"
            )
          )
        ),
        columnDefs = list(list(
          targets = '_all', className = 'dt-center'
        ))
      ),
      rownames = FALSE,
      filter = 'top',
      class = 'compact nowrap'
    )
  
  output$dtable <- renderDT(dt)
  
  sendSweetAlert(
    session = session,
    "Concluido.",
    "Tabela de mapeamento criada com sucesso!",
    type = "success"
  )
  
  myModal <- function() {
    div(
      id = "csvs",
      modalDialog(
        br(),
        downloadButton("download2", "Excel"),
        easyClose = F,
        title = "Download",
        footer = modalButton("Fechar"),
        size = c("m", "s", "l")
      ),
    )
  }
  
  observeEvent(input$csvs, {
    showModal(myModal())
  })
  
  output$download2 <- downloadHandler(
    filename = function() {
      paste("mapeamento-", Sys.Date(), ".csv", sep = "")
    },
    
    content = function(file) {
      sendSweetAlert(
        session = session,
        "Baixando...",
        "Aguarde o download dos dados.",
        type = "info"
      )
      
      write.csv2(tab, file)
      
      
    }
    
    
  )
  
  
  # Empresas mapeadas por Job (mês anterior)
  output$table1 <- renderDT(
    tab %>% mutate(
      mes = month(Data),
      ano = year(Data)) %>% filter(mes==mes_anterior,ano==ano_anterior) %>% 
      group_by(Job) %>% 
      summarise(
        n = n_distinct(CNPJ) 
      ) %>% arrange(desc(n)),
    extensions = c('Buttons'),
    options = list(
      buttons = c('copy', 'excel'),
      lengthChange = FALSE,
      paging = FALSE,
      searching  = F,
      columnDefs = list(list(
        className = 'dt-center',
        targets = "_all"
      )),
      dom = 'Bft'
    ),
    caption = "Rank - Empresas distintas por Job (mês anterior)."
  )
  
  # Status por Job (mês anterior).
  output$table3 <- renderDT(
    tab %>% mutate(
      mes = month(Data),
      ano = year(Data)) %>% filter(mes==mes_anterior,ano==ano_anterior) %>% 
      group_by(Job) %>% 
      summarise(
        n = n_distinct(CNPJ) 
      ),
    extensions = c('Buttons'),
    options = list(
      buttons = c('copy', 'excel'),
      lengthChange = FALSE,
      paging = FALSE,
      searching  = F,
      columnDefs = list(list(
        className = 'dt-center',
        targets = "_all"
      )),
      dom = 'ft'
    ),
    caption = "Quantitativo - Empresas distintas mapeadas por Job (mês anterior)."
  )
  
  output$table2 <- renderDT(
    tab %>% mutate(
      mes = month(Data),
      ano = year(Data)) %>% filter(mes==mes_anterior,ano==ano_anterior) %>% 
      count(Empresa,Job) %>% 
      arrange(desc(n)),
    extensions = c('Buttons'),
    options = list(
      buttons = c('copy', 'excel'),
      lengthChange = FALSE,
      paging = FALSE,
      searching  = F,
      columnDefs = list(list(
        className = 'dt-center',
        targets = "_all"
      )),
      dom = 'Bft'
    ),
    caption = "Rank - Empresas mapeadas por Job (mês anterior)."
  )
  
  # Status por Job (mês anterior).
  output$table3 <- renderDT(
    tab %>% mutate(
      mes = month(Data),
      ano = year(Data)) %>% filter(mes==mes_anterior,ano==ano_anterior) %>% 
      count(Status,Job) %>% 
      arrange(desc(n)),
    extensions = c('Buttons'),
    options = list(
      buttons = c('copy', 'excel'),
      lengthChange = FALSE,
      paging = FALSE,
      searching  = F,
      columnDefs = list(list(
        className = 'dt-center',
        targets = "_all"
      )),
      dom = 'Bft'
    ),
    caption = "Rank - Status por Job (mês anterior)."
  )
  
  # Itens por Job (mês anterior)
  # output$table3 <- renderDT(
  #   tab %>% mutate(
  #     mes = month(Data),
  #     ano = year(Data)) %>% filter(mes==mes_anterior,ano==ano_anterior) %>% 
  #     count(Job) %>% arrange(desc(n)),
  #   extensions = c('Buttons'),
  #   options = list(
  #     buttons = c('copy', 'excel'),
  #     lengthChange = FALSE,
  #     paging = FALSE,
  #     searching  = F,
  #     columnDefs = list(list(
  #       className = 'dt-center',
  #       targets = "_all"
  #     )),
  #     dom = 'ft'
  #   ),
  #   caption = "Rank - Itens por Job (mês anterior)."
  # )
}