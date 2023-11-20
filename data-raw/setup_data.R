# Reads
hpsa_mentalhealth <- read.csv(file = "data-raw/hpsa_mentalhealth.csv")
hpsa_primarycare <- read.csv(file = "data-raw/hpsa_primarycare.csv")
ca_crimes_and_clearances <- read.csv(file = "data-raw/Crimes_and_Clearances_with_Arson-1985-2022.csv")

# Modify
ca_crimes_and_clearances$County <- factor(ca_crimes_and_clearances_with_arson$County,
                                                     levels = unique(ca_crimes_and_clearances_with_arson$County))

# Save
usethis::use_data(hpsa_mentalhealth)
usethis::use_data(hpsa_primarycare)
usethis::use_data(ca_crimes_and_clearances_with_arson)
