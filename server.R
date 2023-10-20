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

# Functions ---------------------------------------------------------------
gender_age_function <- function(male, female, age, satisfaction) {
  div(
    class = "genderage",
    div(
      div("Gender",
        style = "color:#2A64AB; font-size: calc(9px + 1vw);
          font-weight: bold; padding: 7px 10px; text-align: center"
      ),
      div(
        class = "imgtext",
        tags$img(
          src = "img/People.png",
          width = "auto", height = "60%",
          style = "vertical-align: middle;
                   max-weight: 100%; float: left;"
        ),
        div(
          class = "gender",
          div(
            class = "malefemale",
            h1(male),
            h1("were male")
          ),
          div(
            class = "malefemale",
            h1(female),
            h1("were female")
          )
        )
      )
    ),
    div(
      div("Median age",
        style = "color: #2A64AB; font-size: calc(9px + 1vw);
            font-weight: bold; padding: 7px 10px; text-align: center;"
      ),
      div(
        class = "age",
        tags$img(
          src = "img/Birthday_cake.png",
          width = "auto", height = "60%", style = "float:left;"
        ),
        h1(id = "age1", round2(age, 0))
      )
    ),
    div(
      div("Satisfaction rate",
        style = "color:#2A64AB; font-size: calc(9px + 1vw);
            font-weight: bold; padding: 7px 10px; text-align: center"
      ),
      div(
        class = "age",
        tags$img(
          src = "img/satisfaction.png",
          width = "auto", height = "60%", style = "float:left;"
        ),
        h1(id = "age1", satisfaction)
      )
    )
  )
}

box_wrapper <- function(value, title) {
  div(
    class = "boxwrapper",
    p(id = "p1", value),
    p(id = "p2", title)
  )
}

box_wrapper_text <- function(value, title) {
  div(
    class = "boxwrapper",
    p(id = "p3", value),
    p(id = "p2", title)
  )
}

box_wrapper_blue <- function(value, title) {
  div(
    class = "boxwrapper2",
    p(id = "p1", value),
    p(id = "p2", title)
  )
}

box_wrapper_blue_text <- function(value, title) {
  div(
    class = "boxwrapper2",
    p(id = "p3", value),
    p(id = "p2", title)
  )
}

chart_title <- function(title) {
  div(class = "chart_title", title)
}

imageWrapper2 <- function(value, title = "", img, width = "100%", height = "200px") {
  div(
    style = "background: #fff; margin-bottom: 8px; color: #2A64AB;",
    div(title,
      style = "background: #fff; color: #2A64AB; font-size: calc(9px + 1vw);
          font-weight: bold; padding: 7px 10px;
          text-align: center"
    ),
    div(
      style = "width: 33.3%; height: 120px; margin:0 auto; display:flex;
        align-items:center; justify-content: center;",
      tags$img(
        src = img,
        style = "height: 65%; width: auto;
                   vertical-align: middle; float:left;"
      ),
      p(value,
        style = "margin:5%; font-weight: bold;
            font-size: calc(15px + 1.5vw);"
      )
    )
  )
}

imageWrapper_text <- function(value, title = "", img, width = "100%", height = "200px") {
  div(
    style = "background: #fff;
      margin-bottom: 8px; color:#2A64AB;",
    div(title,
      style = "background: #fff; color: #2A64AB; font-size: 1.5vw;
          font-weight: bold; padding: 7px 10px; text-align: center;"
    ),
    div(
      style = "width:33.3%; height: 120px; margin:0 auto;
        display: flex; align-items: center; justify-content: center;",
      tags$img(
        src = img,
        style = "height: 65%; width:auto;
                   vertical-align: middle; float:left;"
      ),
      p(value,
        style = "margin:5%; font-weight: bold;
            font-size: calc(9px + 1vw);"
      )
    )
  )
}


