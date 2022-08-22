#    .-----------------------------------------------------.
#    | FGV  - Fundacao Getulio Vargas                      |
#    | IBRE - Instituto Brasileiro de Economia             |
#    | SPDO - Equipe de Mineração de Dados                 |
#    | Data inicial : 07/08/2021                           |
#    | ID do codigo : appMAPEAMENTO                        |
#    | versao       : 1.01                                 |
#    | Responsavel  : Winicius B Faquieri                  |
#    | Email        : winicius.faquieri@fgv.br             |
#    '-----------------------------------------------------'



# Carregar pacotes da pasta do projeto
.libPaths("R/R-4.1.0/library")

# Exibir mensagem de erro
options(shiny.sanitize.errors = F)

.libPaths("C:/Program Files/R/R-4.2.1/library")

# Carregar pacotes
library(shiny)
library(DT)
library(bslib)
library(shinyWidgets)
library(readxl)
library(openxlsx)
library(magrittr)
library(dplyr)
library(purrr)
library(janitor)
library(vroom)
library(lubridate)


# load
source('src/map_df.R', encoding = 'UTF-8')


# Apagar pasta de cache que é criada automaticamente 
# (gostariamos que nao fosse criada, é involuntario)
# unlink("LOCAL_APPDATA_FONTCONFIG_CACHE", recursive = T)

mes_anterior = month(today()-months(1))
ano_anterior = year(today()-months(1))


