endereco <- c("Avenida Paulista, 458, apto 1070, cep 01500-000, município de São Paulo, estado de são Paulo",
              "rua Padrão, 658, cep 01200-017, Sao Paulo, estado de Sao paulo")
cep <- str_extract(endereco, pattern = "\\d{5}-\\d{3}")
tipo_logradouro <- str_extract(endereco, pattern = "\\w+")
tipo_logradouro2 <- str_extract_all(endereco, pattern = "\\w+")
tipo_logradouro2

#replace

endereco2 <- str_replace(endereco, pattern = ",\\s", replacement = ", nº ")
endereco2

endereco3 <- str_replace_all(endereco, pattern = "(?i)\\bs[aã]o\\b", replacement = "São")
endereco3

#remove
endereco4 <- str_remove(endereco, pattern = "(?i) estado de")
endereco4

endereco5 <- str_remove_all(endereco, pattern = "(?i)\\bs[aã]o\\b")
endereco5

#look ahead or behind

depois_cep <- str_extract(endereco, pattern = "(?<=cep )\\d+")
depois_cep

#ahead até o padrão
ate_cep <- str_extract(endereco, pattern = ".+(?=cep)")
ate_cep

ate_virg <- str_extract(endereco, pattern = ".+?(?=,)") # +? pegou até o primeiro se não tiver interrogação pega vários
ate_virg

cep_virg <- str_extract(endereco, pattern = "(?<=cep ).+?(?=,)")
cep_virg

lucas_proc <- "0011435-79.2018.8.26.0053"
lucas_proc_limpo <- str_remove_all(lucas_proc, pattern = "\\D")
lucas_proc_limpo

lucas_proc_limpo_seq <- str_sub(lucas_proc_limpo, start = 1, end = 7)
lucas_proc_limpo_seq

lucas_proc_limpo_dig <- str_sub(lucas_proc_limpo, start = 8, end = 9)
lucas_proc_limpo_dig

lucas_proc_limpo_ano <- str_sub(lucas_proc_limpo, start = 10, end = 13)
lucas_proc_limpo_ano

lucas_proc_limpo_segmento <- str_sub(lucas_proc_limpo, start = 14, end = 14)
lucas_proc_limpo_segmento

lucas_proc_limpo_trib <- str_sub(lucas_proc_limpo, start = 15, end = 16)
lucas_proc_limpo_trib

lucas_proc_limpo_dist <- str_sub(lucas_proc_limpo, start = 17, end = 20)
lucas_proc_limpo_dist

lucas_proc_limpo <- as.numeric(lucas_proc_limpo)
lucas_proc_limpo

lucas_proc_limpo <- str_pad(lucas_proc_limpo, 20, pad = "0")
lucas_proc_limpo

#detect

paulo_detect <- str_detect(endereco, pattern = "(?i)paulo")
paulo_detect

paulo_detect_numb <- str_count(endereco, pattern = "(?i)paulo")
paulo_detect_numb

#str subset

endereco_subset <- str_subset(endereco, pattern = "(?i)paulista")
endereco_subset


endereco_subset2 <- str_subset(endereco, pattern = "(?i)paulista", negate = TRUE)
endereco_subset2

#str which

endereco_which <- str_which(endereco, pattern = "(?i)paulo") # retorna um vetor com indices que tenham o padrão
endereco_which
