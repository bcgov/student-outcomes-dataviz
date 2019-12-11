# Read libraries
library(shiny) ;library(htmlwidgets); library(tidyr) ; library(flexdashboard); library(shinythemes); library(shinydashboard);library(plotly);library(shinyjs);library(shinycssloaders); library(markdown); library(shinyBS); library(shinyalert)

# reading data
students_download <- read.csv("data/SO_Data_Viewer_Data_2016_2018_V2.csv", header=T)
students <- read.csv("data/SO_Data_Viewer_Data_2016_2018_V2.csv", header=T)


top <- students %>% 
  slice(1:nrow(students)-1) %>% 
  mutate(tempcol1=ifelse(is.na(FURTH_STUDIES), Q11_7,FURTH_STUDIES )) %>% 
  mutate(FURTH_STUDIES=ifelse(is.na(tempcol1), Q52_6,tempcol1))  
  #select(1:70, 73)
  #filter(!RESPONDENTS==0)



#last_row <- students %>% 
  #slice(nrow(students)) %>% 
  #select(1:70, 73)

students <- top %>% 
  #rbind(last_row) %>% 
  arrange(INSTITUTION_NAME) %>% 
  mutate(PROGRAM_AREA_NAME2=PROGRAM_AREA_NAME)  # add the second column for program area name to ensure long label don't cut-off in charts
  


# Change variable Names
names(students)[names(students)=="Q49A"] <- "satisfaction_rate"
names(students)[names(students)=="Q52A"] <- "instruction"
names(students)[names(students)=="Q51NA"] <- "Write_Clearly"
names(students)[names(students)=="Q51NB"] <- "Speak_Clearly"
names(students)[names(students)=="Q51ND"] <- "Work_With_Others"
names(students)[names(students)=="Q51NE1"] <- "Think_Critically"
names(students)[names(students)=="Q51NE2"] <- "Resolve_Issues"
names(students)[names(students)=="Q51NI"] <- "Learn_Independently"
names(students)[names(students)=="Q51NJ"] <- "Read"
#levels(students$CREDENTIAL) <- gsub("Diploma, Associate Degree, and Certificate","Diploma, Associate Degree & Certificate", levels(students$CREDENTIAL))
levels(students$PROGRAM_AREA_NAME) <- gsub("All Trade Groups","Overall", levels(students$PROGRAM_AREA_NAME))
levels(students$PROGRAM_AREA_NAME) <- gsub("All CIP Clusters Expanded","Overall", levels(students$PROGRAM_AREA_NAME))
levels(students$PROGRAM_AREA_NAME) <- gsub("All CIP Clusters","Overall", levels(students$PROGRAM_AREA_NAME))

## adding the below line since the label is too long and will cut-off
levels(students$PROGRAM_AREA_NAME2) <- gsub("Industrial and Heavy Duty Mechanics and Other Repair Trades",HTML(paste0("Industrial and Heavy Duty","<br>","Mechanics and Other Repair Trades")), levels(students$PROGRAM_AREA_NAME2))
levels(students$PROGRAM_AREA_NAME2) <- gsub("Marketing Management (Marketing Communications Option)",HTML(paste0("Marketing Management","<br>","(Marketing Communications Option)")), levels(students$PROGRAM_AREA_NAME2))

levels(students$PROGRAM_AREA_NAME)[levels(students$PROGRAM_AREA_NAME)=="All CIP Clusters Expanded"] <- "Overall"
levels(students$PROGRAM_AREA_NAME) <- gsub('and','&',levels(students$PROGRAM_AREA_NAME)) # replace and with & in all programs


### PROGRAM AREA NAME 2

levels(students$PROGRAM_AREA_NAME2) <- gsub("All Trade Groups","Overall", levels(students$PROGRAM_AREA_NAME2))
levels(students$PROGRAM_AREA_NAME2) <- gsub("All CIP Clusters Expanded","Overall", levels(students$PROGRAM_AREA_NAME2))
levels(students$PROGRAM_AREA_NAME2) <- gsub("All CIP Clusters","Overall", levels(students$PROGRAM_AREA_NAME2))
levels(students$PROGRAM_AREA_NAME2)[levels(students$PROGRAM_AREA_NAME2)=="All CIP Clusters Expanded"] <- "Overall"
levels(students$PROGRAM_AREA_NAME2) <- gsub('and','&',levels(students$PROGRAM_AREA_NAME2))

choices_skill <- c("Read & comprehend material"="Read",
                   "Write clearly and concisely"="Write_Clearly", 
                   "Speak effectively"="Speak_Clearly",
                   "Work effectively with others"="Work_With_Others",
                   "Analyse & think critically"= "Think_Critically",
                   "Resolve issues or problems"="Resolve_Issues",
                   "Learn independently"="Learn_Independently")

choices_result <- c("Took further studies"="FURTH_STUDIES",
                    "Quality of instruction"="instruction", 
                    "Satisfaction with education"="satisfaction_rate")

# 
# students %>%
#   filter(CREDENTIAL == "Apprenticeship") %>%
#   filter(INSTITUTION_NAME == "Camosun College") %>%
#   filter(PROGRAM_AREA_NAME == "Carpentry") %>%
#   select(PROGRAM_NAME) %>%
#   arrange(PROGRAM_NAME)
# # 
# students$PROGRAM_NA(E
# #   
# 
# 
# sort(students$PROGRAM_NAME[students$CREDENTIAL=="Apprenticeship" &
#                                students$INSTITUTION_NAME=="Camosun College" & 
#                                students$PROGRAM_AREA_NAME=="Carpentry"])
