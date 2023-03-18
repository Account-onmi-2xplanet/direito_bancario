# processos <- union(santander1$processo,santander2$processo) 
# saveRDS(processos,"data/processo_santander.rds")
processos <- readRDS(here::here("data/processo_santander.rds"))
processos <- split(processos, ceiling(seq_along(processos)/1000))
purrr::walk(processos,~{
  tjsp::tjsp_autenticar()
  tjsp::tjsp_baixar_cpopg(.x,diretorio =  here::here("data-raw/cpopg")) #.x para interar cada grupo de 1000
  
})
