

# run

tab =
  openxlsx::read.xlsx(
    "data-raw/Mapeamento-EPE.xlsx",
    detectDates = T,
    cols = c(1:20)
  ) |>
  mutate(Origem = "EPE") |>
  select(
    Origem,
    Analista = 1,
    Data = 2,
    Job = 3,
    Elementar = 4,
    Familia = 5,
    UF_Preco = 9,
    `Abert/Ampl` = 10,
    BP = 11,
    UF_Escritorio = 12,
    Coletor = 13,
    Empresa = 14,
    CNPJ = 15,
    Status = 18,
    Retorno = 19,
    Obs. = 20
  ) |>  mutate(
    Data = as.Date(Data),
    Retorno = as.Date(Retorno),
    Elementar = as.character(Elementar)
  )


cat("mapdf_1 ok! \n")



tab |> saveRDS('tab_map_cons.rds')

rm(list = ls())
