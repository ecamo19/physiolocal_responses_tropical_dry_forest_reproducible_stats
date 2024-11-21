# Load packages -----------------------------------------------------------------
library(dplyr)
library(janitor)
library(readxl)

# Load nodule and height data ---------------------------------------------------

data_nodules <-
	read_excel("./raw_data/1_nodule_data.xlsx") %>%
	clean_names()

data_init_height <-
	read_excel("./raw_data/6_plant_heights_data.xlsx") %>%
	clean_names() %>%

    #remove unused columns
	dplyr::select(1:5)

# Clean nodules datase ----------------------------------------------------------

data_nodules_cleaned  <-
	data_nodules %>%

    # Transform to factor spcode,id and treatment
	mutate(id = factor(id),
		   spcode = factor(spcode),
		   treatment = factor(treatment,
		                      levels = c("ambientrain",
		                                "ambientrain_nutrients",
		                                "ambientrain_water",
		                                "ambientrain_water_nutrients"))) %>%

	# Rename treatments
	mutate(treatment = case_when(treatment == "ambientrain" ~ "no_additions",
								treatment == "ambientrain_water_nutrients" ~ "plus_water_nutrients",     
                                treatment == "ambientrain_water" ~ "plus_water", 
                                treatment == "ambientrain_nutrients" ~ "plus_nutrients",
                                TRUE ~ treatment)) %>% 
    # Order columns
    dplyr::select(id, spcode, treatment, everything())

# Clean data initial height -----------------------------------------------------

data_init_height_nfixer <-
	data_init_height  %>%

    # Select nfixer species
	filter(family == "Legume" & spcode != "hc") %>%

    #Remove unused columns
    dplyr::select(-c(family)) %>%

    #Transform columns to a factor
    mutate(spcode = factor(spcode),
           treatment = factor(treatment),
           id = factor(id)) %>%

    rename(init_height = "x20150831")

# Join data sets ----------------------------------------------------------------

data_nodules_cleaned <-
	inner_join(data_nodules_cleaned, data_init_height_nfixer ,
	           by = c('id','treatment','spcode'))


# Remove unused data sets -------------------------------------------------------
items <- c("data_nodules", "data_init_height", "data_init_height_nfixer")

remove(items, list = items)
print(paste0("Files loaded: ", ls()))
