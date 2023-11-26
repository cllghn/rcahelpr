# Reads
hpsa_mentalhealth <- read.csv(file = "data-raw/hpsa_mentalhealth.csv")
hpsa_primarycare <- read.csv(file = "data-raw/hpsa_primarycare.csv")
ca_crimes_and_clearances_with_arson <- read.csv(file = "data-raw/Crimes_and_Clearances_with_Arson-1985-2022.csv")
life_expectancy <- read.csv("data-raw/U.S._Life_Expectancy_at_Birth_by_State_and_Census_Tract_-_2010-2015.csv")
saipe_state_and_county <- readxl::read_xls("data-raw/est21all.xls", skip = 3)[, 1:25]

# Modify
ca_crimes_and_clearances_with_arson$County <- factor(ca_crimes_and_clearances_with_arson$County,
                                                     levels = unique(ca_crimes_and_clearances_with_arson$County))
saipe_state_and_county <- saipe_state_and_county[, !grepl("90% CI", names(saipe_state_and_county))]

# Save
usethis::use_data(hpsa_mentalhealth)
usethis::use_data(hpsa_primarycare)
usethis::use_data(ca_crimes_and_clearances_with_arson)
usethis::use_data(life_expectancy, overwrite = TRUE)
usethis::use_data(saipe_state_and_county, overwrite = TRUE)
