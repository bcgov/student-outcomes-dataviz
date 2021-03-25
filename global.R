# Copyright 2020 Province of British Columbia
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.


# Load libraries
library(shiny)
library(htmlwidgets)
library(tidyr)
library(shinythemes)
library(shinydashboard)
library(plotly)
library(shinyjs)
library(shinycssloaders)
library(markdown)
library(shinyBS)
library(shinyalert)
library(capture)
library(dplyr)
options(scipen = 999)


# reading data
students <- read.csv("data/SO_Data_Viewer_Data_2017_2019_V8.csv", header = T)

top <- students %>%
  mutate(tempcol1 = ifelse(is.na(FURTH_STUDIES), Q11_7, FURTH_STUDIES)) %>%
  mutate(FURTH_STUDIES = ifelse(is.na(tempcol1), Q52_6, tempcol1))

# add the second column for program area name to ensure long label don't cut-off in charts, chagne character columns to factor
students <- top %>%
  arrange(INSTITUTION_NAME) %>%
  mutate(PROGRAM_AREA_NAME2 = PROGRAM_AREA_NAME) %>%
  mutate_if(is.character, as.factor)


# Change variable Names
names(students)[names(students) == "Q49A"] <- "satisfaction_rate"
names(students)[names(students) == "Q52A"] <- "instruction"
names(students)[names(students) == "Q51NA"] <- "Write_Clearly"
names(students)[names(students) == "Q51NB"] <- "Speak_Clearly"
names(students)[names(students) == "Q51ND"] <- "Work_With_Others"
names(students)[names(students) == "Q51NE1"] <- "Think_Critically"
names(students)[names(students) == "Q51NE2"] <- "Resolve_Issues"
names(students)[names(students) == "Q51NI"] <- "Learn_Independently"
names(students)[names(students) == "Q51NJ"] <- "Read"
levels(students$PROGRAM_AREA_NAME) <- gsub("All Trade Groups", "Overall", levels(students$PROGRAM_AREA_NAME))
levels(students$PROGRAM_AREA_NAME) <- gsub("All CIP Clusters Expanded", "Overall", levels(students$PROGRAM_AREA_NAME))
levels(students$PROGRAM_AREA_NAME) <- gsub("All CIP Clusters", "Overall", levels(students$PROGRAM_AREA_NAME))

# adding the below code since the labels are too long and will cut-off
levels(students$PROGRAM_AREA_NAME)[levels(students$PROGRAM_AREA_NAME) == "All CIP Clusters Expanded"] <- "Overall"
levels(students$PROGRAM_AREA_NAME) <- gsub("and", "&", levels(students$PROGRAM_AREA_NAME)) # replace and with & in all programs

# PROGRAM AREA NAME 2
levels(students$PROGRAM_AREA_NAME2) <- gsub("Industrial and Heavy Duty Mechanics and Other Repair Trades", HTML(paste0("Industrial and Heavy Duty", "<br>", "Mechanics and Other Repair Trades")), levels(students$PROGRAM_AREA_NAME2))
levels(students$PROGRAM_AREA_NAME2) <- gsub("Marketing Management (Marketing Communications Option)", HTML(paste0("Marketing Management", "<br>", "(Marketing Communications Option)")), levels(students$PROGRAM_AREA_NAME2))
levels(students$PROGRAM_AREA_NAME2) <- gsub("All Trade Groups", "Overall", levels(students$PROGRAM_AREA_NAME2))
levels(students$PROGRAM_AREA_NAME2) <- gsub("All CIP Clusters Expanded", "Overall", levels(students$PROGRAM_AREA_NAME2))
levels(students$PROGRAM_AREA_NAME2) <- gsub("All CIP Clusters", "Overall", levels(students$PROGRAM_AREA_NAME2))
levels(students$PROGRAM_AREA_NAME2)[levels(students$PROGRAM_AREA_NAME2) == "All CIP Clusters Expanded"] <- "Overall"
levels(students$PROGRAM_AREA_NAME2) <- gsub("and", "&", levels(students$PROGRAM_AREA_NAME2))

choices_skill <- c(
  "Read & comprehend material" = "Read",
  "Write clearly and concisely" = "Write_Clearly",
  "Speak effectively" = "Speak_Clearly",
  "Work effectively with others" = "Work_With_Others",
  "Analyse & think critically" = "Think_Critically",
  "Resolve issues or problems" = "Resolve_Issues",
  "Learn independently" = "Learn_Independently"
)

choices_result <- c(
  "Took further studies" = "FURTH_STUDIES",
  "Quality of instruction" = "instruction",
  "Satisfaction with education" = "satisfaction_rate"
)


students$INSTITUTION_NAME[students$INSTITUTION_NAME == as.character(unique(students$INSTITUTION_NAME))[1]]
as.character(unique(students$INSTITUTION_NAME[students$INSTITUTION_NAME == as.character(unique(students$INSTITUTION_NAME))[1]]))
choices <- as.character(unique(students$INSTITUTION_NAME[students$INSTITUTION_NAME == as.character(unique(students$INSTITUTION_NAME))[1]]))

# adding the rounding function
round2 <- function(x, n) {
  posneg <- sign(x)
  z <- abs(x) * 10^n
  z <- z + 0.5
  z <- trunc(z)
  z <- z / 10^n
  z * posneg
}
