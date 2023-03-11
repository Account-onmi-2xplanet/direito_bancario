# exemplos c() , matrix()
Sys.time()
mean()
sqrt()
sqrt(2)
?sqrt
sqrt(x = 2)
library(tjsp)
?tjsp_baixar_cjpg
somar <- function() {
  2+3
}
somar()
somar <- function() {
  2+3
  5+4
}
somar()
somar <- function() {
  a <<- 2+3 #enviando a variável vá para um nível acima
  b <- 5+4
}
somar()

#testando função dentro de função e envio da variavel para nivel acima
f1 <- function() {
  f2 <- function() {
    a <- 1
  }
  f2()
  2 + a
}
f1()


#função com argumento claramente declarado
exponenciar <- function(x,y) {
  x^y
}
exponenciar(2,3)
exponenciar(y = 3, x = 2)
2^3
?sqrt

#pacotes conjunto de funções

