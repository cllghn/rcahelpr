hpsa_mentalhealth <- read.csv(file = "data-raw/hpsa_mentalhealth.csv")
hpsa_primarycare <- read.csv(file = "data-raw/hpsa_primarycare.csv")
usethis::use_data(hpsa_mentalhealth)
usethis::use_data(hpsa_primarycare)
