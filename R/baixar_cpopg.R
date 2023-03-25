# processos <- union(santander1$processo,santander2$processo) 
# saveRDS(processos,"data/processo_santander.rds")
processos <- readRDS(here::here("data/processo_santander.rds"))
processos <- split(processos, ceiling(seq_along(processos)/1000))
purrr::walk(processos,~{
  tjsp::tjsp_autenticar()
  tjsp::tjsp_baixar_cpopg(.x,diretorio =  here::here("data-raw/cpopg")) #.x para interar cada grupo de 1000
  
})
library(tjsp)
arquivos <- list.files("data-raw/cpopg", full.names = TRUE)
dados <- tjsp_ler_dados_cpopg(arquivos)
partes <- tjsp_ler_partes(arquivos)
movimentacao <- tjsp_ler_movimentacao(arquivos)

library(JurisMiner)
movimentacao <- movimentacao |> 
  tempo_movimentacao()

library(tidyverse)
tempo_processo <- movimentacao |> 
  group_by(processo) |> 
  summarize(tempo = max(decorrencia_acumulada))

partes |> 
  count(tipo_parte)

partes <- partes |> 
  filter(str_detect(tipo_parte,"^Req"))

partes <- partes |> 
  mutate(tipo_parte = case_when(
    str_detect(tipo_parte, "d") ~ "reqd",
    TRUE ~ "reqt"
  ))

p <- partes |>
  select(processo, tipo_parte, parte) |> 
  pivot_wider(names_from = "tipo_parte", values_from = "parte")

santander <- partes |> 
  filter(tipo_parte == "reqd", str_detect(parte,"(?i)santander"))

dados <- dados |> 
  semi_join(santander, by = "processo")

arquivos <- list.files("data-raw/cpopg", full.names = TRUE)

cpopg_dados <- tjsp_ler_dados_cpopg(arquivos = arquivos)

cpopg_partes <- tjsp_ler_partes(arquivos = arquivos)

cpopg_movimentacao <- tjsp_ler_movimentacao(arquivos = arquivos)

cpopg_movimentacao <- cpopg_movimentacao |> 
  separate(movimentacao, into = c("principal", "detalhamento"), sep = "\\s{3,}", extra = "merge")

julgado <- cpopg_movimentacao |> 
  filter(str_detect(principal, "(?i)^julgad[ao]"))

incidentes <- tjsp_ler_tabela_incidentes(arquivos = arquivos[1:100])




processos <- readRDS(here::here("data/processo_santander.rds"))
objeto <- setdiff(processo,cpopg_dados$processo)



objeto <- split(objeto, ceiling(seq_along(objeto)/1000))
purrr::walk(objeto,~{
  tjsp::tjsp_autenticar()
  tjsp::tjsp_baixar_cpopg(.x,diretorio =  here::here("data-raw/cpopg")) #.x para interar cada grupo de 1000
  
}) # rodar mais tarde


