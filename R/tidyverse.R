#tidyverse carrega 5 pacotes
#dypkyr manipulação dataframe
# readr ler salvar no disco os arquivos
#forcats trabalhar com dados categoricos
#stringr identificar padrões em texto 
#ggplot2 criar gráficos
#tibble criar tibble (dataframes) e visualizar
#lubridate trabalhar com datas

library(tidyverse)

df <- tibble(x = 1:5, y = letters[1:5])
df # evitar fazer isso com base grande, usar glimpse

glimpse(df)
santander1 |> 
  sample_n(20) |> 
  glimpse()

#tirar raiz da soma de 1 a 10
x <- 1:10
y <- sum(x)
z <- sqrt(y)
z

z <- sqrt(sum(1:10))
z

z <- 1:10 |> 
  sum() |> 
  sqrt()
z

"mundial" |> 
  paste("palmeiras não tem")

?paste

"mundial" |> 
  paste("palmeiras não tem", ... = _)


"mundial" %>%
  paste("palmeiras não tem", .)

# dplyr equivalente do pandas no python

#select seleciona colunas
#filter filtrar linhas
#mutate adicionar ou alterar colunas
#summarize serve para agregar colunas
#group_by serve para aplicar as funções por grupo
#count serve para gerar frequencias de colunas
#arrange serve para ordenar a dataframe com base em uma ou mais colunas
# existem funções de join - juntar dataframes

# select
cjpg <- cjpg |> 
  select(-julgado) #apagando apenas o julgado

glimpse(cjpg)

cjpg <- cjpg |> 
  select(-c(1, pagina, hora_coleta, cd_doc, grupo)) #c(1,3,4) tb funcionaria
glimpse(cjpg)

df1 <- cjpg |> 
  select(processo,foro, magistrado)
glimpse(df1)

df2 <- cjpg |> 
  select(processo,distribuidor = foro, magistrado)
glimpse(df2)

glimpse(cjpg)

df3 <- cjpg |> 
  select(classe:magistrado)
glimpse(df3)

df4 <- cjpg |> 
  select(starts_with("c"))
glimpse(df4)

df5 <- cjpg |> 
  select(ends_with("o"))
glimpse(df5)

?select

cjpg <- cjpg |> 
  select(-c(1, pagina, hora_coleta, grupo, cd_doc))

library(dplyr,include.only = "filter") #incluir somente uma função
# dplyr::filter não precisa carregar o pacote inteiro
2+2 # o operador + e o pipe, sinal de atribuição também <- é um infix
#filter
classe <- cjpg |> 
  filter(classe == "Procedimento do Juizado Especial Cível")

duplicado <- cjpg |> 
  filter(duplicado)

duplicado <- cjpg |> 
  filter(duplicado == TRUE)

duplicado <- cjpg |> 
  filter(duplicado == 1)

duplicado <- cjpg |> 
  filter(duplicado >0)

duplicado <- cjpg |> 
  filter(duplicado != 0)

cjpg <- cjpg |> 
  mutate(n_comarca = nchar(comarca), .after = comarca)

n_comarca <- cjpg |> 
  filter(n_comarca == 9)

n_comarca <- cjpg |> 
  filter(n_comarca > 9, n_comarca <20)

n_comarca <- cjpg |> 
  filter(n_comarca >= 9, n_comarca <= 20) # pode ser o &

n_comarca <- cjpg |> 
  filter(n_comarca >= 9 & n_comarca <= 20)

n_comarca <- cjpg |> 
  filter(n_comarca > 9 | n_comarca <20) # | é um ou outro

disponibilizacao <- cjpg |> 
  filter(disponibilizacao > as.Date("2022-12-01")) #filtra data

#arrange odernar tabela

cjpg <- cjpg |> 
  arrange(comarca)

cjpg <- cjpg |> 
  arrange(comarca, magistrado)

cjpg <- cjpg |> 
  arrange(vara) # resultado com problema de colação

cjpg <- cjpg |> 
  arrange(str_sort(vara,numeric = TRUE))

cjpg <- cjpg |> 
  arrange(str_rank(vara,numeric = TRUE))

cjpg <- cjpg |> 
  arrange(n_comarca)


cjpg <- cjpg |> 
  arrange(desc(n_comarca)) #descendente

cjpg <- cjpg |> 
  mutate(magistrado = tolower(magistrado))

cjpg <- cjpg |> 
  arrange(comarca, magistrado)

#mutate

cjpg <- cjpg |> 
  mutate(foro = str_remove(foro, "Foro (de )?"))

#summarise

sumario <- cjpg |> 
  summarise(min_data = min(disponibilizacao), 
            max_data = max(disponibilizacao),
            median_data = median(disponibilizacao))

sumario <- cjpg |> 
  group_by(classe) |> 
  summarise(min_data = min(disponibilizacao), 
            max_data = max(disponibilizacao),
            median_data = median(disponibilizacao))
#count

classe <- cjpg |> 
  count(classe)

classe <- cjpg |> 
  count(classe, sort = TRUE)

classe_vara <- cjpg |> 
  count(classe, vara, sort = TRUE)

cjpg <- cjpg |> 
  mutate(decisao = tjsp::tjsp_classificar_sentenca(julgado))

vara_decisao <- cjpg |> 
  count(vara, decisao)


