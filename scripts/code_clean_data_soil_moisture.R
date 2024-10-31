# Load packages ---------------------------------------------------------------
library(dplyr)
library(janitor)
library(tidyr)
library(readxl)

# Load Biomass data -----------------------------------------------------------
data_soil_moisture <-
    read_excel("raw_data/7_soil_moisture_data.xlsx", na = c("N/A", "-","NA")) %>%  
    clean_names()

# Recode factors --------------------------------------------------------------

data_soil_moisture <-
    data_soil_moisture %>%
    # Recode treatment levels
    mutate(
        treatment = dplyr::recode(treatment,
            `ambient rain` = "ambientrain",
            `ambient rain + nutrients` = "ambientrain_nutrients",
            `ambient rain + water` = "ambientrain_water",
            `ambient rain + water + nutrients` = "ambientrain_water_nutrients"
        ),

        # Recode wrong specie code
        sppcode = dplyr::recode(sppcode, `dt` = "dr")
    )

# Clean data --------------------------------------------------------------------

data_soil_moisture_cleaned <-
    data_soil_moisture %>%
    # remove NA's
    drop_na() %>%
    # Rename columns
    rename(
        spcode = "sppcode",
        sm_before_watering = "soil_moisture_percent_water_content_before_watering",
        sm_after_watering = "soil_moisture_percent_water_content_after_watering"
    ) %>%
    # Transform to factor class spcode,family and treatment
    mutate(
        spcode = factor(spcode),

        # Order levels
        date_day_month = factor(date_day_month, levels = c(
            "31_08",
            "19_09",
            "4_10",
            "17_10",
            "31_10",
            "15_11"
        )),
        # Order levels
        treatment = factor(treatment, levels = c(
            "ambientrain",
            "ambientrain_nutrients",
            "ambientrain_water",
            "ambientrain_water_nutrients"
        )),

        # Create nfixer column
        nfixer = factor(ifelse(spcode == "ec" |
            spcode == "dr" |
            spcode == "gs", "fixer", "nonfixer"))
    ) %>%
    # Pivot soil moisture before and soil moisture after in one column
    pivot_longer(c(sm_before_watering, sm_after_watering),
        names_to = "sm_measured", values_to = "soil_moisture"
    ) %>%
    # Recode new levels
    mutate(
        sm_measured = dplyr::recode(sm_measured,
            `sm_before_watering` = "before_watering",
            `sm_after_watering`  = "after_watering"
        ),
        # Order levels
        sm_measured = factor(sm_measured, levels = c(
            "before_watering",
            "after_watering"
        ))
    ) %>%
    # Order the columns
    dplyr::select(id, spcode, treatment, nfixer, date_day_month, sm_measured, everything()) %>%
    dplyr::select(-height) %>%
    arrange(nfixer)

# Rename levels of the column treament ------------------------------------------
data_soil_moisture_cleaned$treatment <-
    factor(data_soil_moisture_cleaned$treatment,
        labels = c(
			"Ambient Rain",
            "Ambient Rain plus Nutrients",
            "Ambient Rain plus Water",
            "Ambient Rain plus Nutrients and Water"
        ))

# Rename the levels of the column date_day_month --------------------------------
data_soil_moisture_cleaned$date_day_month <-
    factor(data_soil_moisture_cleaned$date_day_month,
        labels = c(
            "31-August",
            "19-September",
            "4-October",
            "17-October",
            "31-October",
            "15-November"
        ))

# Rename the levels of the column sm_measured ----------------------------------- 		
data_soil_moisture_cleaned$sm_measured <-
    factor(data_soil_moisture_cleaned$sm_measured,
        labels = c(
            "Before applying the treatments",
            "After applying the treatments"
        ))

# Remove uncleaned data set ---------------------------------------------------
rm(data_soil_moisture)
print(paste0("Files loaded: ", ls()))
