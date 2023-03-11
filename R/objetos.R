# numero inteiro
x <- 2L
typeof(x) #tipo é natureza

# números decimais (doubles)
y <- 2.5
typeof(y)

# realizando operações usando nome dos objetos
z <- x + y
typeof(z)

# objeto texto (aspas simples ou duplas)
w <- "jurimetria"
typeof(w)

# não é possível somar characteres
u <- '2'
v <- "2.5"
u+v

# objeto da classe data, classe é comportamentodo objeto
data <- as.Date("2023-02-25")
typeof(data)

data2 <- as.Date("2023-03-01")

as.numeric(data2)
as.numeric(data)

#operações com data
data2 - data
class(data)

data3 <- as.Date("1969-12-30")
as.numeric(data3)

#vetor objeto com um ou mais elementos
nome <- c("luis", "ana", "joão")

numeros <- 1:10 # primeiro e ultimo número incluídos no R

#função agregadora, aplicada a todos os elementos
sum(numeros)

mean(numeros)

min(numeros)

#subconjunto
numeros[10]

numeros[2:5]

numeros[-1] #negativo tem efeito de excluir

# tipo fator
nomes <- c("luis", "ana", "joão", "ana", "flávia", "luis", "ana")
nomes_como_fator <- as.factor(nomes) #snakecase preferível a lowercamelcase nomesComoFator
nomes_como_fator

# matrizes
m <- matrix(1:15)
m
#usando vetor
m*2

m <- matrix(1:15,ncol = 3)
m

#dataframe emparelhamento de vetores
df <- data.frame(nome = c("fabiana", "juvenal", "lucas", "pedro", "beatriz", "bruno"), 
                 idade = c(55, 29, 35, 34, 30, 40))
df

#lista
l <- list(m,data,df)
l
