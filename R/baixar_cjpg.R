library(tjsp)
library(writexl)
library(readxl)
library(tidyverse)
library(genderBR)
library(abjutils)
?tjsp_baixar_cjpg
tjsp_baixar_cjpg(
  livre = "santander",
  aspas = FALSE,
  processo = "",
  foro = "",
  vara = "",
  classe = "",
  assunto = "",
  magistrado = "",
  inicio = "01/01/2022",
  fim = "31/12/2022",
  diretorio = "data-raw/cjpg"
)

tjsp_baixar_cjpg(
  livre = "santander",
  aspas = FALSE,
  processo = "",
  foro = "",
  vara = "",
  classe = "",
  assunto = "",
  magistrado = "",
  inicio = "01/01/2021",
  fim = "31/12/2021",
  diretorio = "data-raw/cjpg"
)

?tjsp_ler_cjpg
cjpg <- tjsp_ler_cjpg(diretorio = "data-raw/cjpg")
write_xlsx(cjpg, "data/cjpg.xlsx") # erro devido a limitação de tamanho do excel
write.csv2(cjpg, "data/cjpg.csv")

cjpg <- cjpg |> # cmd+shift+m cria pipe
  mutate(sexo = get_gender(rm_accent(magistrado)), .after = magistrado)
cjpg <- cjpg |> 
  mutate(sexo = ifelse(magistrado == "Sizara Corral de Arêa Leão Muniz Andrade", "Female", sexo))

?tjsp_autenticar
?tjsp_baixar_cpopg
tjsp_autenticar()
tjsp_baixar_cpopg(processos = cjpg$processo, sono = 1, diretorio = "data-raw/cpopg")
# exemplo criação de vetor 
# meus_processos <- c("10044934620218260655", "00013705720218260655")
# exemplo baixar processos do vetor criado anteriormente 
# tjsp_baixar_cpopg(processos = meus_processos, sono = 1, diretorio = "data-raw/meus_processos_folder")

arquivos_de_trabalho <- list.files("data-raw/cpopg", full.names = TRUE)
arquivos_de_trabalho
cpopg_dados <- tjsp_ler_dados_cpopg(arquivos = arquivos_de_trabalho)
cpopg_partes <- tjsp_ler_partes(arquivos = arquivos_de_trabalho)
cpopg_movimentacao <- tjsp_ler_movimentacao(arquivos = arquivos_de_trabalho)


library(tidyverse)
grupos <- cjpg |> 
  mutate(grupo = ntile(n = 20)) |> 
  group_split(grupo)
arquivos <- paste0("data/cjpg", 1:20, ".rds")

arquivos

walk2(arquivos, grupos, ~saveRDS(.y,.x))

#comentário adicionado após criar repositório