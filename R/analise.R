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
julgado2 <- julgado
julgado <- julgado2

rm(julgado2)
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

basefinal <- cjpg |> 
  inner_join(cpopg_dados, join_by(processo)) |> 
  inner_join(julgado, join_by(processo))

basefinal <- basefinal |> 
  distinct()

basefinal <- basefinal |> 
  mutate(duracao = lapso(dt_distribuicao, dt_decisao))

basefinal <- basefinal |> 
  ungroup()

basefinal |> 
  count(decisao, sort = TRUE) |> 
  View()

basefinal <- basefinal |> 
  mutate(decisao = case_when(
    decisao == "parcial" ~ "procedente",
    TRUE ~ decisao
  ))

basefinal <- basefinal |> 
  mutate(across(c(classe,assunto,decisao), .fns = as.factor))

basefinal |> 
  count(assunto)

cjpg |> 
  count(assunto)

#regressão logistica
modelo <- glm(decisao ~ classe+assunto+log(valor_da_acao)+duracao, data = basefinal, family = binomial("logit") )
summary(modelo)
preditos <- predict(modelo, basefinal, type = "response")
preditos

basefinal$prob <- preditos

basefinal <- basefinal |> 
  mutate(predito = ifelse(prob >0.7, "procedente", "improcedente"))

basefinal |> 
  count(decisao,predito)

basefinal |> 
  count(classe,decisao)

install.packages("caret")
library(caret)
basefinal <- basefinal |> 
  drop_na()

basefinal <- basefinal |> 
  mutate(predito = as.factor(predito))

cm <- confusionMatrix(basefinal$predito,basefinal$decisao, mode = "everything")
cm

modelo2 <- rpart::rpart(decisao ~ classe+assunto+log(valor_da_acao)+duracao, data = basefinal)
summary(modelo2)
plot(modelo2)

library(tree)
install.packages("tree")
library("tree")

modelo3 <- tree(decisao ~ classe+assunto+valor_da_acao+duracao, data = basefinal)
summary(modelo3)
plot(modelo3)

preditos <- predict(modelo3, basefinal)

count(basefinal,decisao) |> 
  mutate(p = n/sum(n))

basefinal |> 
  count(classe,decisao) |> 
  group_by(classe) |> 
  mutate(p = n/sum(n))

modelo4 <- tree(decisao ~ classe+assunto+duracao, data = basefinal)
summary(modelo4)
plot(modelo4)


basefinal |> 
  ggplot(aes(x = classe, fill = classe)) + 
  geom_bar() + 
  labs(x = 'classe processual', 
       y = 'quantidade', 
       title = 'Classe processual em direito bancário', 
       caption = 'Fonte: TJSP') + 
  theme_bw()

frequencia <- basefinal |> 
  count(classe, decisao)
frequencia

frequencia |> 
  ggplot(aes(x = n, y = classe, fill = decisao))+
  geom_bar(stat = 'identity')+
  scale_fill_brewer(palette = "Set1")


frequencia2 <- basefinal |> 
  count(classe, assunto, decisao)
frequencia2

frequencia2 |> 
  ggplot(aes(x = n, y = assunto, fill = decisao))+
  geom_bar(stat = 'identity')+
  scale_fill_brewer(palette = "Set1")+
  facet_wrap(~classe)
