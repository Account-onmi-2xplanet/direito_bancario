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



