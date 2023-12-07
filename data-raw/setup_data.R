library(data.table)
# Reads ------------------------------------------------------------------------
hpsa_mentalhealth <- read.csv(file = "data-raw/hpsa_mentalhealth.csv")
hpsa_primarycare <- read.csv(file = "data-raw/hpsa_primarycare.csv")
ca_crimes_and_clearances <- read.csv(file = "data-raw/Crimes_and_Clearances_with_Arson-1985-2022.csv")
life_expectancy <- read.csv("data-raw/U.S._Life_Expectancy_at_Birth_by_State_and_Census_Tract_-_2010-2015.csv")
saipe_state_and_county <- readxl::read_xls("data-raw/est21all.xls", skip = 3)[, 1:25]
population_estimates <- readxl::read_xlsx("data-raw/PopulationEstimates.xlsx", skip = 4)

# Modify -----------------------------------------------------------------------
# Crime notes:
# - Transform the County variable into a factor
ca_crimes_and_clearances$County <- factor(ca_crimes_and_clearances$County,
                                          levels = unique(ca_crimes_and_clearances$County))
# Poverty data notes:
# - Remove the 90% CI columns as they only add move variables that we will not use
# - Transform the numeric variables into said class in order to make the use of these data easier during class
saipe_state_and_county <- saipe_state_and_county[, !grepl("90% CI", names(saipe_state_and_county))]
setDT(saipe_state_and_county)[, c("Poverty Estimate, All Ages", "Poverty Percent, All Ages", "Poverty Estimate, Age 0-17", "Poverty Percent, Age 0-17", "Poverty Estimate, Age 5-17 in Families", "Poverty Percent, Age 5-17 in Families", "Median Household Income") 
                                  :=lapply(.SD, \(x) as.numeric(x)),
                              .SDcols=5:11
                              ][, FIPStxt := paste0(`State FIPS Code`, `County FIPS Code`)]
setDF(saipe_state_and_county)

# Save -------------------------------------------------------------------------
usethis::use_data(hpsa_mentalhealth, overwrite = TRUE)
usethis::use_data(hpsa_primarycare, overwrite = TRUE)
usethis::use_data(ca_crimes_and_clearances, overwrite = TRUE)
usethis::use_data(life_expectancy, overwrite = TRUE)
usethis::use_data(saipe_state_and_county, overwrite = TRUE)


# Stuff for HW:
out <- merge(saipe_state_and_county, population_estimates,
             by.x = 'FIPStxt', by.y = 'FIPStxt')
out[c("FIPStxt", "State FIPS Code", "County FIPS Code", "Area_Name", 
      "Postal Code", "Poverty Estimate, All Ages",
      "Poverty Estimate, Age 0-17",  
      "Poverty Estimate, Age 5-17 in Families",
      "Median Household Income", "CENSUS_2020_POP", "ESTIMATES_BASE_2020",
      "POP_ESTIMATE_2020", "POP_ESTIMATE_2021", "POP_ESTIMATE_2022")
    ]
out <- write.csv(out, file = "data-raw/poverty_and_population_by_county.csv", row.names = FALSE)
# out['test'] <- out$`Poverty Estimate, All Ages` / out$CENSUS_2020_POP * 100
# out[c("test", "Poverty Percent, All Ages")]
