library(tidyverse)
library(tjsp)
cjpg <- union(santander1,santander2)
rm(santander1,santander2)
glimpse(cpopg_dados)
cpopg_dados <- cpopg_dados |> 
  mutate(valor_da_acao = numero(valor_da_acao))
hist(cpopg_dados$valor_da_acao)
hist(log(cpopg_dados$valor_da_acao))
mean(cpopg_dados$valor_da_acao,na.rm = TRUE)
median(cpopg_dados$valor_da_acao, na.rm = TRUE)
cpopg_dados <- cpopg_dados |> 
  distinct(processo, valor_da_acao, .keep_all = TRUE)
mean(cpopg_dados$valor_da_acao,na.rm = TRUE)
median(cpopg_dados$valor_da_acao, na.rm = TRUE)

mean(log(cpopg_dados$valor_da_acao),na.rm = TRUE)
median(log(cpopg_dados$valor_da_acao), na.rm = TRUE)
log2(16)
2^4
log2(1024)
glimpse(cjpg)
cjpg |> 
  count(classe, sort = TRUE) |> 
  View()
cjpg <- cjpg |> 
  filter(classe == "Procedimento Comum Cível" | classe == "Procedimento do Juizado Especial Cível")
cjpg |> 
  count(classe, sort = TRUE) |> 
  View()
cjpg |> 
  count(assunto, sort = TRUE) |> 
  View()
cjpg <- cjpg |> 
  mutate(assunto = case_when(
    assunto == "Bancários" ~ "Contratos Bancários", 
    TRUE ~ assunto
  ))
cjpg |> 
  count(assunto, sort = TRUE) |> 
  View()
cjpg <- cjpg |> 
  group_by(assunto) |> 
  filter(n()>900)

cjpg <- cjpg |> 
  mutate(classe2 = str_remove_all(classe, "[^A-Z]+"), .after = classe)

julgado <- julgado |> 
  mutate(decisao = tjsp_classificar_sentenca(principal))

cjpg <- cjpg |> 
  select(processo,classe = classe2, assunto)
glimpse(cjpg)

cpopg_dados |> 
  count(juiz, sort = TRUE) |> 
  View()

glimpse(cpopg_dados)

cpopg_dados <- cpopg_dados |> 
  select(processo, dt_distribuicao = distribuicao, valor_da_acao)
glimpse(cpopg_dados)

cpopg_dados <- cpopg_dados |> 
  mutate(dt_distribuicao = str_sub(dt_distribuicao, start = 1, end = 10) |> 
           dmy())
glimpse(cpopg_dados)

glimpse(cpopg_partes)

requerido <- cpopg_partes |> 
  filter(str_detect(tipo_parte, "(?i)Reqd"))

glimpse(julgado)

julgado <- julgado |> 
  select(processo, dt_decisao = data, decisao)


