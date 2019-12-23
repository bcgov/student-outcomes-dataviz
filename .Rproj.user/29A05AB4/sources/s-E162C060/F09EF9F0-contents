# Copyright 2016 Province of British Columbia 
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

#options(error = browser())




title1 <- "Bachelor\\'s degree respondents said very good or good; other respondents said very good, good, or adequate."

viewMoreButton<-function(sectionID,...){
  div(
    tags$a(href=paste0("#",sectionID),
         tags$button("Back to Top",type = "button", 
                     class = "btn btn-default action-button",...)))

}

viewMoreTitle<-function(sectionID,title){
  HTML(paste0("<span id=\"",sectionID,"\">",title,"</span>"))
}


sideBarValueBoxOutput <- function (outputId, width=4){
  tags$a(class="sidebar-menu",
         tags$li(
           shinydashboard::valueBoxOutput(outputId, width=width)
         )
  )
}




jsCode <- 'shinyjs.winprint = function(){
window.print();
}'

# Define UI for the application - Dashboardpage
shinyUI(tagList(dashboardPage(title="BC Student Outcomes Data Viewer",

  dashboardHeader(
    tags$li(class = "dropdown",
            tags$style(".main-header.sidebar-collapse {padding-top:10px}"),
            tags$style(type='text/css','.skin-blue .main-header .navbar{display:none;}')
  ),
  

    title = tags$div(class="banner",
                                                  
                                                  a(href="https://gov.bc.ca",
                                                    
                                                    img(src = 'img/BCID_H_rgb_rev.svg', title = "Government of British Columbia", alt = "British Columbia - BC Stats"),
                                                    
                                                    onclick="gtag"
                                                    
                                                  ),
                                                  
                                                  h4("BC Student Outcomes Data Viewer (Data from 2016 to 2018)", style="font-weight:400; color:white; margin: 5px 5px 0 18px;")
                                                  
    ),  titleWidth = 700

  
  ),

          

## Dashboardsidebar
  
  dashboardSidebar(
    # Remove the sidebar toggle element
    tags$script(JS("document.getElementsByClassName('sidebar-toggle')[0].style.visibility = 'hidden';")),
    tags$style(
      ".main-header .navbar-custom-menu {
      width: calc(100% - 50px);
      }
      
      .main-header .navbar-nav,
      .main-header .dropdown {
      width: 100%;
      }
      
      .main-header img {
      display:block;
      width:150px;
      height: 50px;
      padding-top:10px;
      }"
      ),
    

    tags$style(HTML("
                    .sidebar {
                    position:fixed; 
                    width: inherit;
                    padding-right:
5px;
                    }")),
    
    br(),
    width = 310,
    fluidRow(uiOutput("note")
    ),
    fluidRow(
      column(4, uiOutput("student_group"))
    ),
  fluidRow(
    column(4, uiOutput("institution"))),
  fluidRow(
    column(4, uiOutput("program"))),
  fluidRow(
    column(4, uiOutput("program_name"))),
    #br(),
    uiOutput("respondents"),
  fluidRow(div(img(src = "logo_new.png", width = "70%", height = "70%", style="padding: 10px 10px 10px 30px;")))
  ),

  dashboardBody(
    useShinyjs(),
    bsModal(id = 'startupModal', title = tags$img(src = "logo.png", width = "25%", height = "18%", style="display: block; margin: 0 auto;")

            , trigger = 'show1',
            size = 'large',
            p("Each year, tens of thousands of former post-success students are asked about their educational experiences, subsequent employment, and further studies. Find out what former students are doing one to two years after their B.C. post-success education.",style="font-size:16px;text-align: center;"), br(), 
            p("Are they",span ("employed?", style="color: blue; text-aling:center;"),style="font-size:16px;text-align: center;"), br(),
            p("Did they go ",span (" back to school?", style="color: blue; text-aling:center;"),style="font-size:16px;text-align: center;"), br(),
            p("Were they ",span ("satisfied", style="color: blue; text-aling:center;"),style="font-size:16px;text-align: center;", span("with their education?")), br(),
            helpText("Outcomes of former students may differ from outcomes of current and future students.",style="font-size:14px;text-align: center;")

            ),
    
    tags$style(type="text/css",
           ".shiny-output-error { visibility: hidden; }",
           ".shiny-output-error:before { visibility: hidden; }"),
    
    tags$link(rel="stylesheet", type="text/css",href="style.css"),
    #tags$style(".small-box.bg-red { height: 115px ; background-color: #ffffff !important; color: black !important;border-style: none !important;}"),
    tags$style(".small-box.bg-purple { height: 115px;background-color: #8dc63f !important; }"),
    tags$style(".small-box.bg-green { height: 115px; }"),
    tags$style(".small-box.bg-aqua { height: 115px;background-color: #fff !important; }"),
    tags$script(HTML("$('body').addClass('fixed');")),
    tags$head(tags$meta(name = "viewport", content = "width=1500")), # mobile friendly version of the app 
    tags$head(tags$style(
      type="text/css",
      "#image img {max-width: 100%; width: 50%; height: auto}"
    )),
    

    

#### Summary Section------------
    
    fluidRow(box(id="summary", uiOutput("text1"),title = viewMoreTitle(sectionID = "summary", title = div(tags$b("Summary"),style="font-size: 25px;")), width=12,status="primary",collapsible = TRUE,solidHeader = TRUE,
      fluidRow(h3("About the respondents", style="margin:10px;color: #2A64AB;")),           
        
        fluidRow(
          #column(width=6, uiOutput("gender")),
          column(width=12, div(class="testing", uiOutput("gender_age")))
                 ), 
        fluidRow(column(width=12, uiOutput="satisfaction2", bsTooltip(id = "satisfaction2", title = "Those who said they were very satisfied or satisfied with their education.", placement = "top", trigger = "hover"))),
        fluidRow(column(width=12,uiOutput("satisfaction2"))
        ),
        fluidRow(
          column(width=6, uiOutput("quality_education")),
          column(width=6, uiOutput("employed_full_time"), bsTooltip(id = "employed_full_time", title = "Employed 30 hours or more per week at their main job.", placement = "top", trigger = "hover"))
        ),
        fluidRow(
          column(width=6, uiOutput("further_studies")),
          column(width=6, uiOutput("related_program"), bsTooltip(id = "related_program", title = "Those who responded very related or somewhat related when asked how related their main job was to their program.", placement = "top", trigger = "hover"))
        ),
        fluidRow(uiOutput("summary_filter")),

    
#### Satisfaction and further education section--------------
     fluidRow(
       box(id="dem", title=viewMoreTitle(sectionID = "dem_link", title = uiOutput("satisfaction_edu")),width=12,solidHeader = TRUE,status="success",collapsible = TRUE,collapsed=FALSE,
           fluidRow(column(8,offset=1, withSpinner(plotlyOutput("plot_program_satisfaction", height = "65vh",width = "100%")))
                     #column(3,selectInput("select_further", uiOutput("satisfaction_text"),choices= choices_result, selected=""))
                    ),
           fluidRow(uiOutput("plot_program_satisfaction_summary"))
          ))),
       

    box(id="sat",uiOutput ("text3"), title=viewMoreTitle(sectionID = "satisfactionlink", title = div(tags$b("Skill Development"), style="font-size: 25px;")), status = "primary", solidHeader = TRUE, collapsible = TRUE, width = 12,collapsed=FALSE,

        fluidRow(column(7,offset=2,  withSpinner(plotlyOutput("plot_skills", height = "65vh",width = "100%")))),
        fluidRow(uiOutput("plot_skills_summary")),
        fluidRow(box(uiOutput ("text_skill"),
          width=12,
                          title = uiOutput("title_select"),
                          status = "success",
                          solidHeader = TRUE,
                          collapsible = TRUE,
                     fluidRow(column(8,offset=1, plotlyOutput("plot_program_switch", height = "65vh")),
                              column(3,selectInput("select", "See more results by program area…",choices= choices_skill, selected="Reading & Comprehending"))),
                     fluidRow(
                       column(12,
                              div(tags$em(helpText("Note: Those who responded that their program was very helpful or helpful in developing this skill.")),style="text-align:center;"))),
          fluidRow(uiOutput("plot_program_switch_summary"))
        ))
        
        
        
    )),
    uiOutput("draft"),
        
    fluidRow(box(
      id="emp",title=viewMoreTitle(sectionID = "employmentlink", title = div(tags$b("Employment"),style="font-size: 25px;")), status = "primary", solidHeader = TRUE, collapsible = TRUE, width = 12,collapsed=FALSE,
      fluidRow(
        column(4,uiOutput("labour"),bsTooltip(id = "labour", title = "The labour force includes people who were employed or were looking and available for work.", placement = "top", trigger = "hover")),
        column(4,uiOutput("wage"), uiOutput("testing")),
        column(4, uiOutput("unemploy_rate"),bsTooltip(id = "unemploy_rate", title = "Respondents who were not working but were available and looking for a job.", placement = "top", trigger = "hover"))
      ),
      fluidRow(
        column(12, uiOutput('employment_rate'), bsTooltip(id = "employment_rate", title = "Those who said they were working at a job or business at the time of the survey. Asked of all respondents.", placement = "top", trigger = "hover"))),
      fluidRow(
        column(6, uiOutput('full_time'), bsTooltip(id = "full_time", title = "Employed 30 hours or more per week at their main job.", placement = "top", trigger = "hover")),
        column(6, uiOutput('self'))
      ),
      fluidRow(
        column(6, uiOutput('related_program_emp')),
        column(6, uiOutput('knowledge_skill_useful'))
      ),
      fluidRow(uiOutput("employment_summary")),
   
          box(width=12, 
            #div(tags$em("Working in a program-related job by program area",style="font-size: 16px;margin-left: 210px")),
            title = uiOutput("title4"),
            status = "success",
            solidHeader = TRUE,
            collapsible = TRUE,
            fluidRow(column(width=8, offset=1,withSpinner(plotlyOutput("plot_program_relate", height = "65vh")))),
            fluidRow(column(12,div(tags$em(helpText("Note: Main job very or somewhat related to program. Based on employed respondents.")), style="text-align:center;"))),
            fluidRow(uiOutput("plot_program_relate_summary"))
            
          ),
            box(width=12, 
            title = uiOutput("title5"),
            status = "success",
            solidHeader = TRUE,
            collapsible = TRUE,
            fluidRow(column(width=8,offset=1,withSpinner(plotlyOutput("plot_program_skill", height = "65vh")))),
            fluidRow(column(12, div(tags$em(helpText("Note: Knowledge and skills gained in program very or somewhat useful in performing job. Based on employed respondents.")), style="text-align:center;"))),
            fluidRow(uiOutput("plot_program_skill_summary"))
          ),
          
          fluidRow(viewMoreButton(sectionID = "summary",style="background-color: #8dc63f;color: white;border-color: #ddd;border-radius: 0;"),style="padding: 0 5px;text-align: center;"))
    )
  )
),
tags$div(class="footer-wrapper",style = "background-color:#003366;",
         tags$footer(class="footer",
                     
                     tags$div(class="container", style="background-color: #003366; display:flex; justify-content:center; text-align:center; height:46px;width:100%;",
                              
                              tags$ul(style="display:flex; flex-direction:row; flex-wrap:wrap; margin:0; list-style:none; align-items:center; height:100%;",
                                      
                                      tags$li(a(href="https://www2.gov.bc.ca/gov/content/home", "Home", style="font-size:1em; font-weight:normal; color:white; padding-left:5px; padding-right:5px; border-right:1px solid #4b5e7e;")),
                                      
                                      tags$li(a(href="https://www2.gov.bc.ca/gov/content/home/disclaimer", "Disclaimer", style="font-size:1em; font-weight:normal; color:white; padding-left:5px; padding-right:5px; border-right:1px solid #4b5e7e;")),
                                      
                                      tags$li(a(href="https://www2.gov.bc.ca/gov/content/home/privacy", "Privacy", style="font-size:1em; font-weight:normal; color:white; padding-left:5px; padding-right:5px; border-right:1px solid #4b5e7e;")),
                                      
                                      tags$li(a(href="https://www2.gov.bc.ca/gov/content/home/accessibility", "Accessibility", style="font-size:1em; font-weight:normal; color:white; padding-left:5px; padding-right:5px; border-right:1px solid #4b5e7e;")),
                                      
                                      tags$li(a(href="https://www2.gov.bc.ca/gov/content/home/copyright", "Copyright", style="font-size:1em; font-weight:normal; color:white; padding-left:5px; padding-right:5px; border-right:1px solid #4b5e7e;")),
                                      
                                      tags$li(a(href="http://outcomes.bcstats.gov.bc.ca/ContactUs/ContactStudentOutcomes.aspx", "Contact", style="font-size:1em; font-weight:normal; color:white; padding-left:5px; padding-right:5px; border-right:1px solid #4b5e7e;"))
                                      
                              )
                     )
         )
)
))




           