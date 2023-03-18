tjsp::tjsp_autenticar()
tjsp::tjsp_cpopg_baixar_tabela_docs("00000067220228260022")
tabela <- tjsp::tjsp_ler_tabela_docs()
library(tidyverse)
documentos <- tabela |> 
  filter(id_doc == 4)
tjsp::tjsp_baixar_cpopg_docs(documentos)
tjsp::tjsp_combinar_docs(dir_destino = ".")