# Server ------------------------------------------------------------------
shinyServer(function(input, output, session) {

  toggleModal(session, "startupModal", toggle = "open")

  # suppress warnings
  storeWarn <- getOption("warn")
  options(warn = -1)
  # 1: student group filter
  output$student_group <- renderUI({
    choices <- students %>% arrange(CREDENTIAL) %>% pull(CREDENTIAL) %>% unique() %>% as.character()
    div(
      style = "display: inline-block;",
      selectizeInput("student_group", "1. Student Group",
        choices = choices,
        selected = "Certificate",
        width = 315
      )
    )
  })
  # 2: institution filter
  output$institution <- renderUI({
    div(
      style = "display: inline-block;",
      selectizeInput("institution", "2. Institution",
        choices = as.character(unique(students$INSTITUTION_NAME)),
        width = 315,
        selected = NULL
      )
    )
  })
  # 3: program filter
  output$program <- renderUI({
    div(
      style = "display: inline-block;",
      selectizeInput("program", "3. Program Area",
        choices =
          as.character(unique(
            students$PROGRAM_AREA_NAME[
              students$student_group == as.character(unique(students$student_group))[1] &
                students$INSTITUTION_NAME == as.character(unique(students$INSTITUTION_NAME[students$student_group == as.character(unique(students$student_group))[1]]))[1]
            ]
          )),
        width = 315, selected = "Overall"
      )
    )
  })

  all_inst <- c("All Institutions (public & private)", "All Institutions")
  # 4: program name filter
  output$program_name <- renderUI({
    if (is.null(input$institution)) {
      return(NULL)
    } else if (!(input$institution %in% all_inst)) {
      div(
        style = "display: inline-block;",
        selectizeInput("program_name", "4. Program Name",
          choices =
            as.character(unique(students$PROGRAM_NAME[students$PROGRAM_AREA_NAME == input$program])),
          width = 315, selected = "All Programs"
        )
      )
    } else {
      return(NULL)
    }
  })
  
  # 5: screenshot button
  output$screenshot_pdf <- renderUI({
    capture_pdf(selector="#body", filename = paste0("BC SO Data Viewer - ", input$tabs),
                icon("download"), "Save as PDF",
                style = "color: #000;
                 display: inline-block;
                 background-color:#fff;
                 border: 1px dash transparent;
                 border-color:#00245d;")
  })


  # Ensure that filters are updated properly
  observeEvent(input$student_group, {
    updateSelectInput(session, "institution",
      choices = unique(students$INSTITUTION_NAME[students$CREDENTIAL == input$student_group])
    )
  })

  observeEvent(c(input$student_group, input$institution), {
    updateSelectInput(session, "program",
      choices = sort(unique(students$PROGRAM_AREA_NAME[students$CREDENTIAL == input$student_group &
        students$INSTITUTION_NAME == input$institution])), selected = "Overall"
    )
  })

  observeEvent(c(input$student_group, input$institution, input$program), {
    updateSelectInput(session, "program_name",
      choices = sort(unique(students$PROGRAM_NAME[students$CREDENTIAL == input$student_group &
        students$INSTITUTION_NAME == input$institution &
        students$PROGRAM_AREA_NAME == input$program])), selected = "All Programs"
    )
  })

  # Create reactive values for input data
  filtered_data <- reactive({
    input_CREDENTIAL <- ifelse(is.null(input$student_group), "Associate Degree", input$student_group)
    input_institution <- ifelse(is.null(input$institution), "All Institutions", input$institution)
    input_program <- ifelse(is.null(input$program), "Overall", input$program)
    input_program_name <- ifelse(is.null(input$program_name), "All Programs", input$program_name)

    req(input$student_group)
    req(input$institution)
    req(input$program)
    ifelse(!(input$institution %in% all_inst), req(input$program_name), TRUE)

    students[students$CREDENTIAL == input_CREDENTIAL, ] %>%
      filter(INSTITUTION_NAME %in% input_institution) %>%
      filter(PROGRAM_AREA_NAME %in% input_program) %>%
      filter(if (!(input$institution %in% all_inst)) PROGRAM_NAME %in% input_program_name else TRUE)
  })

  #### Side bar------
  output$respondents <- renderUI({
    div(format(filtered_data()$RESPONDENTS, big.mark = ","),
      style = "text-align: left; vertical-align:middle; font-size:1.9vw; font-weight: bold;padding: 10px;", br(),
      div("Respondents", style = "text-align: left; vertical-align:middle; color: white; font-size: 0.9vw; font-weight: normal;")
    )
  })
  # response rate
  output$response_rate <- renderUI({
    div(paste0(round2(filtered_data()$RESPONSE_RATE * 100, 0), "%"),
      style = "text-align: left; vertical-align:middle; font-size:1.9vw; font-weight: bold; padding:10px;", br(),
      div("Response Rate", style = "text-align: left; vertical-align:middle;color: white;font-size: 0.9vw; font-weight: normal;")
    )
  })
  
  ## Main body -----

  # Gender age under summary section
  output$gender_age <- renderUI({
    req(filtered_data()$MALE)
    req(filtered_data()$AGE)

    male <- if (filtered_data()$MALE == -3) {
      "Fewer than 5%"
    } else if (filtered_data()$MALE == -4) {
      "More than 95%"
    } else if (filtered_data()$MALE == -5) {
      "The majority"
    } else if (filtered_data()$MALE == -99) {
      "Too few responses to report"
    } else if (filtered_data()$MALE == -1) {
      ""
    } else {
      paste(round2(filtered_data()$MALE * 100, 0), "%", sep = "")
    }

    female <- if (filtered_data()$FEMALE == -3) {
      "Fewer than 5%"
    } else if (filtered_data()$FEMALE == -4) {
      "More than 95%"
    } else if (filtered_data()$FEMALE == -2) {
      "The majority"
    } else if (filtered_data()$FEMALE == -99) {
      "Too few responses to report"
    } else if (filtered_data()$FEMALE == -1) {
      ""
    } else {
      paste(round2(filtered_data()$FEMALE * 100, 0), "%", sep = "")
    }

    if (female == "") {
      div(
        class = "genderage",
        div(
          div("Gender", style = "color:#2A64AB; font-size: calc(9px + 1vw);
                font-weight: bold;padding: 7px 10px; text-align: center"),
          div(
            class = "imgtext",
            tags$img(
              src = "img/People.png", width = "auto", height = "60%",
              style = "vertical-align: middle;max-weight: 100%; float:left;"
            ),
            div(
              class = "gender",
              div(
                class = "malefemale",
                h1(male),
                h1("were male")
              )
            )
          )
        ),
        div(
          div("Median age", style = "color:#2A64AB; font-size: calc(9px + 1vw);
                font-weight: bold;padding: 7px 10px; text-align: center"),
          div(
            class = "age",
            tags$img(
              src = "img/Birthday_cake.png", width = "auto", height = "60%",
              style = "float:left;"
            ),
            h1(id = "age1", round2(filtered_data()$AGE, 0))
          )
        ),
        div(
          div("Satisfaction rate", style = "color: #2A64AB; font-size: calc(9px + 1vw);
                font-weight: bold; padding: 7px 10px; text-align: center"),
          div(
            class = "age",
            tags$img(src = "img/satisfaction.png", width = "auto", height = "60%", style = "float:left;"),
            h1(id = "age1", paste0(round2(filtered_data()$satisfaction_rate * 100, 0), "%"))
          )
        )
      )
    } else if (male == "") {
      div(
        class = "genderage",
        div(
          div("Gender", style = "color:#2A64AB; font-size: calc(9px + 1vw);
                font-weight: bold; padding: 7px 10px; text-align: center"),
          div(
            class = "imgtext",
            tags$img(
              src = "img/People.png", width = "auto", height = "60%",
              style = "vertical-align: middle;max-weight: 100%; float:left;"
            ),
            div(
              class = "gender",
              div(
                class = "malefemale",
                h1(female),
                h1("were female")
              )
            )
          )
        ),
        div(
          div("Median age", style = "color:#2A64AB; font-size: calc(9px + 1vw);
                font-weight: bold; padding: 7px 10px; text-align: center"),
          div(
            class = "age",
            tags$img(src = "img/Birthday_cake.png", width = "auto", height = "60%", style = "float:left;"),
            h1(id = "age1", round2(filtered_data()$AGE, 0))
          )
        ),
        div(
          div("Satisfaction rate", style = "color:#2A64AB; font-size: calc(9px + 1vw);
                font-weight: bold; padding: 7px 10px; text-align: center"),
          div(
            class = "age",
            tags$img(src = "img/satisfaction.png", width = "auto", height = "60%", style = "float:left;"),
            h1(id = "age1", paste0(round2(filtered_data()$satisfaction_rate * 100, 0), "%"))
          )
        )
      )
    } else {
      gender_age_function(
        male, female, filtered_data()$AGE,
        paste0(round2(filtered_data()$satisfaction_rate * 100, 0), "%")
      )
    }
  })

  # quality of education
  output$quality_education <- renderUI({
    req(filtered_data()$instruction)

    if (input$student_group == "Bachelor's Degree") {
      box_wrapper(
        paste0(round2(filtered_data()$instruction * 100, 0), "%"),
        HTML("said the", "<b>", "quality of instruction", "</b>", "<br>", "was very good or good")
      )
    } else {
      box_wrapper(
        paste0(round2(filtered_data()$instruction * 100, 0), "%"),
        HTML("said the", "<b>", "quality of instruction", "</b>", "<br>", "was very good, good, or adequate")
      )
    }
  })
  # full_time employment
  output$employed_full_time <- renderUI({
    req(filtered_data()$EMPLOY_FULL_TIME)

    employed_full_time <- if (filtered_data()$EMPLOY_FULL_TIME == -3) {
      "Fewer than 5%"
    } else if (filtered_data()$EMPLOY_FULL_TIME == -4) {
      "More than 95%"
    } else if (filtered_data()$EMPLOY_FULL_TIME == -8) {
      "The minority"
    } else if (filtered_data()$EMPLOY_FULL_TIME == -9) {
      "The majority"
    } else if (filtered_data()$EMPLOY_FULL_TIME == -99) {
      "Too few responses to report"
    } else {
      paste(round2(filtered_data()$EMPLOY_FULL_TIME * 100, 0), "%", sep = "")
    }

    # Changing font size based on the value, if there is a suppression the text size should be smaller
    if (nchar(employed_full_time) > 4) {
      box_wrapper_blue_text(
        employed_full_time,
        HTML("of employed respondents", "<br>", "were", "<b>", "working full-time", "<b/>")
      )
    } else {
      box_wrapper_blue(
        employed_full_time,
        HTML("of employed respondents", "<br>", "were", "<b>", "working full-time", "<b/>")
      )
    }
  })
  # further studies
  output$further_studies <- renderUI({
    req(filtered_data()$FURTH_STUDIES)
    title_alternate <- if (filtered_data()$CREDENTIAL == "Trades Foundation") {
      HTML("<b>", "obtained employment as an apprentice", "</b>")
    } else if (filtered_data()$CREDENTIAL == "Apprenticeship") {
      HTML("<b>", "received their Certificate of Qualification", "</b>")
    } else {
      HTML("<b>", "took further studies", "<b/>")
    }
    box_wrapper_blue(paste0(round2(filtered_data()$FURTH_STUDIES * 100, 0), "%"), title_alternate)
  })
  # the number of employed respondents in a related job
  output$related_program <- renderUI({
    req(filtered_data()$JOB_PROGRAM_RELATED)
    box_wrapper(
      paste0(round2(filtered_data()$JOB_PROGRAM_RELATED * 100, 0), "%"),
      HTML("of employed respondents", "<br>", "were", "<b>", " in a job related to their program", "<b/>")
    )
  })

  # reactive value - plot for different skills
  data_skill_plot <- reactive({
    req(filtered_data()$Read)
    req(filtered_data()$Write_Clearly)
    req(filtered_data()$Speak_Clearly)
    req(filtered_data()$Work_With_Others)
    req(filtered_data()$Think_Critically)
    req(filtered_data()$Resolve_Issues)
    req(filtered_data()$Learn_Independently)

    Skills_Development <- c(
      "Read and comprehend material", "Write clearly and concisely",
      "Speak effectively", "Work effectively with others", "Analyse and think critically",
      "Resolve issues or problems", "Learn independently"
    )
    values <- c(
      filtered_data()$Read, filtered_data()$Write_Clearly, filtered_data()$Speak_Clearly,
      filtered_data()$Work_With_Others, filtered_data()$Think_Critically, filtered_data()$Resolve_Issues,
      filtered_data()$Learn_Independently
    )
    data <- data.frame(Skills_Development, values)
    return(data)
  })
  # plot for skills
  output$plot_skills <- renderPlotly({
    plot_ly(
      x = data_skill_plot()$values,
      y = ~ reorder(data_skill_plot()$Skills_Development, data_skill_plot()$values),
      type = "bar", marker = list(color = "rgb(26,63,114)"), hoverinfo = "none"
    ) %>%
      layout(
        title = "", titlefont = list(
          family = "Myriad-Pro",
          size = 16
        ),
        orientation = "h",
        xaxis = list(title = "", tickformat = ".0%", zeroline = FALSE, fixedrange = TRUE, range = c(0, 1.1)),
        yaxis = list(title = "", fixedrange = TRUE),
        margin = list(l = 220, pad = 7)
      ) %>%
      add_annotations(
        xref = "x", yref = "y",
        x = data_skill_plot()$values,
        y = reorder(data_skill_plot()$Skills_Development, data_skill_plot()$values),
        text = paste(round2(data_skill_plot()$values * 100, 0), "%", sep = ""),
        showarrow = FALSE, xanchor = "left", xshift = 3, opacity = 0.7
      ) %>%
      config(displayModeBar = F)
  })

  # EMPLOYMENT
  # Percentages of students in labour Force
  output$labour <- renderUI({
    req(filtered_data()$IN_LABR_MKT)
    imageWrapper2(paste(round2(filtered_data()$IN_LABR_MKT * 100, 0), "%", sep = ""),
      "In labour force",
      img = "img/Gears.png"
    )
  })

  # wage - conditional - bachelor's degree display salary wage
  output$wage <- renderUI({
    req(input$student_group)
    req(filtered_data()$SALARY_WAGE)
    wage <- if (filtered_data()$SALARY_WAGE == -99) {
      "Too few responses to report"
    } else {
      paste0("$", format(round2(filtered_data()$SALARY_WAGE, 0), big.mark = ","))
    }
    if (input$student_group == "Bachelor's Degree" & wage != "Too few responses to report") {
      imageWrapper2(wage, "Median annual salary", img = "img/Dollar.png")
    } else if (input$student_group == "Bachelor's Degree") {
      imageWrapper_text(wage, "Median annual salary", img = "img/Dollar.png")
    } else if (nchar(wage) > 5) {
      imageWrapper_text(wage, "Median hourly wage", img = "img/Dollar.png")
    } else {
      imageWrapper2(wage, "Median hourly wage", img = "img/Dollar.png")
    }
  })

  # Unemployment rate
  output$unemploy_rate <- renderUI({
    req(filtered_data()$UNEMPLOYED)
    unemployed <- if (filtered_data()$UNEMPLOYED == -3) {
      "Fewer than 5%"
    } else if (filtered_data()$UNEMPLOYED == -4) {
      "More than 95%"
    } else if (filtered_data()$UNEMPLOYED == -12) {
      HTML("Minority are unemployed")
    } else if (filtered_data()$UNEMPLOYED == -13) {
      HTML("Majority are unemployed")
    } else if (filtered_data()$UNEMPLOYED == -99) {
      "Too few responses to report"
    } else {
      paste(round2(filtered_data()$UNEMPLOYED * 100, 1), "%", sep = "")
    }

    if (nchar(unemployed) > 5) {
      imageWrapper_text(unemployed, "Unemployment rate", img = "img/Job search.png")
    } else {
      imageWrapper2(unemployed, "Unemployment rate", img = "img/Job search.png")
    }
  })

  # Employment rate
  output$employment_rate <- renderUI({
    req(filtered_data()$EMPLOYED)

    employed <- if (filtered_data()$EMPLOYED == -3) {
      "Fewer than 5%"
    } else if (filtered_data()$EMPLOYED == -4) {
      "More than 95%"
    } else if (filtered_data()$EMPLOYED == -10) {
      HTML("The minority")
    } else if (filtered_data()$EMPLOYED == -11) {
      HTML("The majority")
    } else if (filtered_data()$EMPLOYED == -99) {
      "Too few responses to report"
    } else {
      paste(round2(filtered_data()$EMPLOYED * 100, 0), "%", sep = "")
    }

    if (nchar(employed) < 5) {
      div(
        style = "background: #E0EBF6; margin-bottom: 8px; display: flex;
          align-items:center; justify-content:center;
          border-radius: 5px; border: 2px solid #E0EBF6; height:9vh;",
        span(employed,
          style = "color: #2A64AB; font-size:calc(14px + 1.5vw);
             margin: 1%; font-weight: bold;"
        ),
        span(HTML("of all respondents were employed"),
          style = "font-size:calc(8px + 1vw); color: #2A64AB;"
        )
      )
    } else {
      div(
        style = "background: #E0EBF6; margin-bottom: 8px;
          display: flex; align-items:center; justify-content:center;
          border-radius: 5px; border: 2px solid #E0EBF6; height:9vh;",
        span(employed, style = "color: #2A64AB; font-size:calc(10px + 1vw);
               margin: 1%; font-weight: bold;"),
        span(HTML("of all respondents were employed"),
          style = "font-size:calc(8px + 1vw); color: #2A64AB;"
        )
      )
    }
  })

  # Employed full-time
  output$full_time <- renderUI({
    req(filtered_data()$EMPLOY_FULL_TIME)

    employed_full_time <- if (filtered_data()$EMPLOY_FULL_TIME == -3) {
      "Fewer than 5%"
    } else if (filtered_data()$EMPLOY_FULL_TIME == -4) {
      "More than 95%"
    } else if (filtered_data()$EMPLOY_FULL_TIME == -8) {
      HTML("The minority")
    } else if (filtered_data()$EMPLOY_FULL_TIME == -9) {
      HTML("The majority")
    } else if (filtered_data()$EMPLOY_FULL_TIME == -99) {
      "Too few responses to report"
    } else {
      paste(round2(filtered_data()$EMPLOY_FULL_TIME * 100, 0), "%", sep = "")
    }

    if (nchar(employed_full_time) > 4) {
      box_wrapper_text(employed_full_time, HTML("were", "<b>", "working full-time", "<b/>"))
    } else {
      box_wrapper(employed_full_time, HTML("were", "<b>", "working full-time", "<b/>"))
    }
  })

  output$self <- renderUI({
    req(filtered_data()$SELF_EMPLOYED)

    self_employed <- if (filtered_data()$SELF_EMPLOYED == -3) {
      "Fewer than 5%"
    } else if (filtered_data()$SELF_EMPLOYED == -4) {
      "More than 95%"
    } else if (filtered_data()$SELF_EMPLOYED == -6) {
      HTML("The minority")
    } else if (filtered_data()$SELF_EMPLOYED == -7) {
      HTML("The majority")
    } else if (filtered_data()$SELF_EMPLOYED == -99) {
      "Too few responses to report"
    } else {
      paste(round2(filtered_data()$SELF_EMPLOYED * 100, 0), "%", sep = "")
    }
    if (nchar(self_employed) > 4) {
      box_wrapper_blue_text(self_employed, HTML("were", "<b>", "self-employed", "<b/>"))
    } else {
      box_wrapper_blue(self_employed, HTML("were", "<b>", "self-employed", "<b/>"))
    }
  })

  # were in a job related to their program
  output$related_program_emp <- renderUI({
    req(filtered_data()$JOB_PROGRAM_RELATED)
    box_wrapper_blue(
      paste0(round2(filtered_data()$JOB_PROGRAM_RELATED * 100, 0), "%"),
      HTML("were", "<b>", "in a job related to their program", "<b/>")
    )
  })
  # knowledge and skills gained were useful
  output$knowledge_skill_useful <- renderUI({
    req(filtered_data()$USEFUL_PERFORM_JOB)
    box_wrapper(
      paste0(round2(filtered_data()$USEFUL_PERFORM_JOB * 100, 0), "%"),
      HTML("said the knowledge and skills gained", "<br>", "were", "<b>", "useful in performing their job", "<b/>")
    )
  })

  output$demographics <- renderUI({
    HTML("Summary Indicators")
  })

  # text for skill development section
  output$text_satisfaction <- renderUI({
    div(HTML(paste("<em>", "Percentages are based on respondents who said that they were very satisfied or satisfied with their education.", "</em>")),
      style = "text-align: center;"
    )
  })

  # text for skill development
  output$text3 <- renderUI({
    div(HTML(paste(
      "<em>", "Former students were asked how helpful their program was in their development of a number of skills.",
      "<br>",
      "Percentages are based on respondents who said their program was very helpful or helpful in developing the skill.",
      "</em>", "</p>"
    )),
    style = "text-align: center;"
    )
  })

  output$text_skill <- renderUI({
    div(HTML(paste(
      "<em>", "Select a skill from the dropdown menu on the right to view results by program area.", "<br>",
      "Percentages are based on respondents who said their program was very helpful or helpful in developing the skill.",
      "</em>", "</p>"
    )),
    style = "text-align: center;"
    )
  })
  # text for related job
  output$text_related_job <- renderUI({
    div(HTML(paste(
      "<em>", "Percentages are based on employed respondents who said their main job was very related or somewhat related to their program.",
      "</em>"
    )),
    style = "text-align: center;"
    )
  })
  # text for knowledge and skills
  output$text_knowledge_skill <- renderUI({
    div(HTML(paste(
      "<em>", "Percentages are based on employed respondents who said the knowledge and skills they gained were very useful or somewhat useful in performing their job.",
      "</em>"
    )),
    style = "text-align: center;"
    )
  })
  # text above the grid boxes
  output$text_above_grid <- renderUI({
    div(HTML(paste("<em>", "of those who were employed…", "</em>")),
      style = "text-align: center;font-size: calc(9px + 1vw);"
    )
  })

  # text for summary section
  output$text1 <- renderUI({
    HTML(
      "<em>", "Former post-secondary students were asked about their educational experiences, subsequent employment, and further studies. Here is a summary of the results:",
      "</em>"
    )
  })

  output$satisfaction_text <- renderUI({
    if (is.null(input$program_name)) {
      return(NULL)
    } else if (input$program_name != "All Programs") {
      HTML("<strong>", "See more results by program name...", "</strong>")
    } else {
      HTML("<strong>", "See more results by program area...", "</strong>")
    }
  })

  # Reactive value for Further Studies Plot under Demographics
  data_plot_all <- reactive({
    req(input$student_group)
    req(input$institution)
    req(input$program)

    if (!(input$institution %in% all_inst)) {
      req(input$program_name)
    }

    students[students$CREDENTIAL == input$student_group, ] %>%
      filter(INSTITUTION_NAME %in% input$institution) %>%
      filter(PROGRAM_AREA_NAME %in% input$program) %>%
      mutate(
        fillColor = ifelse(PROGRAM_NAME == input$program_name,
          paste("rgba(", paste(col2rgb("#1a3f72"), collapse = ", "), ",1)"),
          paste("rgba(", paste(col2rgb("#1a3f72"), collapse = ", "), ",0.5)")
        )
      ) %>%
      mutate(
        fillColor_skill = ifelse(PROGRAM_NAME == input$program_name,
          paste("rgba(", paste(col2rgb("#1a3f72"), collapse = ", "), ",1)"),
          paste("rgba(", paste(col2rgb("#1a3f72"), collapse = ", "), ",0.5)")
        )
      )
  })

  # reactive value
  data_plot_all_programs <- reactive({
    req(input$student_group)
    req(input$institution)
    req(input$program)

    students[students$CREDENTIAL == input$student_group, ] %>%
      filter(INSTITUTION_NAME %in% input$institution) %>%
      filter((PROGRAM_NAME == "All Programs") | (PROGRAM_NAME == "")) %>%
      mutate(
        fillColor =
          if (input$program == "Overall") {
            dplyr::case_when(
              PROGRAM_AREA_NAME == input$program ~ paste("rgba(", paste(col2rgb("#1a3f72"), collapse = ", "), ", 1)"),
              PROGRAM_AREA_NAME != input$program ~ paste("rgba(", paste(col2rgb("#1a3f72"), collapse = ", "), ", 0.5)"),
            )
          } else if (input$program != "Overall") {
            dplyr::case_when(
              PROGRAM_AREA_NAME == "Overall" ~ paste("rgba(", paste(col2rgb("#1a3f72"), collapse = ", "), ",1)"),
              PROGRAM_AREA_NAME == input$program ~ paste("rgba(", paste(col2rgb("#FCBA19"), collapse = ",  "), ", 1)"),
              PROGRAM_AREA_NAME != input$program ~ paste("rgba(", paste(col2rgb("#1a3f72"), collapse = ",  "), ", 0.5)")
            )
          }
      ) %>%
      mutate(
        fillColor_skill = ifelse(PROGRAM_AREA_NAME == input$program, paste("rgba(", paste(col2rgb("#1a3f72"), collapse = ", "), ", 1)"),
          paste("rgba(", paste(col2rgb("#1a3f72"), collapse = ", "), ", 0.5)")
        )
      )
  })


  # Satisfaction with education by program area under summary section
  output$plot_program_satisfaction <- renderPlotly({
    req(data_plot_all_programs()$PROGRAM_AREA_NAME2)

    plot_ly(
      x = data_plot_all_programs()$satisfaction_rate,
      y = ~ reorder(data_plot_all_programs()$PROGRAM_AREA_NAME2, data_plot_all_programs()$satisfaction_rate),
      type = "bar",
      color = ~ I(data_plot_all_programs()$fillColor), hoverinfo = "none"
    ) %>%
      layout(
        orientation = "h",
        title = "", titlefont = list(
          family = "Myriad-Pro",
          size = 16
        ),
        xaxis = list(
          title = "", tickformat = ".0%", zeroline = FALSE,
          fixedrange = TRUE, range = c(0, 1.1)
        ),
        yaxis = list(title = "", fixedrange = TRUE),
        margin = list(l = 220, pad = 7)
      ) %>%
      add_annotations(
        xref = "x", yref = "y",
        x = data_plot_all_programs()$satisfaction_rate,
        y = reorder(
          data_plot_all_programs()$PROGRAM_AREA_NAME2,
          data_plot_all_programs()$satisfaction_rate
        ),
        text = paste0(round2(data_plot_all_programs()$satisfaction_rate * 100, 0), "%"),
        showarrow = FALSE, xanchor = "left", xshift = 3, opacity = 0.7
      ) %>%
      config(displayModeBar = F)
  })


  # Working in a program-related job by program area plot under employment
  output$plot_program_relate <- renderPlotly({
    req(data_plot_all_programs()$PROGRAM_AREA_NAME2)

    plot_ly(
      x = data_plot_all_programs()$JOB_PROGRAM_RELATED,
      y = ~ reorder(
        data_plot_all_programs()$PROGRAM_AREA_NAME2,
        data_plot_all_programs()$JOB_PROGRAM_RELATED
      ),
      type = "bar",
      color = ~ I(data_plot_all_programs()$fillColor), hoverinfo = "none"
    ) %>%
      layout(
        orientation = "h",
        title = "", titlefont = list(
          family = "Myriad-Pro",
          size = 16
        ),
        xaxis = list(
          title = "", tickformat = ".0%", zeroline = FALSE,
          fixedrange = TRUE, range = c(0, 1.1)
        ),
        yaxis = list(title = "", fixedrange = TRUE),
        margin = list(l = 220, pad = 7)
      ) %>%
      add_annotations(
        xref = "x", yref = "y",
        x = data_plot_all_programs()$JOB_PROGRAM_RELATED,
        y = reorder(
          data_plot_all_programs()$PROGRAM_AREA_NAME2,
          data_plot_all_programs()$JOB_PROGRAM_RELATED
        ),
        text = paste0(round2(data_plot_all_programs()$JOB_PROGRAM_RELATED * 100, 0), "%"),
        showarrow = FALSE, xanchor = "left", xshift = 3, opacity = 0.7
      ) %>%
      config(displayModeBar = F)
  })

  # Knowledge and skills gained useful in performing their job by program area plot under employment
  output$plot_program_skill <- renderPlotly({
    req(data_plot_all_programs()$PROGRAM_AREA_NAME2)

    plot_ly(
      x = data_plot_all_programs()$USEFUL_PERFORM_JOB,
      y = ~ reorder(
        data_plot_all_programs()$PROGRAM_AREA_NAME2,
        data_plot_all_programs()$USEFUL_PERFORM_JOB
      ),
      type = "bar",
      color = ~ I(data_plot_all_programs()$fillColor), hoverinfo = "none"
    ) %>%
      layout(
        orientation = "h",
        title = "", titlefont = list(
          family = "Myriad-Pro",
          size = 16
        ),
        xaxis = list(
          title = "", tickformat = ".0%", zeroline = FALSE,
          fixedrange = TRUE, range = c(0, 1.1)
        ),
        yaxis = list(title = "", fixedrange = TRUE),
        margin = list(l = 220, pad = 7)
      ) %>%
      add_annotations(
        xref = "x", yref = "y",
        x = data_plot_all_programs()$USEFUL_PERFORM_JOB,
        y = reorder(
          data_plot_all_programs()$PROGRAM_AREA_NAME2,
          data_plot_all_programs()$USEFUL_PERFORM_JOB
        ),
        text = paste0(round2(data_plot_all_programs()$USEFUL_PERFORM_JOB * 100, 0), "%"),
        showarrow = FALSE, xanchor = "left", xshift = 3, opacity = 0.7
      ) %>%
      config(displayModeBar = F)
  })

  # Get the data set with the appropriate name from the selected input
  value_select <- reactive({
    req(input$select)
    data_plot_all()[, input$select]
  })

  value_select_satisfaction <- reactive({
    req(input$select)
    data_plot_all_programs()[, input$select]
  })

  output$plot_program_switch <- renderPlotly({
    req(data_plot_all_programs()$PROGRAM_AREA_NAME2)
    data_plot_all_programs() %>%
      plot_ly(
        x = value_select_satisfaction(),
        y = ~ reorder(
          data_plot_all_programs()$PROGRAM_AREA_NAME2,
          value_select_satisfaction()
        ), # or get(input$select)
        type = "bar",
        color = ~ I(data_plot_all_programs()$fillColor), hoverinfo = "none"
      ) %>%
      layout(
        title = "", titlefont = list(
          family = "Myriad-Pro",
          size = 16
        ),
        orientation = "h",
        xaxis = list(
          title = "", tickformat = ".0%", zeroline = FALSE,
          fixedrange = TRUE, range = c(0, 1.1)
        ),
        yaxis = list(title = "", fixedrange = TRUE),
        margin = list(l = 220, pad = 7)
      ) %>%
      add_annotations(
        xref = "x", yref = "y",
        x = value_select_satisfaction(),
        y = ~ reorder(data_plot_all_programs()$PROGRAM_AREA_NAME2, value_select_satisfaction()),
        text = paste0(round2(value_select_satisfaction() * 100, 0), "%"),
        showarrow = FALSE, xanchor = "left", xshift = 7, opacity = 0.7
      ) %>%
      config(displayModeBar = F)
  })

  output$title_box_satisfaction <- renderUI({
    HTML("Students have taken further studies")
  })

  data <- reactive({
    get(input$dataset)
  })

  output$title_select <- renderUI({
    chart_title("Skill development by program area")
  })

  output$title4 <- renderUI({
    chart_title("Working in a program-related job by program area")
  })

  output$satisfaction_edu <- renderUI({
    chart_title("Satisfaction with education by program area")
  })

  output$title5 <- renderUI({
    chart_title("Knowledge and skills gained useful in performing job by program area")
  })

  data <- reactiveVal()
  output$downloadData <- downloadHandler(
    filename = "Notes for the Student Outcomes Data Viewer - 2023-10-19.pdf",
    content = function(file) {
      file.copy("www/Notes for the Student Outcomes Data Viewer - 2023-10-19.pdf", file)
    }
  )

  output$draft <- renderUI({
    div(class = "watermark", "Draft", style = "opacity: 0.2;
    position: fixed; top: 60%; left:40%; font-size: 7vw;color:red;
        transform: rotate(-45deg);z-index: 9999;")
  })

  summary_results_program_name <- reactive({
    div(
      style = "padding: 5px; margin-left:10px;color: #2A64AB;",
      h5(HTML("<em>", "<strong>", "Results are based on:", "</strong>", "</em>")),
      h5(HTML("<em>", paste0(
        input$student_group, ",", " ", input$institution, ",", " ",
        input$program, ifelse(filtered_data()$PROGRAM_NAME == " ",
          " ", ", Program Name:"
        ), " ",
        filtered_data()$PROGRAM_NAME
      ), "</em>"))
    )
  })

  summary_results_program_area <- reactive({
    div(
      style = "padding: 5px; margin-left:10px; color: #2A64AB;",
      h5(HTML(
        "<em>", "<strong>", "Results are based on:", "</strong>",
        "</em>"
      )),
      h5(HTML(
        "<em>", paste0(
          input$student_group, ",", " ",
          input$institution, ",", " ",
          "Program Area:", " ", input$program
        ),
        "</em>"
      ))
    )
  })

  output$summary_filter <- renderUI({
    summary_results_program_name()
  })

  output$plot_satisfaction_summary <- renderUI({
    summary_results_program_area()
  })

  output$plot_skills_summary <- renderUI({
    summary_results_program_name()
  })

  output$plot_program_switch_summary <- renderUI({
    summary_results_program_area()
  })

  output$employment_summary <- renderUI({
    summary_results_program_name()
  })

  output$plot_program_relate_summary <- renderUI({
    summary_results_program_area()
  })

  output$plot_program_skill_summary <- renderUI({
    summary_results_program_area()
  })

  observeEvent(input$btn, {
    enable("element")
  })
  # filtering message
  output$note <- renderUI({
    div("This interactive tool allows you to filter by student group,
        institution, program area, and program name.",
      style = "font-style: italic; padding: 10px 10px 10px 30px;"
    )
  })
  
  ## Footer ----
  
  output$footer_1 <- output$footer_2 <- output$footer_3 <- renderUI({
    fluidRow(
      column(width = 4,
           div("Respondents: ", format(filtered_data()$RESPONDENTS, big.mark = ",")), 
           div("Response Rate: ", paste0(round2(filtered_data()$RESPONSE_RATE * 100, 0), "%"))),
      column(width = 8, 
           div("BC Student Outcomes Data from 2020 to 2022", style = "text-align: right"),
           div(a(href = "http://www.outcomes.bcstats.gov.bc.ca", "http://www.outcomes.bcstats.gov.bc.ca", target="_blank"), style = "text-align: right")))
  })
  
})


