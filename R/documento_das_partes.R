url = "https://esaj.tjsp.jus.br/petpg/api/processos/7V0001L150000/partes?instancia=PG&cd_perfil=1&cd_usuario=811252&cd_usuario_solicitante=811252&documento_usuario=313.126.138-23"

library(tjsp)
tjsp_autenticar()
library(httr)
x <- url |> 
  GET() |> 
  content("text") |> 
  jsonlite::fromJSON()

tjsp_partes_credenciais(cd_usuario = "811252", usuario_solicitante = "811252", documento_usuario = "313.126.138-23", cd_perfil = "1" )

tjsp_baixar_partes_docs("7V0001L150000", diretorio = "data-raw")
x <- jsonlite::fromJSON("data-raw/tjsp_cd_processo_7V0001L150000_doc_partes.json")
"data-raw/tjsp_cd_processo_7V0001L150000_doc_partes.json" |> 
  readLines() |> 
  jsonlite::prettify()